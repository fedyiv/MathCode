function number_equal = STC_check(number, h, w, x_len, m_len)

number_equal = 0;
tic;
for i = 1:number
    [h_hat, h1_hat] = STC_Gen_Rnd_h_hat(h, w);
    
   % if(sum(h1_hat)==2)
   %     return;
    
    x = uint32(round(rand(1, x_len)));
    m = uint32(round(rand(1, m_len)));
    rho = ones(1, x_len);
     %   x
     %   m
     %   h_hat
    
    
   % [y, cost, alpha, s] = STC_codeHDD(x, m, h_hat, rho);
    [y, cost, alpha, s] = STC_codeHDDVect2(x, m, h_hat, rho);
    %[y, cost, alpha, s] = STC_cod(x, m, h_hat, rho);
    %[y, cost, alpha, s] = STC_cod2(x, m, h_hat, rho);
    m_res = STC_decod(y, h_hat, m_len);
    
    if (m == m_res)
        number_equal = number_equal + 1;
        
    end
    
    %m
    %x
    %h_hat
    
    
     
    
     assert(isequal(m,m_res));
    
    
  %  if(~isequal(m,m_res))
   %     x
   %     m
   %     m_res
   %     return;
   % end
    if(~mod(i,1))
    disp(['Sample #' num2str(i) ' processed. Ellapsed time ' num2str(toc)]);
    end
end



end