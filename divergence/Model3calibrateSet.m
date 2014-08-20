function [] = Model3calibrateSet( inputFileDir,outputDir )
%Calibrate jpg image

list=eurModel3getFiles(inputFileDir,'jpg');

N=numel(list);

for i=1:N
    Model3calibrate( list{i},outputDir );
end

end

