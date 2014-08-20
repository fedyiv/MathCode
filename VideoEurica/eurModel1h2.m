function [  ] = eurModel1h2(sizeVH,PTr,mFr,nExp,pEmb)
% Function compute functions eurModel1g and eurModel1f on all combinations
% input parametres. It saves the  result in the csv file. Result is pfa and
% pm for every input combination

[m_sizeVH,~]=size(sizeVH);
[m_sizePTr]=numel(PTr);
[m_sizeFr]=numel(mFr);
[m_sizepEmb]=numel(pEmb);

tic;

file=fopen('d:\\work\\eurModel1h_status.csv','w');
fprintf(file,['eurModel1h:[' datestr(clock()) '] Starting...\n']);
fclose(file);

file=fopen('d:\\work\\eurModel1h_output.csv','w');
fprintf(file,['eurModel1h:[' datestr(clock()) '] Starting...\n']);
fprintf(file,['nExp=' num2str(nExp)]);
fprintf(file,['\nsize;mFrames;PTr;Pfa;Pm;pEmb\n']);

fclose(file);


for i=1:m_sizeVH


    
    sizeV=sizeVH(i,1);
    sizeH=sizeVH(i,2);
    
    
    file=fopen('d:\\work\\eurModel1h_status.csv','a');
    fprintf(file,['\neurModel1h:[' datestr(clock()) '] Starting new size :' num2str(sizeV) 'x' num2str(sizeH) ]);
    fclose(file);
    
    for j=1:m_sizePTr
        
        file=fopen('d:\\work\\eurModel1h_status.csv','a');
        fprintf(file,['\neurModel1h:[' datestr(clock()) '] Starting new probability :' num2str(PTr(j))]);
        fclose(file);
        
        for k=1:m_sizeFr
            file=fopen('d:\\work\\eurModel1h_status.csv','a');
            fprintf(file,['\neurModel1h:[' datestr(clock()) '] Starting new number of frames :' num2str(mFr(k))]);
            fclose(file);

            
            for l=1:m_sizepEmb
            
                file=fopen('d:\\work\\eurModel1h_status.csv','a');
                fprintf(file,['\neurModel1h:[' datestr(clock()) '] Starting new pEmb of frames :' num2str(pEmb(l))]);
                fclose(file);
                
                [threshold pfa pm]=eurModel1g(eurModel1f2(mFr(k),sizeV,sizeH,PTr(j),nExp,pEmb(l),'-q'),'-q');
            
                file=fopen('d:\\work\\eurModel1h_output.csv','a');
                fprintf(file,'%ix%i;%i;%f;%f;%f;%f\n',sizeV,sizeH,mFr(k),PTr(j),pfa,pm,pEmb(l));
                fclose(file);
            
            end
            
            
            

        end

    end

end



end

