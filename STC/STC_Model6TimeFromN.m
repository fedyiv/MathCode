function [  ] = STC_Model6TimeFromN( n,w,h,weightsModel )
%Function to get dependency of calculation time from h


Time=zeros(size(n));

%Generating 'generetor' matrix for the code
    [h_hat, ~]=STC_Gen_Rnd_h_hat(h,w);
    
for i=1:numel(n);  

    x=round(rand(1,n(i)));
    if(strcmp(weightsModel,'Ones'))
        rho=ones(size(x));
    elseif(strcmp(weightsModel,'Rand_Float'))
        rho=rand(size(x));
    else
        assert(0);
    end

    m=round(rand(1,floor(n(i)/w)));
    
    tic;
    %Perform Coding 
    [~, ~, ~, ~] = STC_cod3(x, m, h_hat, rho);
    Time(i)=toc;

    disp(['n(i)=' num2str(n(i)) ' out of max n= ' num2str(n(numel(n)))]);
end

plot(n,Time,'--');
%legend('Time','CostsWithoutCorrection','CostsReplacing');
xlabel('n'); ylabel('Time');

end

