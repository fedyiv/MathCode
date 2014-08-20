function [ D ] = HugoGetD(I)
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
D=int16(inf*ones(n,m,8)); % This is some analoug of 'NULL' value. If we use zero instead these values will be calculated in co-occurence matrixes which results in error
% Probably it was possible to reduce matrixes by 1 row or column instead
% but it won't be comfortable since we want size to be the same to fit into
% 1 big array D

%D(1) - from left to right

%remember!!!
I=double(I);
for i=1:n
    for j=1:m-1
        D(i,j,1)= I(i,j)-I(i,j+1);       
    end
end

%D(2) - from right to left
for i=1:n
    for j=2:m
        D(i,j,2)= I(i,j)-I(i,j-1);       
    end
end

%D(3) - from top to bottom
for i=1:n-1
    for j=1:m
        D(i,j,3)= I(i,j)-I(i+1,j);       
    end
end

%D(4) - from bottom to top
for i=2:n
    for j=1:m
        D(i,j,4)= I(i,j)-I(i-1,j);       
    end
end


%D(5) - from upper left to bottom right
for i=1:n-1
    for j=1:m-1
        D(i,j,5)= I(i,j)-I(i+1,j+1);       
    end
end

%D(6) - from bottom right to upper left
for i=2:n
    for j=2:m
        D(i,j,6)= I(i,j)-I(i-1,j-1);       
    end
end

%D(7) - from upper right to bottom left
for i=1:n-1
    for j=2:m
        D(i,j,7)= I(i,j)-I(i+1,j-1);       
    end
end

%D(8) - from bottom left to upper right
for i=2:n
    for j=1:m-1
        D(i,j,8)= I(i,j)-I(i-1,j+1);       
    end
end


end

