function [ hcf ] = eurModel3hcfCalibrated(inBlock)
%Function computes HISTOGRAM CHARACTERISTIC FUNCTION (HCF)
% It is Fourier Transform of histogram

h=histc(inBlock(:),0:255);

hcf=fft(h);
hcf=hcf(1:128);
end

