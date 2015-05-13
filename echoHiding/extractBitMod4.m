function bit=extractBitMod4(Mass,N1,N2,n0)
% ������� ���������  1 ��� bit  � ������ � ��������� Mass
% � �������� ������������� Fs , ������� � ������� N1 �� N2
% a - ����������� ���������� ���  ; n0 - ��������  
Res=Mass;

Num=N2-N1+1;

y=zeros(Num,1);
for j=N1:N2
    y(j-N1+1)=Mass(j);
end




z=fft(y);


R=abs(z);
phi=angle(z);

%plot(R);

%------------------------------------------
R2=zeros(floor(Num/2),1);
for jj=1:floor(Num/2)
    R2(jj)=R(jj);
end


[odd,even]=splitMass(R2);

N1k=1+n0;
N2k=floor(Num/4);

lambdaOdd=AutoKorrFNorm(odd,N1k,N2k,n0);
lambdaEven=AutoKorrFNorm(even,N1k,N2k,n0);

if(lambdaOdd>lambdaEven)
    bit=1;
else
    bit=0;
end



%-------------------------------------------




end