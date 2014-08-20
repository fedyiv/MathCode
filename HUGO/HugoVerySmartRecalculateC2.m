function [C] = HugoVerySmartRecalculateC2(oldD,diffD,oldC,iChanged,jChanged,dim,T)
%Purpose of this function is to speed up calculation of C in cases when it
%was already calculated and only 1 sample of image was changed
%

[n m K] = size(oldD);
if(K~=8)
    error('What a shit???!!!')
end



%One changed pixel in the image will result in change of two samples of D
%in each direction(for the samples of D on Border - 1 sample will be changed)


%Calculating how this change will affect C


C=oldC.*(m*n);



if(dim==2)
    k=uint16(1);
    for i=iChanged
        for j=[jChanged-2 jChanged-1 jChanged jChanged+1]
            if(j > m-2||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i,j+1,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i,j+1,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i,j+1,k)+T+1,k)-1;                
            end
            
            if(abs(newD(diffD,i,j,k))<=T && abs(newD(diffD,i,j+1,k))<=T)                
                C(newD(diffD,oldD,i,j,k)+T+1,newD(diffD,oldD,i,j+1,k)+T+1,k)=C(newD(diffD,oldD,i,j,k)+T+1,newD(diffD,oldD,i,j+1,k)+T+1,k)+1;                
            end
            
        end
    end
    
     k=uint16(2);
    for i=1:iChanged
        for j=[jChanged-1 jChanged jChanged+1 jChanged+2]
            if(j < 2||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i,j-1,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i,j-1,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i,j-1,k)+T+1,k)-1;               
            end
            if(abs(newD(diffD,oldD,i,j,k))<=T && abs(diffD{k}(i,j-1))<=T)
                C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i,j-1)+T+1,k)=C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i,j-1)+T+1,k)+1;
            end
            
        end
    end
    
    k=uint16(3);
    for i=[iChanged-2 iChanged-1 iChanged iChanged+1]       
        for j=jChanged
            if(i>n-1||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i+1,j,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i+1,j,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i+1,j,k)+T+1,k)-1;               
            end
            
            if(abs(newD(diffD,oldD,i,j,k))<=T && abs(diffD{k}(i+1,j))<=T)                
                C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i+1,j)+T+1,k)=C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i+1,j)+T+1,k)+1;
            end
        end
    end
    
     k=uint16(4);
    for i=[iChanged-1 iChanged iChanged+1 iChanged+2]      
        for j=jChanged
            if(i<2||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i-1,j,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i-1,j,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i-1,j,k)+T+1,k)-1;
               
            end
            if(abs(newD(diffD,oldD,i,j,k))<=T && abs(diffD{k}(i-1,j))<=T)
               
                C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i-1,j)+T+1,k)=C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i-1,j)+T+1,k)+1;
             end
            
        end
    end
    
    k=uint16(5);
    for ind=[iChanged-2 jChanged-2;iChanged-1 jChanged-1;iChanged jChanged; iChanged+1 jChanged+1]'
        i=ind(1);
        j=ind(2);
        
            if(i>n-1 || j> m-1||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i+1,j+1,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i+1,j+1,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i+1,j+1,k)+T+1,k)-1;               
            end
            if(abs(newD(diffD,oldD,i,j,k))<=T && abs(diffD{k}(i+1,j+1))<=T)                
                C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i+1,j+1)+T+1,k)=C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i+1,j+1)+T+1,k)+1;
            end
        
    end
    
     k=uint16(6);
  for ind=[iChanged-1 jChanged-1;iChanged jChanged;iChanged+1 jChanged+1;iChanged+2 jChanged+2]'
        i=ind(1);
        j=ind(2);
            if(i<2 || j<2||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i-1,j-1,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i-1,j-1,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i-1,j-1,k)+T+1,k)-1;                
            end
            
             if(abs(newD(diffD,oldD,i,j,k))<=T && abs(diffD{k}(i-1,j-1))<=T)
                 C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i-1,j-1)+T+1,k)=C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i-1,j-1)+T+1,k)+1;
            end
      
    end
    
     k=uint16(7);
    for ind=[iChanged+1 jChanged-1; iChanged jChanged;iChanged-1 jChanged+1; iChanged-2 jChanged+2]'
        i=ind(1);
        j=ind(2);
            if(i>n-1 || j<2||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i+1,j-1,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i+1,j-1,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i+1,j-1,k)+T+1,k)-1;
               
            end
            if(abs(newD(diffD,oldD,i,j,k))<=T && abs(diffD{k}(i+1,j-1))<=T)
               
                C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i+1,j-1)+T+1,k)=C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i+1,j-1)+T+1,k)+1;
            end
        
    end
    
     k=uint16(8);
   for ind=[iChanged-1 jChanged+1;iChanged jChanged;iChanged+1 jChanged-1;iChanged+2 jChanged-2]'
        i=ind(1);
        j=ind(2);
            if(i<2 || j>m-1||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i-1,j+1,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i-1,j+1,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i-1,j+1,k)+T+1,k)-1;
               
            end
            if(abs(newD(diffD,oldD,i,j,k))<=T && abs(diffD{k}(i-1,j+1))<=T)
               
                C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i-1,j+1)+T+1,k)=C(newD(diffD,oldD,i,j,k)+T+1,diffD{k}(i-1,j+1)+T+1,k)+1;
            end
        
    end
    
