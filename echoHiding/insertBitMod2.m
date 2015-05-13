function [Res,lambda0]=insertBitMod2(Mass,bit,N1,N2,n0,nKv)


Res=Mass;

%summa=0;

%for i=N1:N2
%    summa=summa+abs(Mass(i));
%end

%if(summa/(N2-N1)<0.1)
%    return;
%end



ScaleKv=zeros(nKv,1);

for i=1:nKv
    ScaleKv(i)=(1/nKv)*(i)-(0.5/nKv);

end

ScaleKv=ScaleKv*3-1.5;

%bar(ScaleKv);

lambda0=AutoKorrFNorm(Mass,N1,N2,n0);

flag=0;

Kv=1;


lambda1=0;
lambda2=1;




for i=1:nKv

    if(ScaleKv(i)>lambda0)
        if(bit==0)
            
            if(mod(i,2)==0)
                flag=1;
                break
            else
                lambda1=ScaleKv(i);
                lambda2=ScaleKv(i+1);
                                
                break
            end
            
        else
            if(mod(i,2)==1)
                flag=1;
                break
            else
                lambda1=ScaleKv(i);
                lambda2=ScaleKv(i+1);
                break
            end
            
            
        end
    end
        
        
end

%Проверка - если корреляц функция > 1-----------------

if (lambda2 > 1 || lambda1 > 1)
    
    while(lambda2 > 1 || lambda1 > 1)
        
        i=i-2;
        
        lambda1=ScaleKv(i);
        lambda2=ScaleKv(i+1);
    
        
    end

end

if(lambda2 > 0.87)
i=i-2;

lambda1=ScaleKv(i);
lambda2=ScaleKv(i+1);

end


%------------------------------------------------------


if(flag==1)
    return
end

B=0.2;
oldB=B;

jj=0;





while(flag==0)
    lambda0=AutoKorrFNorm(Res,N1,N2,n0); 
    
    %----------------------------
    if((jj>10) && ((B==0.2)||(B==-0.2)))  %исправить
        return;
    end
    jj=jj+1;
    %------------------------------
    
        if(lambda0>lambda1 && lambda0<lambda2)
        return;
    else
        if(lambda0<lambda1)
            if(oldB<0)
                B=-oldB/2;
            end
        else
            if(oldB>0)
                B=-oldB/2;
            end

        end
    end
    
    Res=insertEcho(Res,N1,N2,B,n0);
    oldB=B;
end





%   for i=N1:N2
%       if(bit==1)
%           Res(i)=Res(i)+A(i-N1+1)*Res(i-n0);
%       end
%   end
end