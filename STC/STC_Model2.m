function [ cost ] = STC_Model2( xlen,h,w,weightsModel )
%Function is supposed to test correctness of encoding end decoding
%procedure. For this purpose it encodes and decodes mesages several times
%and then compare the results.

x=round(rand(1,xlen));
[h_hat,~]=STC_Gen_Rnd_h_hat(h,w);

if(strcmp(weightsModel,'Ones'))
    rho=ones(size(x));
elseif(strcmp(weightsModel,'Rand_Float'))
    rho=rand(size(x));
else
    assert(0);
end

m=round(rand(1,floor(xlen/w)));

trellis=STC_genTransitionMatrix(h_hat);

[y,cost]=STC_GeneralViterbiEncoder(x,rho,m,trellis);
[m1,error]=STC_GeneralViterbiDecoder(y,trellis);

if(sum(m~=m1))
    assert(0);
else
    
end

end

