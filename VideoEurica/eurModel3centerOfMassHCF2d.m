function [ COM2 ] = eurModel3centerOfMassHCF2d(input )
%calculating center of mass of input sample's string
%

[N M]=size(input);

COM2=0;


for i=1:M
    for j=1:N
        COM2=COM2+(i+j)*abs(input(i,j));
    end
end

COM2=COM2/sum(abs(input(:)));



end