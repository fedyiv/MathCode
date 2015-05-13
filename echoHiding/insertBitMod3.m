function Res=insertBitMod3(Mass,bit,N1,N2,n0,dlambda)


Res=Mass;


[odd,even]=splitMass(Mass);

N1=floor(N1/2);
N2=floor(N2/2);

lambdaOdd=AutoKorrFNorm(odd,N1,N2,n0);
lambdaEven=AutoKorrFNorm(even,N1,N2,n0);


flag=0;


delta=lambdaOdd-lambdaEven;

B=0.01;

while(flag==0)
    
    lambdaOdd=AutoKorrFNorm(odd,N1,N2,n0);
    lambdaEven=AutoKorrFNorm(even,N1,N2,n0);

      if(bit==1)  
        if(lambdaOdd-lambdaEven>dlambda)
            break;
        else
            odd=insertEcho(odd,N1,N2,B,n0);
            even=insertEcho(even,N1,N2,-B,n0);
        end
        
      else
          if(lambdaEven-lambdaOdd>dlambda)
            break;
        else
            odd=insertEcho(odd,N1,N2,-B,n0);
            even=insertEcho(even,N1,N2,B,n0);
        end
        
          
          
      end
    
    
end
Res=stickMass(odd,even);

end