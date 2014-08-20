function [ DivXY DivYX pE] = Model2EvaluateDivergenceOfImage5( directoryCM,directoryCM2,ext,dim,T,blockLen,pEmb,visual)
% Takes HUGO/SPAM features for estimation
%Embeds into images from directoryCM and then compare embedding with images
%from directoryCM2


listX=eurModel3getFiles(directoryCM,ext);
N=numel(listX);

listX2=eurModel3getFiles(directoryCM2,ext);

for i=1:N
    [~ ,fn, ~]=fileparts(listX{i});
    [~ ,fn2, ~]=fileparts(listX2{i});
    cmDir=[directoryCM 'lsbmatch\cm\' fn '\split_' num2str(blockLen) '\'];
    cmDir2=[directoryCM2 'lsbmatch\cm2\' fn '\split_' num2str(blockLen) '\'];
    sgDir=[directoryCM 'lsbmatch\sg\' fn '\split_' num2str(blockLen) '\pEmb_' num2str(pEmb) '\'];
    
     if(exist(cmDir ,'dir')==0)
         mkdir(cmDir);
     end
     if(exist(cmDir2 ,'dir')==0)
         mkdir(cmDir2);
     end
     if(exist(sgDir,'dir')==0)
         mkdir(sgDir);
     end
    
     disp(['Splitting image ' num2str(i) ' from ' num2str(N) ]);
     split_images2(listX{i},cmDir,ext,blockLen);
     
     disp(['Splitting image ' num2str(i) ' from ' num2str(N) ]);
     split_images2(listX2{i},cmDir2,ext,blockLen);
     
     disp(['Emulating LSB matching embedding' num2str(i) ' from ' num2str(N) ]);
     eurModel3emulateLSBmatching(pEmb,cmDir,sgDir,ext);
     
     disp(['Calculating features and their divergence' num2str(i) ' from ' num2str(N) ]);
     if(visual=='N')
         [DivXY,DivYX,pE] = Model2EvaluateDivergenceOfImage3( cmDir2,sgDir,ext,dim,T,'N')         
     elseif (visual=='Y')
         [DivXY,DivYX,pE] = Model2EvaluateDivergenceOfImage3( cmDir2,sgDir,ext,dim,T,'M')              
     end
    
end

end

