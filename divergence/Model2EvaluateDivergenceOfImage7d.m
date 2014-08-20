function [ DivXY DivYX pE] = Model2EvaluateDivergenceOfImage7d( directoryCM,ext,dimAttack,TAttack,pEmb,dimEmbedd,TEmbedd,visual,stegosys,amplitude,blkLen)
% Takes HUGO/SPAM features for estimation
%Separating each CM image into two ajacents subset - like chess
%board.Leaving white cells as is, and embedding into black cells.


cmDirWhite=[directoryCM 'cmWhite\'];
cmDirBlack=[directoryCM 'cmBlack\'];

if(exist(cmDirWhite,'dir')==0)
    mkdir(cmDirWhite);
end
if(exist(cmDirBlack,'dir')==0)
    mkdir(cmDirBlack);
end


split_images3b(directoryCM,cmDirWhite,cmDirBlack,ext,blkLen);

DivXY=zeros(1,numel(pEmb));

k=1;
for i=TEmbedd
    [ DivXY(k) DivYX pE] = Model2EvaluateDivergenceOfImage6d( cmDirWhite,cmDirBlack,ext,dimAttack,TAttack,pEmb,dimEmbedd,i,visual,stegosys,amplitude);
    TEmbedd
    DivXY
    k=k+1;
end
end

