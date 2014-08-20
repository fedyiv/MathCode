function [ COM2 ] = eurModel3centerOfMass2(inBlock)
%calculating center of mass of input sample's string
%

COM2=eurModel3centerOfMassHCF2d(eurModel3hcf2d(inBlock));

end
