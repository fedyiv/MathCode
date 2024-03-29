function [y, cost, alpha, s] = STC_ErrorCorrecting_code(x, m, h_hat, rho)
% ���������� � ������ ��������� ���������� ������ ��� n == n1, n > n1.
%To be completely rewritten to be able to code with error correcting
%capabilities. For this only small change is necessary - when selecting
%surviving paths in the end of the block apply some function like sum by
%modulo 2 and choose only thos that give zero
num = size(m,2);
n = size(x,2);
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
path = uint8(inf*ones(2^h,w*num));

%Forward part
sh=2^h-1;
for i = 1:num
    shift=uint32(0);
    
    if (num < h+i-1)
        shift=h+i-num-1;
        sh=uint32(binvec2dec([ones(1,h-shift) zeros(1,shift) ]));
    end
    
    
    
    for j = uint32(1:w)
        z1=uint32(bitand(h1_hat(j),sh));
        z3 = double(1 - x(indx))*rho(indx);
        z4=double(x(indx))*rho(indx);
        
        for k = 1:2^h
           
            w0 = wght(k) + z4;
            
            
            z2 = bitxor(k-1, z1);
            
            w1 = wght(z2+1) + z3;
            
            if (w1 < w0)
                path(k,indx) = 1;
            else path(k,indx) = 0;
            end
            newwght(k) = min(w0, w1);
        end
        indx = indx +1;
        wght = newwght;
    end
    %End of w-block. Shifting partial syndrome
    for j = 1:1:(2^(h-1))
        wght(j) = wght(j + j -1 + m(indm));
        %This is code correcting feature starts (This version excludes half
        %of the nodes in the beginning of the next block) See v2 for better
        %behaviour.
        if(mod(sum(dec2bin(j-1)=='1',2),2))
            wght(j)=inf;
        end
        %Code correction feature ends
    end
    wght(2^(h-1)+1:end) = inf;
    indm = indm + 1;
end

%Backward part
y = x;
cost = wght(1);
state = 0;
indx = indx - 1;
indm = indm - 1;
sh0 = 2^h-1;
for i = num:-1:1
    shift=0;
    sh=sh0;
    if (num < h+i-1)
        shift=h+i-num-1;
        sh=binvec2dec([ones(1,h-shift) zeros(1,shift) ]);
    end
    
    state = 2*state + m(indm);
    for j = w:-1:1
        y(indx) = path(state+1,indx);
        state = bitxor(state, y(indx)*bitand(h1_hat(j),sh));
        indx = indx - 1;
    end
    
    indm = indm - 1;
end

end