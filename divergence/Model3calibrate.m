function [] = Model3calibrate( inputFileName,outputDir )
%Calibrate jpg image
im=imread(inputFileName,'jpg');
[m,n]=size(im);

imCalibrated=im(5:m,5:n);
[~,fn,fe]=fileparts(inputFileName);
outputFileName=[outputDir fn '_calibrated' fe];

imwrite(imCalibrated,outputFileName,'jpg');

end

