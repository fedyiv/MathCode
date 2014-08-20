function [ DivXY DivYX pE] = Model2EvaluateDivergenceOfImage7c( directoryCM,ext,dim,T,pEmb,visual,stegosys,amplitude,blkLen,sigma,gamma)
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

DivXY=zeros(numel(sigma),numel(gamma));


ki=1;
for i=sigma
    kj=1;
    for j=gamma
        [ DivXY(ki,kj) DivYX pE] = Model2EvaluateDivergenceOfImage6c( cmDirWhite,cmDirBlack,ext,dim,T,pEmb,visual,stegosys,amplitude,i,j);
        DivXY
        kj=kj+1;
    end
    ki=ki+1;
end

    surf(gamma,sigma,DivXY);
    xlabel('gamma');
    ylabel('sigma');
    zlabel('Div(gamma,sigma)');

end

