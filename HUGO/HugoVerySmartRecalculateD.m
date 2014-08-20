function [ diffD ] = HugoVerySmartRecalculateD(I,oldD,iChanged,jChanged)
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


%diffD=int16(zeros(3,2,8));
diffD=int16(zeros(3,9,8));


D=oldD;




%D(1) - from left to right
l=1;
k=1;
%for ind=[iChanged jChanged-1;iChanged jChanged]'
index=[iChanged jChanged-5;iChanged jChanged-4;iChanged jChanged-3; iChanged jChanged-2; iChanged jChanged-1;iChanged jChanged; iChanged jChanged+1; iChanged jChanged+2; iChanged jChanged+3; iChanged jChanged+4]';
for ind=index
    i=ind(1);j=ind(2);
    if(i>n||i<1||j<1||j>m-1) continue; end;        
   
     
    diffD(1,l,1)=i;
    diffD(2,l,1)=j;
    diffD(3,l,1)=I(i,j)-I(i,j+1);        
    l=l+1;
    
  
end




%D(2) - from right to left
l=1;
%for ind=[iChanged jChanged;iChanged jChanged+1]'
k=2;
index=[iChanged jChanged-4;iChanged jChanged-3;iChanged jChanged-2;iChanged jChanged-1;iChanged jChanged;iChanged jChanged+1;iChanged jChanged+2;iChanged jChanged+3;iChanged jChanged+4;iChanged jChanged+5]' ;
for ind=index
    i=ind(1);j=ind(2);
    if(j<2||i<1||j<1||j>m||i>n) continue; end;        
   
        
    diffD(1,l,2)=i;
    diffD(2,l,2)=j;
    diffD(3,l,2)=I(i,j)-I(i,j-1);      
    l=l+1;
    
    

end




%D(3) - from top to bottom
l=1;
%for ind=[iChanged-1 jChanged;iChanged jChanged]'
k=3;
index=[iChanged-5 jChanged;iChanged-4 jChanged;iChanged-3 jChanged; iChanged-2 jChanged; iChanged-1 jChanged; iChanged jChanged; iChanged+1 jChanged; iChanged+2 jChanged; iChanged+3 jChanged; iChanged+4 jChanged]' ;
for ind=index
    i=ind(1);j=ind(2);
    if(i>n-1||i<1||j<1||j>m||i>n) continue; end;   
   
    
    diffD(1,l,3)=i;
    diffD(2,l,3)=j;
    diffD(3,l,3)=I(i,j)-I(i+1,j);       
    l=l+1;
   
end


%D(4) - from bottom to top
l=1;
%for ind=[iChanged jChanged;iChanged+1 jChanged]'
k=4;
index=[iChanged-4 jChanged;iChanged-3 jChanged;iChanged-2 jChanged; iChanged-1 jChanged; iChanged jChanged; iChanged+1 jChanged; iChanged+2 jChanged; iChanged+3 jChanged; iChanged+4 jChanged; iChanged+5 jChanged]' ;
for ind=index
    i=ind(1);j=ind(2);
    if(i<2||i<1||j<1||j>m||i>n) continue; end;           
    
    
    diffD(1,l,4)=i;
    diffD(2,l,4)=j;
    diffD(3,l,4)=I(i,j)-I(i-1,j);         
    l=l+1;    
    
end


%D(5) - from upper left to bottom right
l=1;
%for ind=[iChanged-1 jChanged-1;iChanged jChanged]'
k=5;
index=[iChanged-5 jChanged-5;iChanged-4 jChanged-4;iChanged-3 jChanged-3;iChanged-2 jChanged-2;iChanged-1 jChanged-1;iChanged jChanged; iChanged+1 jChanged+1;iChanged+2 jChanged+2;iChanged+3 jChanged+3;iChanged+4 jChanged+4]';
for ind=index
    i=ind(1);j=ind(2);
    if(i>n-1||j>m-1||i<1||j<1||j>m||i>n) continue; end;           
            
    diffD(1,l,5)=i;
    diffD(2,l,5)=j;
    diffD(3,l,5)=I(i,j)-I(i+1,j+1);           
    l=l+1;
       
end

%D(6) - from bottom right to upper left
l=1;
%for ind=[iChanged jChanged;iChanged+1 jChanged+1]'
k=6;
index=[iChanged-4 jChanged-4;iChanged-3 jChanged-3;iChanged-2 jChanged-2;iChanged-1 jChanged-1;iChanged jChanged;iChanged+1 jChanged+1;iChanged+2 jChanged+2;iChanged+3 jChanged+3;iChanged+4 jChanged+4;iChanged+5 jChanged+5]';
for ind=index
    i=ind(1);j=ind(2);
    if(i<2||j<2||i<1||j<1||j>m||i>n) continue; end;           
        
    diffD(1,l,6)=i;
    diffD(2,l,6)=j;
    diffD(3,l,6)=I(i,j)-I(i-1,j-1);    
    l=l+1;
end

%D(7) - from upper right to bottom left
l=1;
%for ind=[iChanged jChanged;iChanged-1 jChanged+1]'
k=7;
index=[iChanged+4 jChanged-4;iChanged+3 jChanged-3;iChanged+2 jChanged-2;iChanged+1 jChanged-1; iChanged jChanged;iChanged-1 jChanged+1; iChanged-2 jChanged+2; iChanged-3 jChanged+3; iChanged-4 jChanged+4; iChanged-5 jChanged+5]';
for ind=index
    i=ind(1);j=ind(2);
    if(i>n-1||j<2||i<1||j<1||j>m||i>n) continue; end;      
                
    diffD(1,l,7)=i;
    diffD(2,l,7)=j;
    diffD(3,l,7)=I(i,j)-I(i+1,j-1);  
    l=l+1;    
end

%D(8) - from bottom left to upper right
l=1;
%for ind=[iChanged jChanged;iChanged+1 jChanged-1]'
k=8;
index=[iChanged-4 jChanged+4;iChanged-3 jChanged+3;iChanged-2 jChanged+2;iChanged-1 jChanged+1;iChanged jChanged;iChanged+1 jChanged-1;iChanged+2 jChanged-2;iChanged+3 jChanged-3;iChanged+4 jChanged-4;iChanged+5 jChanged-5]';
for ind=index
    i=ind(1);j=ind(2);
    if(i<2||j>m-1||i<1||j<1||j>m||i>n) continue; end;      
        
    diffD(1,l,8)=i;
    diffD(2,l,8)=j;
    diffD(3,l,8)= I(i,j)-I(i-1,j+1);     
    l=l+1;    

end



end

