function [ DivXY DivYX pE] = Model2EvaluateDivergenceOfImage6f( directoryCM,directoryCM2,ext,dim,T,pEmb,visual,stegosys,amplitude,h)
% Takes HUGO/SPAM features for estimation
%Embeds into images from directoryCM and then compare embedding with images
%from directoryCM2
%has h - parameter of STC matrix as an argument


cmDir=directoryCM;
cmDir2=directoryCM2;
if(strcmp(stegosys,'lsbmatch'))
    sgDir=[directoryCM 'lsbmatch\sg\pEmb_' num2str(pEmb) '\'];
elseif(strcmp(stegosys,'lsbreplace'))
    sgDir=[directoryCM 'lsbreplace\sg\pEmb_' num2str(pEmb) '\'];
elseif(strcmp(stegosys,'lsbss'))
    sgDir=[directoryCM 'lsbss\sg\pEmb_' num2str(pEmb) '\ampl_' num2str(amplitude) '\' ];
elseif(strcmp(stegosys,'hugo'))
    sgDir=[directoryCM 'hugo\sg\pEmb_' num2str(pEmb) '\dim' num2str(dim) '\' 'T' num2str(T) '\h_' num2str(h) '\'  ];    
else
    assert(0);
end
    

if(exist(sgDir,'dir')==0)
    mkdir(sgDir);
end
if(strcmp(stegosys,'lsbmatch'))
    disp(['Emulating LSB matching embedding']);
    evalc('eurModel3emulateLSBmatching2(pEmb,cmDir,sgDir,ext);');
elseif(strcmp(stegosys,'lsbreplace'))
    disp(['Emulating LSB replacing embedding']);
    evalc('eurModel3emulateLSBreplacing(pEmb,cmDir,sgDir,ext);');
elseif(strcmp(stegosys,'lsbss'))
    disp(['Emulating LSB SS embedding']);
    evalc('eurModel3emulateSS(pEmb,amplitude,cmDir,sgDir,ext);');
elseif(strcmp(stegosys,'hugo'))
    disp(['Emulating HUGO embedding']);
    HugoEmulateEmbeddingJ2f(pEmb,dim,T,0,cmDir,sgDir,ext,10,4,1,0,0,h)
    
end


disp('Calculating features and their divergence');
if(visual=='N')
    [DivXY,DivYX,pE] = Model2EvaluateDivergenceOfImage3( cmDir2,sgDir,ext,dim,T,'N',2);
elseif (visual=='Y')
    [DivXY,DivYX,pE] = Model2EvaluateDivergenceOfImage3( cmDir2,sgDir,ext,dim,T,'M',2);
end

end

