function Res=insertBit2Pos(Mass,Fs,bit,N1,N2,a,n0,dn0)
% ������� ���������  1 ��� bit  � ������ � ��������� Mass
% � �������� ������������� Fs , ������� � ������� N1 �� N2
% a - ����������� ���������� ���  ; n0 - ��������  
Res=Mass;
A=a.*ones(N2-N1+1,1);
k=(N2-N1+1)/2;
for i=1:k
    %A(i)=A(i)*sin(0.5*i./k);
    %A(i)=A(i)*(cos(pi*i./k+pi)+1)/2;
   % A(N2-N1-i+2)=A(i);
end


if(bit==1)
   for i=N1:N2
       
           Res(i)=Res(i)+1.1*A(i-N1+1)*Res(i-n0-dn0);
       
       
   end
else
    for i=N1:N2
       
           Res(i)=Res(i)+A(i-N1+1)*Res(i-n0);      
  
    end
    
end

end