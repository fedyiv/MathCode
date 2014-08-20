function [ vect1 vect2 ] = HugoModel1UniqueRandomVectorGenerator(nMax,nVal)
%in matlab 2012 this function can be used in following way 'randperm(n,k)'
%- so there won't be need in this wrapper
vect=randperm(nMax);
vect1=vect(1:nVal);
vect2=vect(nVal+1:nMax);
%vect2=vect(nVal-floor(0.2*nVal):nMax);

%vect1=sort(vect1);
%vect2=sort(vect2);





end

