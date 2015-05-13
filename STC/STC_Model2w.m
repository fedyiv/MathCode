function [  ] = STC_Model2w( n,W,H,weightsModel )
%Function to calculate number of changes for embeding 1 information bit depending on h given w
%IMPORTANT if w << h then not enough paths will be to choose from by the
%end of w-block;

x=round(rand(1,n));
if(strcmp(weightsModel,'Ones'))
    rho=ones(size(x));
elseif(strcmp(weightsModel,'Rand_Float'))
    rho=rand(size(x));
else
    assert(0);
end
CostsWithoutCorrection=zeros(numel(H),numel(W));
relativeNumberOfChanges=zeros(numel(H),numel(W));
j=1;
for h=H
       
    for i=1:numel(W);
        m=round(rand(1,floor(n/W(i))));
        %Generating 'generetor' matrix for the code
        [h_hat, ~]=STC_Gen_Rnd_h_hat(h,W(i));
        %Perform Coding in two ways
        [y1, CostsWithoutCorrection(j,i), ~, ~] = STC_cod3(x, m, h_hat, rho);
    
    
        %Perform decoding
        m1=STC_decod(y1,h_hat,floor(n/W(i)));   
        disp(['w(i)=' num2str(W(i)) ' out of max w= ' num2str(W(numel(W)))]);
        relativeNumberOfChanges(j,i)=CostsWithoutCorrection(j,i)./numel(m);
        
       
    end    
    j=j+1;
    disp(['H(i)=' num2str(h) ' out of max h= ' num2str(H(numel(H)))]);
end


plotStyle = {'-','--','.-','-x','x','..','-.-'}; % add as many as you need

for i=1:numel(H)
    plot(W,relativeNumberOfChanges(i,:),plotStyle{i});    
    legendInfo{i} = ['h = ' num2str(H(i))]; 
    hold on;
end
xlabel('w'); ylabel('Number of changes/k');
legend(legendInfo)

relativeNumberOfChanges

end

