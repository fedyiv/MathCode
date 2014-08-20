function [ FLD14 FLD58  mCM14  mCM58 mSG14 mSG58 varCM14 varCM58 varSG14 varSG58 ] = HugoModel3evaluateFLDCriteriaAverage(dim,T,directoryCM,directorySG,ext )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%k - direction




FLD14=0;
mCM14=0;
mSG14=0;
varCM14=0;
varSG14=0;

for k=1:4
[FLD mCM mSG varCM varSG ] = HugoModel3evaluateFLDCriteria(dim,T,directoryCM,directorySG,ext,k )
FLD14=FLD14+FLD/4;
mCM14=mCM14+mCM/4;
mSG14=mSG14+mSG/4;
varCM14=varCM14+varCM/4
varSG14=varSG14+varSG/4;

end

FLD58=0;
mCM58=0;
mSG58=0;
varCM58=0;
varSG58=0;

for k=5:8
[FLD mCM mSG varCM varSG ] = HugoModel3evaluateFLDCriteria(dim,T,directoryCM,directorySG,ext,k )
FLD58=FLD58+FLD/4;
mCM58=mCM58+mCM/4;
mSG58=mSG58+mSG/4;
varCM58=varCM58+varCM/4
varSG58=varSG58+varSG/4;
end


if(dim==2)

    subplot(2,1,1);
    surf(-T:T,-T:T,FLD14);
    subplot(2,1,2);
    surf(-T:T,-T:T,FLD58);
    
end


end

