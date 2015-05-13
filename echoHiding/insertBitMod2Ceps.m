function [Res,lambda0]=insertBitMod2Ceps(Mass,bit,N1,N2,h,NPart,NExtZeros,window,blockType,nKv,lKvMin,lKvMax)


Res=Mass;

%summa=0;

%for i=N1:N2
%    summa=summa+abs(Mass(i));
%end

%if(summa/(N2-N1)<0.1)
%    return;
%end


deltaKv=(lKvMax-lKvMin)/nKv;

ScaleKv=zeros(nKv,1);

for i=1:nKv
    ScaleKv(i)=lKvMin+(i-1)*deltaKv;
end

%bar(ScaleKv);

lambda0=corrCepstrMulti2(Mass(N1:N2-1),h,NPart,NExtZeros,window,blockType);

if(isnan(lambda0))
       return;
end


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


if(flag==1)
    return
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





%jj=0;


%B=1;
%oldB=B;

%while(flag==0)
    %lambda0=AutoKorrFNorm(Res,N1,N2,n0); 
%    lambda0=corrCepstrMulti2(Res(N1:N2),h0,Npart,NExtZeros,window,blockType);
    
    %----------------------------
 %   if((jj>10) && ((B==0.2)||(B==-0.2)))  %исправить
 %       return;
 %   end
%    jj=jj+1;
    %------------------------------
    
%        if(lambda0>lambda1 && lambda0<lambda2)
%        return;
%    else
%        if(lambda0<lambda1)
%            if(oldB<0)
%                B=-oldB/2;
%%            end
%        else
%            if(oldB>0)
%                B=-oldB/2;
%            end

%        end
%    end
    
    %Res=insertEcho(Res,N1,N2,B,n0);
%    Res(N1:N2)=filter(h,[1],Mass(N1:N2));
 %   oldB=B;
%end


Dh=h(2:numel(h));
jj=0;

PlusErr=0;
OldPlusErr=0;

while(flag==0)

    lambda0=corrCepstrMulti2(Res(N1:N2-1),h,NPart,NExtZeros,window,blockType);
    
    %----------------------------
    if(jj>50||max(abs(Dh))>0.2)
        return;
    end
    jj=jj+1;
    %------------------------------
    
        if(lambda0>lambda1 && lambda0<lambda2)
        return;
    else
        if(lambda0<lambda1)
            PlusErr=0;
            
            if(OldPlusErr==0)
                h=h+[0 Dh];
            else
                Dh=Dh/2;
                h=h+[0 Dh];
            end
            
        else
            
             PlusErr=1;
            
            if(OldPlusErr==1)
                h=h-[0 Dh];
            else
                Dh=Dh/2;
                h=h-[0 Dh];
            end
            
        end
    end
    

    Res(N1:N2-1)=filter(h,[1],Mass(N1:N2-1));
    
    OldPlusErr=PlusErr;

end





%   for i=N1:N2
%       if(bit==1)
%           Res(i)=Res(i)+A(i-N1+1)*Res(i-n0);
%       end
%   end
end