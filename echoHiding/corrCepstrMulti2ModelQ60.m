function  R  = corrCepstrMulti2ModelQ60(y,h,Npart,NExtZeros,window,blockType,MOS,DS)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[m,n]=size(y);

Np=floor(n/Npart);

Scep=zeros(1,NExtZeros);


t=1:NExtZeros;

%w=0.96.^t;



    

if(blockType==1)

    for i=1:Npart
        
        if(strcmp(window,'hann')==1)
            w=(hann(i*Np))';
    
        else
            if (strcmp(window,'hamming')==1)
                w=(hamming(i*Np))';
            else
                if(strcmp(window,'exp')==1)
                   a0=0.01^(1/(i*Np));
                   w=a0.^t;
                else
                    w=ones(1,NExtZeros);
                end
            end
        end
            
        [R,cTemp,ch]=corrCepstr(y(1:i*Np),NExtZeros,h,w);
        Scep=Scep+cTemp;
    end
else
    if(blockType==2)
         
        if(strcmp(window,'hann')==1)
            w=(hann(Np))';
    
        else
            if (strcmp(window,'hamming')==1)
                w=(hamming(Np))';
            else
                if(strcmp(window,'exp')==1)
                    a0=0.01^(1/(Np));
                    w=a0.^t;
                else
                    w=ones(1,NExtZeros);
                end
            end
         end
         
         for i=1:Npart
            [R,cTemp,ch]=corrCepstr([y((i-1)*Np+1:i*Np)],NExtZeros,h,w);
            Scep=Scep+cTemp;
        end
    else
        if(blockType==3)
            if(strcmp(window,'hann')==1)
            w=(hann(Np))';
    
            else
               if (strcmp(window,'hamming')==1)
                  w=(hamming(Np))';
               else
                    if(strcmp(window,'exp')==1)
                        a0=0.01^(1/(Np));
                        w=a0.^t;
                    else
                        w=ones(1,NExtZeros);
                    end
               end
            end
         
            
            for i=1:n-Np-1
                [R,cTemp,ch]=corrCepstr([y((1+i):(1+i+Np))],NExtZeros,h,w);
                Scep=Scep+cTemp;
            end

        
        
        end
    end
end
%plot(Scep);

R = corr((Scep'-MOS),ch');

end

