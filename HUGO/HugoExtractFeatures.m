function [F] = HugoExtractFeatures(imFileName,dim,T)

%Features are saved in the folder with images with following name
%convention 'Features/filename_dim_T.features'

[fp fn fe]=fileparts(imFileName);

featurePath=[fp '\Features\'];
featureFileName=[fn '_' num2str(dim) '_' num2str(T)];



if(exist([featurePath featureFileName '.feature'],'file'))
    %load features from the file
    
    fid = fopen([featurePath featureFileName '.feature'], 'r');
    F=fread(fid,'double');
    fclose(fid);
    F=F';
    
else
    if(exist(featurePath,'dir')==0)
        %create folder then
        mkdir(featurePath);
    end
    
    im=imread(imFileName); 
    F=HugoGetM(HugoGetD(im),dim,T);
        
    fid = fopen([featurePath featureFileName '.feature'], 'w');
    fwrite(fid,F,'double');
    fclose(fid);
    
    
end


 

end

