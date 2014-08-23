function [  ] = STC_Model1w( n,w,h,weightsModel )
%Function to compare cost of embedding for non error correcting STC and
%error correcring STC with respect to 'w'
%IMPORTANT if w << h then not enough paths will be to choose from by the
%end of w-block; 

x=round(rand(1,n));
if(strcmp(weightsModel,'Ones'))
    rho=ones(size(x));
elseif(strcmp(weightsModel,'Rand_Float'))
    rho=rand(size(x));
else
    assert(0);
end



CostsWithCorrection=zeros(size(w));
CostsWithoutCorrection=zeros(size(w));
CostsReplacing=zeros(size(w));
for i=1:numel(w);
    m=round(rand(1,floor(n/w(i))));
    %Generating 'generetor' matrix for the code
    [h_hat, ~]=STC_Gen_Rnd_h_hat(h,w(i));
    %Perform Coding in two ways
    [y1, CostsWithoutCorrection(i), ~, ~] = STC_cod3(x, m, h_hat, rho);
    [y2, CostsWithCorrection(i), ~, ~] = STC_ErrorCorrecting_code(x, m, h_hat, rho);
    CostsReplacing(i) = getCostsofBitsReplacing(x, numel(m)/numel(x), rho);
    %Perform decoding
    m1=STC_decod(y1,h_hat,floor(n/w(i)));
    m2=STC_decod(y2,h_hat,floor(n/w(i)));
    
    if(sum(m1~=m2))
        assert(0);
    end   
    disp(['w(i)=' num2str(w(i)) ' out of max w= ' num2str(w(numel(w)))]);
end

plot(w,CostsWithCorrection,'--',w,CostsWithoutCorrection,'-.',w,CostsReplacing);
legend('CostsWithCorrection','CostsWithoutCorrection','CostsReplacing');
xlabel('w'); ylabel('Cost');
CostsWithCorrection
CostsWithoutCorrection
CostsReplacing
end

