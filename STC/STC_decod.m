function m = STC_decod(y, h_hat, num)
m = uint32(zeros(1, num));
[h, w] = size(h_hat);
h = uint32(h);
w = uint32(w);
num = uint32(num);
for i = 1:num
    for j = 1:h
        if (i+j-1 <= num)
        for k = 1:w
            m(i+j-1) = bitxor(m(i+j-1), bitand(y((i-1)*w+k), h_hat(j,k)));
        end
        end
    end
end

end
