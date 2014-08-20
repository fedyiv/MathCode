function [ meanF varF] = HugoModel1(directory,ext,dim,T )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


list=eurModel3getFiles(directory,ext);

N=numel(list);

F=zeros(N,2*(2*T+1).^dim);

for i=1:N
    disp(['Image ' list{i} ' is being processed']);
    im=imread(list{i}); 
    
    F(i,:)=HugoGetM(HugoGetD(im),dim,T);
end

meanF=mean(F);
varF=var(F);

end

