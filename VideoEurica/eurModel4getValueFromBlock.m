function [ value ] = eurModel4getValueFromBlock( inBlock )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


if(sum(size(inBlock)~=[8 8])~=0)
    error('Incorrect Macroblock size');
end

DCTransform=dct2(inBlock);

q=zeros(8,8);

q(1,1)=8;
q(1,2)=16;
q(1,3)=19;
q(1,4)=22;
q(1,5)=26;
q(1,6)=27;
q(1,7)=29;
q(1,8)=34;

q(2,1)=16;
q(2,2)=16;
q(2,3)=22;
q(2,4)=24;
q(2,5)=27;
q(2,6)=29;
q(2,7)=34;
q(2,8)=37;

q(3,1)=19;
q(3,2)=22;
q(3,3)=26;
q(3,4)=27;
q(3,5)=29;
q(3,6)=34;
q(3,7)=37;
q(3,8)=40;

q(4,1)=22;
q(4,2)=22;
q(4,3)=26;
q(4,4)=27;
q(4,5)=29;
q(4,6)=34;
q(4,7)=37;
q(4,8)=40;

q(5,1)=22;
q(5,2)=26;
q(5,3)=27;
q(5,4)=29;
q(5,5)=32;
q(5,6)=35;
q(5,7)=40;
q(5,8)=48;

q(6,1)=26;
q(6,2)=27;
q(6,3)=29;
q(6,4)=32;
q(6,5)=35;
q(6,6)=40;
q(6,7)=48;
q(6,8)=58;

q(7,1)=26;
q(7,2)=27;
q(7,3)=29;
q(7,4)=34;
q(7,5)=38;
q(7,6)=46;
q(7,7)=56;
q(7,8)=69;

q(8,1)=27;
q(8,2)=29;
q(8,3)=35;
q(8,4)=38;
q(8,5)=46;
q(8,6)=56;
q(8,7)=69;
q(8,8)=83;

DCTransform=round(DCTransform./q);

v1=mod(DCTransform,2);


value=mod(sum(v1(:)),2);


end

