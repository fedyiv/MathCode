function [Res] = insertBitModelQ65(y,N1,N2,bits,h0,h1,Npart)

N=N2-N1+1;
nB=floor(N/Npart);
nP=floor(nB/Npart);

ResM=zeros(Npart,nB);
ResMOut=ResM;

Res=y;

for i=1:Npart
  for j=1:Npart
      
      ResM(i,(j-1)*nP+1:j*nP)=y(N1+(i-1)*nP+(j-1)*nB:N1+i*nP-1+(j-1)*nB);        
  
  end
end



for i=1:numel(bits)
    if(bits(i)==1)
        ResMOut(i,1:nB)=filter(h1,[1],ResM(i,1:nB));
    else
        ResMOut(i,1:nB)=filter(h0,[1],ResM(i,1:nB));
    end
end


for i=1:Npart
  for j=1:Npart            
      Res(N1+(i-1)*nP+(j-1)*nB:N1+i*nP-1+(j-1)*nB)=ResMOut(i,(j-1)*nP+1:j*nP);  
  end
end

end

