function [  ] = STC_Model6Time( n,w,h,weightsModel )
%Function to get dependency of calculation time from h


x=round(rand(1,n));
if(strcmp(weightsModel,'Ones'))
    rho=ones(size(x));
elseif(strcmp(weightsModel,'Rand_Float'))
    rho=rand(size(x));
else
    assert(0);
end

m=round(rand(1,floor(n/w)));

Time=zeros(size(h));
for i=1:numel(h);
    
    %Generating 'generetor' matrix for the code
    [h_hat, ~]=STC_Gen_Rnd_h_hat(h(i),w);
    
    tic;
    %Perform Coding 
    [~, ~, ~, ~] = STC_cod3(x, m, h_hat, rho);
    Time(i)=toc;

    disp(['h(i)=' num2str(h(i)) ' out of max h= ' num2str(h(numel(h)))]);
end

plot(h,Time,'--');
%legend('Time','CostsWithoutCorrection','CostsReplacing');
xlabel('t'); ylabel('Time');

end

