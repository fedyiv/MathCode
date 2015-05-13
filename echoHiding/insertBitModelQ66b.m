function [Res] = insertBitModelQ66b(y,oldRes,N1,N2,bits,h0,h1,Npart,y0,y1,Smoothing)

N=N2-N1+1;
nB=floor(N/Npart);
nP=floor(nB/Npart);


nSm=floor(Smoothing*nP);

%a=[(1/(2*Smoothing*nP-1)).*(1:floor(2*nP*Smoothing))+(1/(1-2*Smoothing*nP)) ones(1,floor(nP-2*nP*Smoothing)) (1/(1-2*Smoothing*nP)).*(1:floor(2*nP*Smoothing))+(1-1/(1-2*Smoothing*nP))];
a=[(1/(2*nSm-1)).*(1:2*nSm)+(1/(1-2*nSm)) ones(1,nP-2*nSm) (1/(1-2*nSm)).*(1:2*nSm)+(1-1/(1-2*nSm))];

Res=oldRes;
%Res(N1:N2)=zeros(1,N2-N1+1);

for i=1:Npart*Npart
    
    nBit=mod(i,Npart);
    if(nBit==0)
        nBit=Npart;
    end
   
 if(nSm==0)
     if(bits(nBit)==1)
            x1=N1+(i-1)*nP;
            x2=N1+i*nP-1;
            Res(x1:x2)=y1(x1:x2);                 
     else
            Res(N1+(i-1)*nP:N1+i*nP-1)=y0((N1+(i-1)*nP:N1+i*nP-1));            
     end     
 else 
    if(N1+(i-1)*nP<=nP||numel(y)-(N1+(i-1)*nP)<=nP)
       if(numel(y)-(N1+(i-1)*nP)<=nP)
            if(bits(nBit)==1)            
  %              Res(N1+(i-1)*nP-nSm:N1+i*nP-1)=Res(N1+(i-1)*nP-nSm:N1+i*nP-1)+([a(1:0.5*(2*nSm+nP)) ones(1,0.5*(2*nSm+nP)-nSm)]).*y1((N1+(i-1)*nP-nSm:N1+i*nP-1));     
            else            
   %             Res(N1+(i-1)*nP-nSm:N1+i*nP-1)=Res(N1+(i-1)*nP-nSm:N1+i*nP-1)+([a(1:0.5*(2*nSm+nP)) ones( 1,0.5*(2*nSm+nP)-nSm)]).*y0((N1+(i-1)*nP-nSm:N1+i*nP-1));     
            end
       else
           if(bits(nBit)==1)            
    %            Res(N1+(i-1)*nP:N1+i*nP-1+nSm)=Res(N1+(i-1)*nP:N1+i*nP-1+nSm)+([ones(1,0.5*(2*nSm+nP)-nSm) a(0.5*(2*nSm+nP)+1:numel(a))]).*y1(N1+(i-1)*nP:N1+i*nP-1+nSm);     
            else            
     %           Res(N1+(i-1)*nP:N1+i*nP-1+nSm)=Res(N1+(i-1)*nP:N1+i*nP-1+nSm)+([ones(1,floor(0.5*(2*nSm+nP))-nSm) a(0.5*(2*nSm+nP)+1:numel(a))]).*y0(N1+(i-1)*nP:N1+i*nP-1+nSm);     
            end
       end
    else
        if(bits(nBit)==1)
            x1=N1+(i-1)*nP-nSm;
            x2=N1+i*nP-1+nSm;
            
            Res(x1:x2)=Res(x1:x2)+a.*y1(x1:x2);     
            %Res(N1+(i-1)*nP-nSm:N1+i*nP-1+nSm)=Res(N1+(i-1)*nP-nSm:N1+i*nP-1+nSm)+a.*y1((N1+(i-1)*nP-nSm:N1+i*nP-1+nSm));     
            %Res(ceil(N1+(i-1)*nP-Smoothing*nP):floor(N1+i*nP-1+Smoothing*nP))=Res(ceil(N1+(i-1)*nP-Smoothing*nP):floor(N1+i*nP-1+Smoothing*nP))+a.*y1((ceil(N1+(i-1)*nP-Smoothing*nP):floor(N1+i*nP-1+Smoothing*nP)));     
        else
            Res(N1+(i-1)*nP-nSm:N1+i*nP-1+nSm)=Res(N1+(i-1)*nP-nSm:N1+i*nP-1+nSm)+a.*y0((N1+(i-1)*nP-nSm:N1+i*nP-1+nSm));
            %Res(ceil(N1+(i-1)*nP-Smoothing*nP):floor(N1+i*nP-1+Smoothing*nP))=Res(ceil(N1+(i-1)*nP-Smoothing*nP):floor(N1+i*nP-1+Smoothing*nP))+a.*y0((ceil(N1+(i-1)*nP-Smoothing*nP):floor(N1+i*nP-1+Smoothing*nP)));     
        end
    end
 end
end


end

