function [Bit,lambda] = extractBit( Mass,Fs,N1,N2,a,n0)
% ������� ��������� 1 ��� �� ������ � ��������� Mass
% � �������� ������������� Fs , ������� � ������� N1 �� N2
% a - ����������� ���������� ���  ; n0 - ��������
        lambda0=1;
       %lambda0=7000;
        
        lambda=0;
        for i=N1:N2
                       
            lambda=lambda+Mass(i)*Mass(i-n0);
        end
        
       
       
       tempMass=zeros(N2-N1,1);
       k=0;
       for i=1:N2-N1
           k=k+(Mass(N1+i-n0))^2;
       end
       
       lambda=lambda/k;
        
        if(lambda > lambda0)
            Bit=1;
        else
            Bit=0;
        end


end

