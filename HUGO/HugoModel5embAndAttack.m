function [ p ] = HugoModel5embAndAttack( pEmb,dim,T,model_correction,cmDir,sgDir,sigma,gamma,weightForm,weightMatrix,signed,attackDim,attackT,attackSigma,attackBoxConstraint )

cmTrainDir= [cmDir 'train\'];
cmTestDir=[cmDir 'test\'];
sgTrainDir=[sgDir 'train\'];
sgTestDir=[sgDir 'test\'];

HugoEmulateEmbeddingJ2(pEmb,dim,T,model_correction,cmTrainDir,sgTrainDir,'pgm',sigma,gamma,weightForm,weightMatrix,signed);
HugoEmulateEmbeddingJ2(pEmb,dim,T,model_correction,cmTestDir,sgTestDir,'pgm',sigma,gamma,weightForm,weightMatrix,signed);

[P minP] = HugoModel1svmgrid2(cmTrainDir,sgTrainDir,cmTestDir,sgTestDir,'pgm',attackDim,attackT,attackSigma,attackBoxConstraint,5,0);

p=min(P(:,3));

end

