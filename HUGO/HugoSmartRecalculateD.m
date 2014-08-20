function [ D ] = HugoSmartRecalculateD(I,oldD,iChanged,jChanged)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%D(1) - from left to right
%D(2) - from right to left
%D(3) - from top to bottom
%D(4) - from bottom to top
%D(5) - from upper left to bottom right
%D(6) - from bottom right to upper left
%D(7) - from upper right to bottom left
%D(8) - from bottom left to upper right

[n m] = size(I);


D=oldD;




%D(1) - from left to right
for ind=[iChanged jChanged-1;iChanged jChanged]'
    i=ind(1);j=ind(2);
    if(i>n||i<1||j<1||j>m-1) continue; end;        
    D(i,j,1)= I(i,j)-I(i,j+1);       
end




%D(2) - from right to left
for ind=[iChanged jChanged;iChanged jChanged+1]'
    i=ind(1);j=ind(2);
    if(j<2||i<1||j<1||j>m||i>n) continue; end;        
        D(i,j,2)= I(i,j)-I(i,j-1);       

end




%D(3) - from top to bottom
for ind=[iChanged-1 jChanged;iChanged jChanged]'
    i=ind(1);j=ind(2);
    if(i>n-1||i<1||j<1||j>m||i>n) continue; end;   
        D(i,j,3)= I(i,j)-I(i+1,j);       
    end


%D(4) - from bottom to top
for ind=[iChanged jChanged;iChanged+1 jChanged]'
    i=ind(1);j=ind(2);
    if(i<2||i<1||j<1||j>m||i>n) continue; end;           
    D(i,j,4)= I(i,j)-I(i-1,j);           
end


%D(5) - from upper left to bottom right
for ind=[iChanged-1 jChanged-1;iChanged jChanged]'
    i=ind(1);j=ind(2);
    if(i>n-1||j>m-1||i<1||j<1||j>m||i>n) continue; end;           
    D(i,j,5)= I(i,j)-I(i+1,j+1);         
end

%D(6) - from bottom right to upper left
for ind=[iChanged jChanged;iChanged+1 jChanged+1]'
    i=ind(1);j=ind(2);
    if(i<2||j<2||i<1||j<1||j>m||i>n) continue; end;           
    D(i,j,6)= I(i,j)-I(i-1,j-1);           
end

%D(7) - from upper right to bottom left
for ind=[iChanged jChanged;iChanged-1 jChanged+1]'
    i=ind(1);j=ind(2);
    if(i>n-1||j<2||i<1||j<1||j>m||i>n) continue; end;      
    D(i,j,7)= I(i,j)-I(i+1,j-1);       
end

%D(8) - from bottom left to upper right
for ind=[iChanged jChanged;iChanged+1 jChanged-1]'
    i=ind(1);j=ind(2);
    if(i<2||j>m-1||i<1||j<1||j>m||i>n) continue; end;      
    D(i,j,8)= I(i,j)-I(i-1,j+1);       

end



end

