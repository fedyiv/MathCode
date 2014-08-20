function [ Divergence ] = getDivergence2(X,Y)

[N,D]=knnsearch(X,X,'K',2);

Ro=D(:,2);
k=[];
if(sum(Ro==0) >0)
    disp( ['Number of non-zero Ro:' num2str(sum(Ro==0)) ' have been excluded.']);
    k=Ro==0;
    Ro(k)=[];    
    
end
%This is not very accurate, beacuse it is necessary to exclude
%corresponding column in X and Y. But my assumption is that taking second
%nearest neighbour will suffice
[N,Nu]=knnsearch(Y,X);
Nu(k)=[];

k1=[];

if(sum(Nu==0) >0)
    disp( ['Number of non-zero Nu:' num2str(sum(Nu==0)) ' have been excluded.']);
    k1=Nu==0;
    Nu(k1)=[];    
    Ro(k1)=[];    
end

[d1,d2]=size(X);
n=d1-sum(k)-sum(k1);
[d1,d2]=size(Y);
m=d1-sum(k)-sum(k1);
d=d2;

Divergence=(d/d1)*sum(log(Nu./Ro))+log(m/(d1-1));

if((n-sum(k)-sum(k1))/n<0.9)
    warning(['Only ' num2str(100*(n-sum(k)-sum(k1))/d1) '% of images have been used']);
end

end

