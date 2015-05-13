function [  ] = STC_Model2h( n,W,h,weightsModel )
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
CostsWithoutCorrection=zeros(numel(W),numel(h));
relativeNumberOfChanges=zeros(numel(W),numel(h));
j=1;
for w=W
    m=round(rand(1,floor(n/w)));
    
    for i=1:numel(h);
        %Generating 'generetor' matrix for the code
        [h_hat, ~]=STC_Gen_Rnd_h_hat(h(i),w);
        %Perform Coding in two ways
        [y1, CostsWithoutCorrection(j,i), ~, ~] = STC_cod3(x, m, h_hat, rho);
    
    
        %Perform decoding
        m1=STC_decod(y1,h_hat,floor(n/w));   
        disp(['h(i)=' num2str(h(i)) ' out of max h= ' num2str(h(numel(h)))]);
        
       
    end
    relativeNumberOfChanges(j,:)=CostsWithoutCorrection(j,:)./numel(m);
    j=j+1;
    disp(['W(i)=' num2str(w) ' out of max w= ' num2str(W(numel(W)))]);
end


plotStyle = {'-','--','.-','-x','x','..','-.-'}; % add as many as you need

for i=1:numel(W)
    plot(h,relativeNumberOfChanges(i,:),plotStyle{i});    
    legendInfo{i} = ['w = ' num2str(W(i))]; 
    hold on;
end
xlabel('h'); ylabel('Number of changes/k');
legend(legendInfo)

relativeNumberOfChanges

end

