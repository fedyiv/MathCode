function [ COM ] = eurModel3centerOfMassHCF(input )
%calculating center of mass of input sample's string
%

n=numel(input);

i=1:n;

COM=sum(i.*abs(input'))/sum(abs(input));

end