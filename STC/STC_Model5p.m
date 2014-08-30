function [ errorProbabilityAfterCorection ] = STC_Model5p( n,w,h,weightsModel,exclusionProbability,pError )
%Function to compare  error correcting capabilities of the improved STC
%with respect to error probability
%IMPORTANT if w << h then not enough paths will be to choose from by the
%end of w-block; 

x=round(rand(1,n));
m=round(rand(1,floor(n/w)));
if(strcmp(weightsModel,'Ones'))
    rho=ones(size(x));
elseif(strcmp(weightsModel,'Rand_Float'))
    rho=rand(size(x));
else
    assert(0);
end


%Generating 'generetor' matrix for the code
[h_hat, ~]=STC_Gen_Rnd_h_hat(h,w);
trellis=STC_genTransitionMatrixExtendedWithCheck(h_hat,exclusionProbability);
trellisEmulateOriginalSTC=STC_genTransitionMatrixExtendedWithCheck(h_hat,0);


errorProbabilityAfterCorection=zeros(size(pError));
errorProbabilityOriginalSTC=zeros(size(pError));
errorProbabilityReplacing=zeros(size(pError));


%Perform Coding in two ways
[y,~] = STC_GeneralViterbiEncoder(x,rho,m,trellis);
[yO,~] = STC_GeneralViterbiEncoder(x,rho,m,trellisEmulateOriginalSTC);


for i=1:numel(pError);
    
    %Adding errors
    errorVector=randsrc(1,numel(y),[1 0;pError(i) 1-pError(i)]);
   
    Y=y+errorVector;
    YO=yO+errorVector;
   
    %Perform decoding
    M=STC_GeneralViterbiDecoder(Y,trellis);
    MO=STC_GeneralViterbiDecoder(Y,trellisEmulateOriginalSTC);
    
    errorProbabilityAfterCorection(i)=sum(mod(M+m,2))/numel(m);
    errorProbabilityOriginalSTC(i)=sum(mod(MO+m,2))/numel(m);
    errorProbabilityReplacing(i)=pError(i);
    
    
    
    disp(['pError(i)=' num2str(pError(i)) ' out of max pError= ' num2str(pError(numel(pError)))]);
end

plot(pError,errorProbabilityAfterCorection,'--',pError,errorProbabilityOriginalSTC,'.-',pError,errorProbabilityReplacing);
legend('probability of error after correction','probability of error for original STC','probability of error for Replacing');
xlabel('pErrror in channel'); ylabel('pError after correction/error');
errorProbabilityAfterCorection
end

