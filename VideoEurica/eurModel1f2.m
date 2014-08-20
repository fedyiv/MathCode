function [Out] = eurModel1f2(m,sizeV,sizeH,PTr,nExp,pEmb,flags)
% This function does several (nExp) experiments with 'm' matrixes
% 'sizeV'x'sizeH'. It produses a table with nExp lines. Each line contains
% two values : 
% 1)Average correlation when every frame is generated from the previous one
% with transition probability PTr
% 2)Average correlation when every frame is generated independently 
% (particular case of (1) when PTr=0.5)
%flags: -q - quiet
%pEmb - parameter which shows that embedding is occured not in every
%I-frame but in frames with probability pEmb

if(isempty(strfind(flags,'-q')))
    flags_q=0;
else
    flags_q=1;
end


Out=zeros(nExp,2);

for i=1:nExp
  
    disp(['Processing ' num2str(i) ' from ' num2str(nExp)])
  
    %Without embedding, big Ptr
     Out(i,1)=eurModel1e(sizeV,sizeH,m,PTr);
   
    %Emulating embedding, Ptr should decrease
    Out(i,2)=eurModel1e2(sizeV,sizeH,m,PTr,pEmb);

end


if(flags_q==0)
    file=fopen(['d:\\work\\eurModel1f_' num2str(m) 'x' num2str(sizeV) 'x' num2str(sizeH) 'x' num2str(nExp) 'exp'   '.csv'],'w');


    fprintf(file,['euroModel1f:\n' 'm=' num2str(m) '\nsizeV=' num2str(sizeV) '\nsizeH=' num2str(sizeH) '\nnExp' num2str(nExp) '\ntransition Pobability=' num2str(PTr) '\n']);

    fprintf(file,'p=PTr;p=0.5\n');

    for i=1:nExp

        fprintf(file,'%f;%f\n',Out(i,1),Out(i,2));

    end

    fclose(file);
end


end

