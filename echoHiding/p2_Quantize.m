function outp=p2_Quantize(inp,b)

% p2_Quantize(inp, b)
% Scales and Quantizes input signal inp
% to b bits.
% 
% Uses the class fixed.
%

scaling = max(abs(inp)/(1-pow2(-b)));
outp = scaling*double(fixed(b, inp/scaling));
return

% End of function