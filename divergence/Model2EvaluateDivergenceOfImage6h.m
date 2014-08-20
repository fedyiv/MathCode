function [ DivXY DivYX pE] = Model2EvaluateDivergenceOfImage6h( directoryCM,ext,blckSize,ns)
% Takes DCT coeffs for estimation
%Calculates divergence between image and calibrated image. Presumably
%divirgence will be less for CM than for SG  !!!Important - calibration
%implies onlu JPG images!!!


cmDir=directoryCM;

sgDir=[directoryCM 'calibrated\'];

if(exist(sgDir,'dir')==0)
    mkdir(sgDir);
end

Model3calibrateSet(cmDir,sgDir);


disp('Calculating features and their divergence');

[DivXY,DivYX,pE] = Model2EvaluateDivergenceOfImage1a( cmDir,sgDir,ext,blckSize,ns);


end

