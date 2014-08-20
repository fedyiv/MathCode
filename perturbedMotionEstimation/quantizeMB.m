function MB = quantizeMB(MB)
%to be changed
quantizer_scale=8;
MB= round(MB./quantizer_scale)*quantizer_scale;

end