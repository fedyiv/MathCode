function [ diffD ] = HugoVerySmartRecalculateD2(I,oldD,iChanged,jChanged)
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



diffD=cell(1,8);
for i=1:8
    diffD{i}=sparse(n,m);   
end



D=oldD;




%D(1) - from left to right

k=1;

for ind=[iChanged jChanged-5;iChanged jChanged-4;iChanged jChanged-3; iChanged jChanged-2; iChanged jChanged-1;iChanged jChanged; iChanged jChanged+1; iChanged jChanged+2; iChanged jChanged+3; iChanged jChanged+4]'
    i=ind(1);j=ind(2);
    if(i>n||i<1||j<1||j>m-1) continue; end;        
    

    diffD{k}(i,j)=I(i,j)-I(i,j+1); 
    
end




%D(2) - from right to left
k=2;
for ind=[iChanged jChanged-4;iChanged jChanged-3;iChanged jChanged-2;iChanged jChanged-1;iChanged jChanged;iChanged jChanged+1;iChanged jChanged+2;iChanged jChanged+3;iChanged jChanged+4;iChanged jChanged+5]' 
    i=ind(1);j=ind(2);
    if(j<2||i<1||j<1||j>m||i>n) continue; end;        
   
    
     diffD{k}(i,j)=I(i,j)-I(i,j-1);      

end




%D(3) - from top to bottom

k=3;
for ind=[iChanged-5 jChanged;iChanged-4 jChanged;iChanged-3 jChanged; iChanged-2 jChanged; iChanged-1 jChanged; iChanged jChanged; iChanged+1 jChanged; iChanged+2 jChanged; iChanged+3 jChanged; iChanged+4 jChanged]' 
    i=ind(1);j=ind(2);
    if(i>n-1||i<1||j<1||j>m||i>n) continue; end;   
   
     diffD{k}(i,j)=I(i,j)-I(i+1,j);        

end


%D(4) - from bottom to top

k=4;
for ind=[iChanged-4 jChanged;iChanged-3 jChanged;iChanged-2 jChanged; iChanged-1 jChanged; iChanged jChanged; iChanged+1 jChanged; iChanged+2 jChanged; iChanged+3 jChanged; iChanged+4 jChanged; iChanged+5 jChanged]' 
    i=ind(1);j=ind(2);
    if(i<2||i<1||j<1||j>m||i>n) continue; end;           
    
     diffD{k}(i,j)=I(i,j)-I(i-1,j);         
    
end


%D(5) - from upper left to bottom right

k=5;
for ind=[iChanged-5 jChanged-5;iChanged-4 jChanged-4;iChanged-3 jChanged-3;iChanged-2 jChanged-2;iChanged-1 jChanged-1;iChanged jChanged; iChanged+1 jChanged+1;iChanged+2 jChanged+2;iChanged+3 jChanged+3;iChanged+4 jChanged+4]'
    i=ind(1);j=ind(2);
    if(i>n-1||j>m-1||i<1||j<1||j>m||i>n) continue; end;           
    
    diffD{k}(i,j)=I(i,j)-I(i+1,j+1);           
end

%D(6) - from bottom right to upper left

k=6;
for ind=[iChanged-4 jChanged-4;iChanged-3 jChanged-3;iChanged-2 jChanged-2;iChanged-1 jChanged-1;iChanged jChanged;iChanged+1 jChanged+1;iChanged+2 jChanged+2;iChanged+3 jChanged+3;iChanged+4 jChanged+4;iChanged+5 jChanged+5]'
    i=ind(1);j=ind(2);
    if(i<2||j<2||i<1||j<1||j>m||i>n) continue; end;           
    
    diffD{k}(i,j)=I(i,j)-I(i-1,j-1); 
end

%D(7) - from upper right to bottom left

k=7;
for ind=[iChanged+4 jChanged-4;iChanged+3 jChanged-3;iChanged+2 jChanged-2;iChanged+1 jChanged-1; iChanged jChanged;iChanged-1 jChanged+1; iChanged-2 jChanged+2; iChanged-3 jChanged+3; iChanged-4 jChanged+4; iChanged-5 jChanged+5]'
    i=ind(1);j=ind(2);
    if(i>n-1||j<2||i<1||j<1||j>m||i>n) continue; end;      
                

    diffD{k}(i,j)=I(i,j)-I(i+1,j-1); 
end

%D(8) - from bottom left to upper right
k=8;
for ind=[iChanged-4 jChanged+4;iChanged-3 jChanged+3;iChanged-2 jChanged+2;iChanged-1 jChanged+1;iChanged jChanged;iChanged+1 jChanged-1;iChanged+2 jChanged-2;iChanged+3 jChanged-3;iChanged+4 jChanged-4;iChanged+5 jChanged-5]'
    i=ind(1);j=ind(2);
    if(i<2||j>m-1||i<1||j<1||j>m||i>n) continue; end;      
        

     diffD{k}(i,j)=I(i,j)-I(i-1,j+1);

end



end

