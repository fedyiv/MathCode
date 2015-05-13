function [bits lambda00 lambda11] = extractBitModelQ65(y,N1,N2,h0,h1,Npart,NExtZeros,window,blockType)

N=N2-N1+1;
nB=floor(N/Npart);
nP=floor(nB/Npart);

ResM=zeros(Npart,nB);
Res=y;

bits=zeros(1,Npart);
lambda00=zeros(1,Npart);
lambda11=zeros(1,Npart);

for i=1:Npart
  for j=1:Npart
      
      ResM(i,(j-1)*nP+1:j*nP)=y(N1+(i-1)*nP+(j-1)*nB:N1+i*nP-1+(j-1)*nB);        
  
  end
end



for i=1:numel(bits)
        lambda0=corrCepstrMulti2(ResM(i,1:nB),h0,Npart,NExtZeros,window,blockType);
        lambda1=corrCepstrMulti2(ResM(i,1:nB),h1,Npart,NExtZeros,window,blockType);
    
        if(lambda1>lambda0)
            bits(i)=1;
        else
            bits(i)=0;
        end
        
        lambda00(i)=lambda0;
        lambda11(i)=lambda1;
        
end

end

