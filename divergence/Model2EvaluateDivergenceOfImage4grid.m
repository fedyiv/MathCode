function [ DivXY DivYX pE] = Model2EvaluateDivergenceOfImage4grid( directoryCM,ext,dim,T,blockLen,pEmb,visual)
% Takes HUGO/SPAM features for estimation


listX=eurModel3getFiles(directoryCM,ext);
N=numel(listX);
nEmb=numel(pEmb);

for i=1:N
    [~ ,fn, ~]=fileparts(listX{i});
    
    cmDir=[directoryCM 'lsbmatch\cm\' fn '\split_' num2str(blockLen) '\'];
    
    if(exist(cmDir ,'dir')==0)
        mkdir(cmDir);
    end
    
    for p=pEmb
        sgDir=[directoryCM 'lsbmatch\sg\' fn '\split_' num2str(blockLen) '\pEmb_' num2str(p) '\'];
                
        if(exist(sgDir,'dir')==0)
            mkdir(sgDir);
        end
        disp(['Splitting image ' num2str(i) ' from ' num2str(N) ]);
        split_images2(listX{i},cmDir,ext,blockLen);
        disp(['Emulating LSB matching embedding' num2str(i) ' from ' num2str(N) ]);
        evalc('eurModel3emulateLSBmatching(p,cmDir,sgDir,ext)');
        
        disp(['Calculating features and their divergence' num2str(i) ' from ' num2str(N) ]);
        
        if(visual=='N')
            [~,DivXY,DivYX,pE] = evalc('Model2EvaluateDivergenceOfImage3( cmDir,sgDir,ext,dim,T,''N'',1)');         
        elseif (visual=='Y')
            [~,DivXY,DivYX,pE] = evalc('Model2EvaluateDivergenceOfImage3( cmDir,sgDir,ext,dim,T,''M'',1)');              
        end
        
        disp(['pEmb=' num2str(p) ' Div(X,Y)=' num2str(DivXY)]);
    end
end



end

