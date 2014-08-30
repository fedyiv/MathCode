function [  ] = STC_Model4n( n,w,h,weightsModel,exclusionProbability )
%Function to compare cost of embedding for original STC and my equivalent
%STC
%error correcring STC with respect to 'n'
%IMPORTANT if w << h then not enough paths will be to choose from by the
%end of w-block; 

%Generating 'generetor' matrix for the code
[h_hat, ~]=STC_Gen_Rnd_h_hat(h,w);
trellis=STC_genTransitionMatrixExtendedWithCheck(h_hat,exclusionProbability);

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
    
    %Perform Coding in two ways
    [y1, CostsWithoutCorrection(i), ~, ~] = STC_cod3(x, m, h_hat, rho);
   
    [y2, CostsWithCorrection(i)] = STC_GeneralViterbiEncoder(x,rho,m,trellis);   
    CostsReplacing(i) = getCostsofBitsReplacing(x, numel(m)/numel(x), rho);
    
       
    disp(['n(i)=' num2str(n(i)) ' out of max n= ' num2str(n(numel(n)))]);
end

plot(n,CostsWithCorrection,'--',n,CostsWithoutCorrection,'-.',n,CostsReplacing);
legend('Costs for Proposed STC with Correction','Costs for Original STC','CostsReplacing');
xlabel('n'); ylabel('Cost');
CostsWithCorrection
CostsWithoutCorrection
CostsReplacing
end

