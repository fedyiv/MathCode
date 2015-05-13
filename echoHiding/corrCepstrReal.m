function [R,cy,ch] = corrCepstr(y,NExtZeros,h,w)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[m,ny]=size(y);
[m,nh]=size(h);
[m,nw]=size(w);

y=[y zeros(1,NExtZeros-ny)];
w=[w zeros(1,NExtZeros-nw)];
h=[h zeros(1,NExtZeros-nh)];

y=w.*y;

[m,n]=size(y);
[m,nh]=size(h);


cy=rceps(y);

h=[h zeros(1,NExtZeros-nh)];
ch=rceps(h);

R=corr(cy',ch');

end

