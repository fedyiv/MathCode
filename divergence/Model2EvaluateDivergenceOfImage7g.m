function [ DivXY DivYX pE] = Model2EvaluateDivergenceOfImage7g( directoryCM,ext,dim,T,pEmb,visual,stegosys,amplitude,blkLen,h)
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
for i=h
    [ DivXY(k) DivYX pE] = Model2EvaluateDivergenceOfImage6g( cmDirWhite,cmDirBlack,ext,dim,T,pEmb,visual,stegosys,amplitude,i);
    k=k+1;
    h
    DivXY
end
end

