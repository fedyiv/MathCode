function [ TM ] = HugoModel4separateImages(directorySource,low,high,directoryDestinationLow,directoryDestinationHigh,ext,onlyShow)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

list=eurModel3getFiles(directorySource,ext);

N=numel(list);

TM=zeros(1,N);



for i=1:N

    if(mod(i,50)==0)
    disp(['Image ' list{i} ' is being processed'])
    end
    
    im=imread(list{i});
    
    
        
    TM(i)=HugoModel4computeTextureMeasure(im)/numel(im);
    
  if(onlyShow==0)    
      
    [fp fn fe]=fileparts(list{i});
    if(TM(i)>high)
        imwrite(im,[directoryDestinationHigh fn '.' ext],ext);
    elseif(TM(i)<low)
        imwrite(im,[directoryDestinationLow fn '.' ext],ext);
    end
  end
    
end

[f,x]=ecdf(TM);
plot(x,f);
line([low low],[0 1]);
line([high high],[0 1]);

end

