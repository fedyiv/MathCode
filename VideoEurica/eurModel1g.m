function [threshold,pfa,pm] = eurModel1g(M,flags)
% Function receives two column of values. It's computes threshold as
% average  between average of each column. Then it classifies values
% according to this treshold and counts probability od false alarm - pfa 
% and probability of missing SG - pm
% flags :
% q - quiet


if(isempty(strfind(flags,'-q')))
    flags_q=0;
else
    flags_q=1;
end

if(flags_q==0)
    tic;
end


[m,~]=size(M);

threshold=mean(mean(M));

missing=0;
falseAlarm=0;


for i=1:m
    if(M(i,1)<threshold)
        missing=missing+1;
    end
    
    if(M(i,2)>threshold)
        falseAlarm=falseAlarm+1;
    end
    
    if(flags_q==0 && mod(i,10)==0)
        disp(['Computing i=' num2str(i) ' from ' num2str(m) ' Ellapsed time ' num2str(toc)]);
    end
    
end

pfa=falseAlarm/m;
pm=missing/m;


end

