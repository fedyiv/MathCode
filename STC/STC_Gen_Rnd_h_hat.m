function [h_hat, h1_hat] = STC_Gen_Rnd_h_hat(h, w)

if (w >= 2^h)
    s = 'w is too large';
    error(s);
end
h_hat = zeros(h,w);
h1_hat = zeros(1, w);
while(1)
for j = 1:w
    z = 0;
    while (z == 0)
        h_hat_col = round(rand(h, 1));
        if(sum(h_hat_col)==0)
            continue;
        end
        h1_hat(j) = 0;
        for i = h:-1:1
            h1_hat(j) = h1_hat(j) + h_hat_col(i)*2^(i-1);
        end
        equal = 0;
        if (j > 1)
            for j1 = 1:j - 1
                if (h1_hat(j1) == h1_hat(j))
                    equal = 1;
                    break;
                end
            end
        end
       
              
        
        if (equal == 0)
            z = 1;
            h_hat(1:end, j) = h_hat_col;
        end
    end
end

if(find(sum(h_hat,2)==0))
    continue;
end
break;
end


h_hat = uint32(h_hat);
end