elseif(dim==3)
   
    
        k=uint16(1);
    for i=iChanged
        %for j=[jChanged-3 jChanged-2 jChanged-1 jChanged jChanged+1 jChanged+2]
        for j=[jChanged-3 jChanged-2 jChanged-1  jChanged]
            if(j > m-3||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i,j+1,k))<=T && abs(oldD(i,j+2,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i,j+1,k)+T+1,oldD(i,j+2,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i,j+1,k)+T+1,oldD(i,j+2,k)+T+1,k)-1;
            end
            
            %if(abs(diffD{k}(i,j))<=T && abs(diffD{k}(i,j+1))<=T && abs(diffD{k}(i,j+2))<=T)              
            %    C(diffD{k}(i,j)+T+1,diffD{k}(i,j+1)+T+1,diffD{k}(i,j+2)+T+1,k)=C(diffD{k}(i,j)+T+1,diffD{k}(i,j+1)+T+1,diffD{k}(i,j+2)+T+1,k)+1;
            %end
            
            d1=diffD{k}(i,j);d2=diffD{k}(i,j+1);d3=diffD{k}(i,j+2);
            if(abs(d1)<=T && abs(d2)<=T && abs(d3)<=T)              
                C(d1+T+1,d2+T+1,d3+T+1,k)=C(d1+T+1,d2+T+1,d3+T+1,k)+1;
            end
            
        end
    end

    
      k=uint16(2);
    for i=iChanged
        %for j=[jChanged-2 jChanged-1 jChanged jChanged+1 jChanged+2 jChanged+3] 
        for j=[jChanged jChanged+1 jChanged+2 jChanged+3] 
            if(j < 4||i<1||i>n ||j>m) continue; end;
             if(abs(oldD(i,j,k))<=T && abs(oldD(i,j-1,k))<=T && abs(oldD(i,j-2,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i,j-1,k)+T+1,oldD(i,j-2,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i,j-1,k)+T+1,oldD(i,j-2,k)+T+1,k)-1;
             end
             d1=diffD{k}(i,j);d2=diffD{k}(i,j-1);d3=diffD{k}(i,j-2);
             if(abs(d1)<=T && abs(d2)<=T && abs(d3)<=T)
                C(d1+T+1,d2+T+1,d3+T+1,k)=C(d1+T+1,d2+T+1,d3+T+1,k)+1;
            end
            
        end
    end
    
     
    
     k=uint16(3);
    %for i=[iChanged-3 iChanged-2 iChanged-1 iChanged iChanged+1 iChanged+2]       
     for i=[iChanged-3 iChanged-2 iChanged-1 iChanged]       
        for j=jChanged
            if(i>n-3||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i+1,j,k))<=T && abs(oldD(i+2,j,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i+1,j,k)+T+1,oldD(i+2,j,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i+1,j,k)+T+1,oldD(i+2,j,k)+T+1,k)-1;
            end
            d1=diffD{k}(i,j);d2=diffD{k}(i+1,j); d3=diffD{k}(i+2,j);
           if(abs(d1)<=T && abs(d2)<=T && abs(d3)<=T)
                C(d1+T+1,d2+T+1,d3+T+1,k)=C(d1+T+1,d2+T+1,d3+T+1,k)+1;
            end
        end
    end
    
     k=uint16(4);
    %for i=[iChanged-2 iChanged-1 iChanged iChanged+1 iChanged+2 iChanged+3]      
    for i=[iChanged iChanged+1 iChanged+2 iChanged+3]      
        for j=jChanged
            if(i<4||j<1||i<1||i>n ||j>m) continue; end;
           if(abs(oldD(i,j,k))<=T && abs(oldD(i-1,j,k))<=T && abs(oldD(i-2,j,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i-1,j,k)+T+1,oldD(i-2,j,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i-1,j,k)+T+1,oldD(i-2,j,k)+T+1,k)-1;
               
           end
            d1=diffD{k}(i,j);d2=diffD{k}(i-1,j); d3=diffD{k}(i-2,j);
            if(abs(d1)<=T && abs(d2)<=T && abs(d3)<=T)
                C(d1+T+1,d2+T+1,d3+T+1,k)=C(d1+T+1,d2+T+1,d3+T+1,k)+1;
             end
            
        end
    end
    
   
    
     k=uint16(5);
   % for ind=[iChanged-3 jChanged-3;iChanged-2 jChanged-2;iChanged-1 jChanged-1;iChanged jChanged; iChanged+1 jChanged+1;iChanged+2 jChanged+2]'
    for ind=[iChanged-3 jChanged-3;iChanged-2 jChanged-2;iChanged-1 jChanged-1;iChanged jChanged]'
        i=ind(1);
        j=ind(2);
        
            if(i>n-3 || j> m-3||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i+1,j+1,k))<=T && abs(oldD(i+2,j+2,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i+1,j+1,k)+T+1,oldD(i+2,j+2,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i+1,j+1,k)+T+1,oldD(i+2,j+2,k)+T+1,k)-1;               
            end
            d1=diffD{k}(i,j);d2=diffD{k}(i+1,j+1);d3=diffD{k}(i+2,j+2);
            if(abs(d1)<=T && abs(d2)<=T && abs(d3)<=T)
                C(d1+T+1,d2+T+1,d3+T+1,k)=C(d1+T+1,d2+T+1,d3+T+1,k)+1;
            end
        
    end
    
     
    
       k=uint16(6);
  %for ind=[iChanged-2 jChanged-2;iChanged-1 jChanged-1;iChanged jChanged;iChanged+1 jChanged+1;iChanged+2 jChanged+2;iChanged+3 jChanged+3]'
  for ind=[iChanged jChanged;iChanged+1 jChanged+1;iChanged+2 jChanged+2;iChanged+3 jChanged+3]'
        i=ind(1);
        j=ind(2);
            if(i<4 || j<4||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i-1,j-1,k))<=T && abs(oldD(i-2,j-2,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i-1,j-1,k)+T+1,oldD(i-2,j-2,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i-1,j-1,k)+T+1,oldD(i-2,j-2,k)+T+1,k)-1;                
            end
            d1=diffD{k}(i,j); d2=diffD{k}(i-1,j-1);d3=diffD{k}(i-2,j-2);
             if(abs(d1)<=T && abs(d2)<=T && abs(d3)<=T)
                C(d1+T+1,d2+T+1,d3+T+1,k)=C(d1+T+1,d2+T+1,d3+T+1,k)+1;
            end
      
  end
    

    
     k=uint16(7);
    %for ind=[iChanged+2 jChanged-2;iChanged+1 jChanged-1; iChanged jChanged;iChanged-1 jChanged+1; iChanged-2 jChanged+2; iChanged-3 jChanged+3]'
    for ind=[iChanged jChanged;iChanged-1 jChanged+1; iChanged-2 jChanged+2; iChanged-3 jChanged+3]'
    
        i=ind(1);
        j=ind(2);
            if(i>n-3 || j<4||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i+1,j-1,k))<=T && abs(oldD(i+2,j-2,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i+1,j-1,k)+T+1,oldD(i+2,j-2,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i+1,j-1,k)+T+1,oldD(i+2,j-2,k)+T+1,k)-1;
               
            end
            d1= diffD{k}(i,j);d2=diffD{k}(i+1,j-1); d3=diffD{k}(i+2,j-2);
            if(abs(d1)<=T && abs(d2)<=T && abs(d3)<=T)
                C(d1+T+1,d2+T+1,d3+T+1,k)=C(d1+T+1,d2+T+1,d3+T+1,k)+1;
            end
        
    end
    
     k=uint16(8);
   %for ind=[iChanged-2 jChanged+2;iChanged-1 jChanged+1;iChanged jChanged;iChanged+1 jChanged-1;iChanged+2 jChanged-2;iChanged+3 jChanged-3]'
    for ind=[iChanged jChanged;iChanged+1 jChanged-1;iChanged+2 jChanged-2;iChanged+3 jChanged-3]'
        i=ind(1);
        j=ind(2);
            if(i<4 || j>m-3||j<1||i<1||i>n ||j>m) continue; end;
            if(abs(oldD(i,j,k))<=T && abs(oldD(i-1,j+1,k))<=T && abs(oldD(i-2,j+2,k))<=T)
                C(oldD(i,j,k)+T+1,oldD(i-1,j+1,k)+T+1,oldD(i-2,j+2,k)+T+1,k)=C(oldD(i,j,k)+T+1,oldD(i-1,j+1,k)+T+1,oldD(i-2,j+2,k)+T+1,k)-1;               
            end
            d1=diffD{k}(i,j);d2=diffD{k}(i-1,j+1);d3=diffD{k}(i-2,j+2);
            if(abs(d1)<=T && abs(d2)<=T && abs(d3)<=T)
                C(d1+T+1,d2+T+1,d3+T+1,k)=C(d1+T+1,d2+T+1,d3+T+1,k)+1;
            end
        
    end
    
 
    
end


 C=C/(m*n);
 

end

function [val] = newD(diffD,oldD,i,j,k)
    
    
        for l=1:9
            if(diffD(1,l,k)==i && diffD(2,l,k)==j)
                val=diffD(3,l,k);
                return;
            end
        end        
       
       val=oldD(i,j,k);
      % error('Error');
        
        %if(isnan(val))
        %    error('Val is NaN')
        %end
    

end

