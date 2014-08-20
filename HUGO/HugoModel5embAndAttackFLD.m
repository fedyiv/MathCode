function [FLD  ] = HugoModel5embAndAttackFLD( pEmb,dim,T,model_correction,cmDir,sgDir,sigma,gamma,weightForm,weightMatrix,signed,forceRecalc)

cmTrainDir= [cmDir 'train\'];
cmTestDir=[cmDir 'test\'];
sgTrainDir=[sgDir 'train\'];
sgTestDir=[sgDir 'test\'];

if (forceRecalc=='Y')
    disp('Removing costs and SG images');
    [stat, mess, id]=rmdir([cmTrainDir 'Costs'],'s');
    [stat, mess, id]=rmdir([cmTestDir 'Costs'],'s');
     [stat, mess, id]=rmdir([cmTrainDir 'Features'],'s');
    [stat, mess, id]=rmdir([cmTestDir 'Features'],'s');
    [stat, mess, id]=rmdir([cmTrainDir 'FeatureMatrices'],'s');
    [stat, mess, id]=rmdir([cmTestDir 'FeatureMatrices'],'s');
    [stat, mess, id]=rmdir(sgTrainDir ,'s');
    mkdir(sgTrainDir);
    [stat, mess, id]=rmdir(sgTestDir ,'s');
    mkdir(sgTestDir);
end

HugoEmulateEmbeddingJ2(pEmb,dim,T,model_correction,cmTrainDir,sgTrainDir,'pgm',sigma,gamma,weightForm,weightMatrix,signed);
HugoEmulateEmbeddingJ2(pEmb,dim,T,model_correction,cmTestDir,sgTestDir,'pgm',sigma,gamma,weightForm,weightMatrix,signed);

[ FLD , ~, ~ ,~,~ ]=HugoModel3evaluateFLDCriteria(dim,T,cmTrainDir,sgTrainDir,'pgm',1);


end

