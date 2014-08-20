function [ p ] = HugoModel5embAndAttack2( pEmb,dim,T,model_correction,cmDir,sgDir,sigma,gamma,weightForm,weightMatrix,signed,probability,attackDim,attackT,attackSigma,attackBoxConstraint ,forceRecalc)

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

HugoEmulateEmbeddingJ3(pEmb,dim,T,model_correction,cmTrainDir,sgTrainDir,'pgm',sigma,gamma,weightForm,weightMatrix,signed,probability);
HugoEmulateEmbeddingJ3(pEmb,dim,T,model_correction,cmTestDir,sgTestDir,'pgm',sigma,gamma,weightForm,weightMatrix,signed,probability);

[P minP] = HugoModel1svmgrid2(cmTrainDir,sgTrainDir,cmTestDir,sgTestDir,'pgm',attackDim,attackT,attackSigma,attackBoxConstraint,5,0);

p=min(P(:,3));

end

