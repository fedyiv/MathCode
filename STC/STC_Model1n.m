function [  ] = STC_Model1w( n,w,h,weightsModel )
%Function to compare cost of embedding for non error correcting STC and
%error correcring STC with respect to 'w'
%IMPORTANT if w << h then not enough paths will be to choose from by the
%end of w-block; 




CostsWithCorrection=zeros(size(n));
CostsWithoutCorrection=zeros(size(n));
CostsReplacing=zeros(size(n));
for i=1:numel(n)
    x=round(rand(1,n(i)));
    if(strcmp(weightsModel,'Ones'))
        rho=ones(size(x));
    elseif(strcmp(weightsModel,'Rand_Float'))
        rho=rand(size(x));
    else
        assert(0);
    end

    m=round(rand(1,floor(n(i)/w)));
    %Generating 'generetor' matrix for the code
    [h_hat, ~]=STC_Gen_Rnd_h_hat(h,w);
    %Perform Coding in two ways
    [y1, CostsWithoutCorrection(i), ~, ~] = STC_cod3(x, m, h_hat, rho);
    [y2, CostsWithCorrection(i), ~, ~] = STC_ErrorCorrecting_code(x, m, h_hat, rho);
    CostsReplacing(i) = getCostsofBitsReplacing(x, numel(m)/numel(x), rho);
    %Perform decoding
    m1=STC_decod(y1,h_hat,floor(n(i)/w));
    m2=STC_decod(y2,h_hat,floor(n(i)/w));
    
    if(sum(m1~=m2))
        assert(0);
    end   
    disp(['n(i)=' num2str(n(i)) ' out of max n= ' num2str(n(numel(n)))]);
end

plot(n,CostsWithCorrection,'--',n,CostsWithoutCorrection,'-.',n,CostsReplacing);
legend('CostsWithCorrection','CostsWithoutCorrection','CostsReplacing');
xlabel('n'); ylabel('Cost');
CostsWithCorrection
CostsWithoutCorrection
CostsReplacing
end

