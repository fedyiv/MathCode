function [C] = HugoExtractFeatureMatrices(imFileName,dim,T)

%Features are saved in the folder with images with following name
%convention 'Features/filename_dim_T.features'

[fp fn fe]=fileparts(imFileName);

featurePath=[fp '\FeatureMatrices\'];
featureFileName=[fn '_' num2str(dim) '_' num2str(T)];



if(exist([featurePath featureFileName '.feature'],'file'))
    %load features from the file
    
    fid = fopen([featurePath featureFileName '.feature'], 'r');
    C=fread(fid,'double');
    fclose(fid);
    %all this will work only for 3d features!!!
    %comment above does not apply any more, I hope. Need to ensure
    
    if(dim==3)
    C=reshape(C,2*T+1,2*T+1,2*T+1,8);
    elseif(dim==2)
        C=reshape(C,2*T+1,2*T+1,8);
    else
        assert(0);
    end
    
    
else
    if(exist(featurePath,'dir')==0)
        %create folder then
        mkdir(featurePath);
    end
    
    im=imread(imFileName); 
    C=HugoGetFeatureMatricesC(HugoGetD(double(im)),dim,T);
        
    fid = fopen([featurePath featureFileName '.feature'], 'w');
    
    if(dim==3)
    fwrite(fid,reshape(C,[],1,1,1),'double');
    elseif(dim==2)
        fwrite(fid,reshape(C,[],1,1),'double');        
    else
        assert(0);
    end
    
    fclose(fid);
    
    
end


 

end

