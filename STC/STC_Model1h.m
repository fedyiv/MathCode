function [  ] = STC_Model1h( n,w,h,weightsModel )
%Function to compare cost of embedding for non error correcting STC and
%error correcring STC with respect to 'h'
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

m=round(rand(1,floor(n/w)));

CostsWithCorrection=zeros(size(h));
CostsWithoutCorrection=zeros(size(h));
CostsReplacing=zeros(size(h));
for i=1:numel(h);
    %Generating 'generetor' matrix for the code
    [h_hat, ~]=STC_Gen_Rnd_h_hat(h(i),w);
    %Perform Coding in two ways
    [y1, CostsWithoutCorrection(i), ~, ~] = STC_cod3(x, m, h_hat, rho);
    [y2, CostsWithCorrection(i), ~, ~] = STC_ErrorCorrecting_code(x, m, h_hat, rho);
    CostsReplacing(i) = getCostsofBitsReplacing(x, numel(m)/numel(x), rho);
    %Perform decoding
    m1=STC_decod(y1,h_hat,floor(n/w));
    m2=STC_decod(y2,h_hat,floor(n/w));
    
    if(sum(m1~=m2))
        assert(0);
    end   
    disp(['h(i)=' num2str(h(i)) ' out of max h= ' num2str(h(numel(h)))]);
end

plot(h,CostsWithCorrection,'--',h,CostsWithoutCorrection,'-.',h,CostsReplacing);
legend('CostsWithCorrection','CostsWithoutCorrection','CostsReplacing');
xlabel('h'); ylabel('Cost');
CostsWithCorrection
CostsWithoutCorrection
CostsReplacing
end

