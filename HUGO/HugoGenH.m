function H = HugoGenH(H_hat,nRows,nCols,m)

[h w]=size(H_hat);
H=zeros(max(nRows,h+numel(m)),max(nCols,w*numel(m)));

for i=1:numel(m)
    H(i:i+h-1,(i-1)*w+1:i*w)=H_hat;    
end

H=H(1:nRows,1:nCols);


end