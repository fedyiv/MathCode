function [y, cost, alpha, s] = STC_codeHDD(x, m, h_hat, rho)
% ���������� � ������ ��������� ���������� ������ ��� n == n1, n > n1.


num = size(m,2);
n = size(x,2);
%file='c:\test.stc';
threadId=num2str(round(1000*rand));
file=['d:\tmp\tempbuf-' threadId '.stc'];

if (size(rho,2) ~= n)
    s = 'length of rho and x must be equal';
    error(s);
end
alpha = num/n;
num = uint32(num);
n = uint32(n);
[h, w] = size(h_hat);
h = uint32(h);
w = uint32(w);
% ���� ��� ��� ����� ������ 0.5 �� ���� ����������� ������.
if (alpha > 0.5)
    s1 = 'alpha > 0.5. make x length min ';
    s2 = num2str(num*2);
    s = [s1, s2];
    error(s);
end



n1 = num*w;


if (n < n1)
    s1 = 'cover object is not enough. make x length min ';
    s2 = num2str(n1);
    s = [s1, s2];
    error (s);
elseif (n == n1)
    s = 'parameters are optimal';
else
    s1 = 'cover object is more than optimal. make x length ';
    s2 = num2str(n1);
    s = [s1, s2];
end

h1_hat = uint32(zeros(1, w));
for j = 1:w
    for i = h:-1:1
        h1_hat(j) = h1_hat(j) + h_hat(i+(j-1)*h)*2^(i-1);
    end
end
wght = zeros(2^h,1);
wght(2:end) = inf;
newwght = zeros(2^h,1);
indx = uint32(1);
indm = uint32(1);
w0 = 0;
w1 = 0;

MAX_ARRAY_SIZE=100; %MB
%Finding size of path which won't exceed MAX_ARRAY_SIZE

Ncols=floor((1024^2)*MAX_ARRAY_SIZE/(2^h));
nBlocks=uint32(floor(single(Ncols)/single(w)));



if(nBlocks==0)
    error(['Impossible to perform coding with current memory settings: allowed ' num2str(MAX_ARRAY_SIZE) ' required ' num2str(double(w*2^h)/1024^2)]);
end

path = uint8(inf*ones(2^h, w*nBlocks));


fid=fopen(file,'w');
fclose(fid);
z1=0;
z2=uint32(0);
z3=0;
Z2=uint32(zeros(2^h,1));

sh=2^h-1;
for i = 1:num
    shift=uint32(0);
    pathOffset=w*nBlocks*uint32(floor(single(i-1)/single(nBlocks)));
    
    if (num < h+i-1)
        shift=h+i-num-1;
        sh=uint32(binvec2dec([ones(1,h-shift) zeros(1,shift) ]));
    end
    
    
    for j = uint32(1:w)
        z1=uint32(bitand(h1_hat(j),sh));
        z3 = double(1 - x(indx))*rho(indx);
        z4=double(x(indx))*rho(indx);
        
        Z2=bitxor((1:2^h)'-1,z1);
        for k = 1:2^h
           
            w0 = wght(k) + z4;
            
            
            z2 = bitxor(k-1, z1);
            z2=Z2(k);
            
                        
            w1 = wght(z2+1) + z3;
            
            if (w1 < w0)
                path(k,indx-pathOffset) = 1;
              
                
            else
                path(k,indx-pathOffset) = 0;
              
            end
            newwght(k) = min(w0, w1);
        end
        indx = indx +1;
        wght = newwght;
    end
    for j = 1:1:(2^(h-1))
        wght(j) = wght(j + j -1 + m(indm));
    end
    wght(2^(h-1)+1:end) = inf;
    indm = indm + 1;
    
    if(~mod(single(i),single(nBlocks))||i==num)
        fid=fopen(file,'a');
        %saving current part of path in file
        fwrite(fid,reshape(path,[],1),'uint8');        
        fclose(fid);
        %setting path to infinity    
        if(i<num)
            path=(path+1)*inf;
        end
    end
    
end

%sum(path(~isinf(path)))
%sum(path(isinf(path)))
%sum(path(path==0))

y = x;
cost = wght(1);
state = 0;
indx = indx - 1;
indm = indm - 1;
sh0 = 2^h-1;

fid=fopen(file,'r');
byteBlck=int32(nBlocks*w*2^h);
fseek(fid,-2*byteBlck,'eof');
position=ftell(fid);
for i = num:-1:1
    
    pathOffset=w*nBlocks*uint32(floor(single(i-1)/single(nBlocks)));
    
    
    
     if(~mod(single(i),single(nBlocks)))
        
        
        pathf=fread(fid,byteBlck,'*uint8');
        path=reshape(pathf,2^h,w*nBlocks);        
        
        fseek(fid,-2*byteBlck,'cof');
     
                
     end
    
    
    
    
    shift=0;
    sh=sh0;
    if (num < h+i-1)
        shift=h+i-num-1;
        sh=binvec2dec([ones(1,h-shift) zeros(1,shift) ]);
    end
    
     
    
    state = 2*state + m(indm);
    for j = w:-1:1
        
         if(state>2^h)
            
        end
        
        y(indx) = path(state+1,indx-pathOffset);
        state = bitxor(state, y(indx)*bitand(h1_hat(j),sh));
        indx = indx - 1;
       
    end
    
    indm = indm - 1;
end

fclose(fid);

end