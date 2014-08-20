function [val] = newD(diffD,oldD,i,j,k)
    
    
        for l=1:2
            if(diffD(1,l,k)==i && diffD(2,l,k)==j)
                val=diffD(3,l,k);
                return;
            end
        end        
       
       val=oldD(i,j,k);
        
        %if(isnan(val))
        %    error('Val is NaN')
        %end
    

end