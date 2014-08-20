function [y] = HugoSTCcode(x,m,rho_min,H_hat)
%temporal plug

[y, cost, alpha, s] = STC_codeHDDVect2(uint32(x'), uint32(m'),H_hat,rho_min');
y=y';
end