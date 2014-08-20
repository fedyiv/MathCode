function [ COM ] = eurModel3centerOfMass(inBlock)
%calculating center of mass of input sample's string
%

COM=eurModel3centerOfMassHCF(eurModel3hcf(inBlock));

end
