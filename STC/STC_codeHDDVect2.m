function [y, cost, alpha, s] = STC_codeHDDVect2(x, m, h_hat, rho)
% вычисления в данной программе происходят только при n == n1, n > n1.



num = size(m,2);
n = size(x,2);


%file='d:\test.stc';
threadId=num2str(round(1000000*rand));
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
% пока что при альфе больше 0.5 не буду расчитывать ничего.
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

MAX_ARRAY_SIZE=500; %MB
%Finding size of path which won't exceed MAX_ARRAY_SIZE

Ncols=floor((1024^2)*MAX_ARRAY_SIZE/(2^h));
nBlocks=uint32(floor(single(Ncols)/single(w)));



if(nBlocks==0)
    error(['Impossible to perform coding with current memory settings: allowed ' num2str(MAX_ARRAY_SIZE) ' required ' num2str(double(w*2^h)/1024^2)]);
end

path = inf*ones(2^h, w*min(nBlocks,num),'uint8');


fid=fopen(file,'w');
fclose(fid);
z1=0;
z2=uint32(0);
z3=0;
Z2=uint32(zeros(2^h,1));
W0=zeros(2^h,1);
W1=zeros(2^h,1);
J=(1:(2^(h-1)))';


sh=2^h-1;


blockZ2=1+bitxor(repmat((1:2^h)'-1,1,w),repmat(h1_hat,2^h,1)); 
Z3=double(1 - x((1:numel(x))')).*rho((1:numel(x))');
Z4=double( x((1:numel(x))')).*rho((1:numel(x))');

for i = 1:num
    shift=uint32(0);
    pathOffset=w*nBlocks*uint32(floor(single(i-1)/single(nBlocks)));
    
    
    if (num < h+i-1)
        shift=h+i-num-1;
        sh=uint32(binvec2dec([ones(1,h-shift) zeros(1,shift) ]));
        
        for j = uint32(1:w)
            z3 = double(1 - x(indx))*rho(indx); 
            z4=double(x(indx))*rho(indx);   
            z1=uint32(bitand(h1_hat(j),sh));        
            Z2=bitxor((1:2^h)'-1,z1);
            W0=wght+z4;
            W1=wght(Z2+1)+z3;
            path(:,indx-pathOffset)=(W1<W0);
            wght=min(W0,W1);
            indx = indx +1;
            
        end
    else
        
        
        for j = uint32(1:w)
            
            
            z3=Z3(indx);            
            z4=Z4(indx);
                        
        
            Z2=blockZ2(:,j);           
        
            
            W0=wght+z4;
            W1=wght(Z2)+z3;        
            path(:,indx-pathOffset)=(W1<W0);
            wght=min(W0,W1);
            indx = indx +1;
            
        end
        
        
    end
    
    
    
    
    
    wght(J)=wght(2*J-1+m(indm));
   
    wght(2^(h-1)+1:end) = inf;
    indm = indm + 1;
    
    if((~mod(single(i),single(nBlocks))||i==num)&& num>nBlocks)
        fid=fopen(file,'a');
        %saving current part of path in file
   
        fwrite(fid,reshape(path,[],1),'uint8');        
   
        fclose(fid);
        %setting path to infinity    
        if(i<num)
            path(:)=inf;            
        end
    end
  
    if(~mod(i,20000))
    disp(['i= ' num2str(i) ' from ' num2str(num) 'time ' num2str(toc)]);
    end
end


Z1=[];
Z2=[];
rho=[];
Z3=[];
Z4=[];
blockZ2=[];



y = x;
cost = wght(1);
state = 0;
indx = indx - 1;
indm = indm - 1;
sh0 = 2^h-1;

fid=fopen(file,'r');
byteBlck=int32(nBlocks*w*2^h);
fseek(fid,-1*byteBlck,'eof');

for i = num:-1:1
    
    pathOffset=w*nBlocks*uint32(floor(single(i-1)/single(nBlocks)));
    
    
    
    
     if((~mod(single(i),single(nBlocks))||i==num) && num > nBlocks)
        
     
         
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

        %temporary checks, can be deleted in the future if algorithm prove
        %to be working
        assert(state<=2^h);
        assert(indx-pathOffset<=nBlocks*w);
        
        
        y(indx) = path(state+1,indx-pathOffset);
        state = bitxor(state, y(indx)*bitand(h1_hat(j),sh));
        indx = indx - 1;
       
    end
    
    indm = indm - 1;
end

fclose(fid);
delete(file);

end