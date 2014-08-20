function [ fileList ] = eurModel3getFiles(directoryName,ext)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

d=dir(directoryName);


n=1;

fileList1=cell(numel(d),1);



for i=1:numel(d)
    if(strfind(d(i).name,ext))
        fileList1(n)={[directoryName char(d(i).name)]};
        n=n+1;
    end
    
end

n=n-1;

fileList=cell(n,1);


for i=1:n
   fileList(i)=fileList1(i); 
end

end

