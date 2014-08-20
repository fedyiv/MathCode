function [ output_args ] = Model1EvaluateDivergence( d,mup,muq,CPll,CPls,CQll,CQls,N)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

CP=diag(CPll*ones(d,1))+CPls*(~diag(ones(d,1)));
CQ=diag(CQll*ones(d,1))+CQls*(~diag(ones(d,1)));

Div=zeros(numel(N),1);
i=1;
for n=N
    disp(['Processing data for n=' num2str(n) ' from ' num2str(N(numel(N)))]);
    X=mvnrnd(mup,CP,n);
    Y=mvnrnd(muq,CQ,n);
    Div(i)=getDivergence(X,Y);
    i=i+1;    
end

plot(N,Div);


end

