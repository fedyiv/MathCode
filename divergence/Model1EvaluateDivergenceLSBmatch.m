function [ output_args ] = Model1EvaluateDivergenceLSBmatch( d,mup,CPll,CPls,pEmb,N)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

CP=diag(CPll*ones(d,1))+CPls*(~diag(ones(d,1)));

mu=mup*ones(1,d);

Div=zeros(numel(N),1);
i=1;
for n=N
    disp(['Processing data for n=' num2str(n) ' from ' num2str(N(numel(N)))]);
    X=round(mvnrnd(mu,CP,n));
    mask=randsrc(n,d,[1 0; pEmb 1-pEmb]);
    emb=round(rand(n,d));
    rnd=randsrc(n,d);

    Y=X;
    for j=1:n
        for k=1:d
            if(mod(X(j,k),2)~=emb(k) && mask(k)==1)
               Y(j,k)=X(j,k)+rnd(j,k);
            end
        end
    end
    
    Div(i)=getDivergence(X,Y);
    i=i+1;    
end

plot(N,Div);


end

