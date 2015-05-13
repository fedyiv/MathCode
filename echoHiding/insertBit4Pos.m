function Res=insertBit4Pos(Mass,Fs,bit,N1,N2,a,n0,dn0)
% ������� ���������  1 ��� bit  � ������ � ��������� Mass
% � �������� ������������� Fs , ������� � ������� N1 �� N2
% a - ����������� ���������� ���  ; n0 - ��������  
Res=Mass;
A=a.*ones(N2-N1+1,1);
k=(N2-N1+1)/4;
for i=1:k
    %A(i)=A(i)*sin(0.5*i./k);
    A(i)=A(i)*(cos(pi*i./k+pi)+1)/2;
    A(N2-N1-i+2)=A(i);
end



if(bit(1)==0)
    if(bit(2)==0)
        delay=n0;
    else
        delay=n0+dn0;
    end
else
    if(bit(2)==0)
        delay=n0+2*dn0;
    else
        delay=n0+3*dn0;
    end
end

for i=N1:N2
    Res(i)=Res(i)+A(i-N1+1)*Res(i-delay);
end
end