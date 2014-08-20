function m_res = decod_1(y, h)
[n_row, n] = size(h);
m_res = zeros(1, n_row);
for i = 1:n_row
    s = 0;
    for j = 1: n
        s = bitxor(s, bitand(y(j), h(i,j)));
    end
    m_res(i) = s;
end
end