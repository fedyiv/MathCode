function [y, cost, alpha, s] = STC_cod(x, m, h_hat, rho)
% вычисления в данной программе происходят только при n == n1, n > n1.
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
wght = zeros(1, 2^h);
wght(2:end) = inf;
newwght = zeros(1, 2^h);
indx = uint32(1);
indm = uint32(1);
w0 = 0;
w1 = 0;
path = uint8(inf*ones(w*num, 2^h));

sh=2^h-1;
for i = 1:num
    shift=uint32(0);
    
    if (num < h+i-1)
        shift=h+i-num-1;
        sh=uint32(binvec2dec([ones(1,h-shift) zeros(1,shift) ]));
    end
    
    
    for j = uint32(1:w)
        z1=uint32(bitand(h1_hat(j),sh));
        for k = 1:2^h
           
            w0 = wght(k) + double(x(indx))*rho(indx);
            
            
            z2 = bitxor(k-1, z1);
            z3 = double(1 - x(indx))*rho(indx);
            w1 = wght(z2+1) + z3;
            
            if (w1 < w0)
                path(indx, k) = 1;
            else path(indx, k) = 0;
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
for i = num:-1:1
    shift=0;
    sh=sh0;
    if (num < h+i-1)
        shift=h+i-num-1;
        sh=binvec2dec([ones(1,h-shift) zeros(1,shift) ]);
    end
    
    state = 2*state + m(indm);
    for j = w:-1:1
        y(indx) = path(indx, state+1);
        state = bitxor(state, y(indx)*bitand(h1_hat(j),sh));
        indx = indx - 1;
    end
    
    indm = indm - 1;
end

end