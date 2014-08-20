function [ P ] = HugoModel5embAndAttackGrid2( pEmb,dim,T,model_correction,cmDir,sgDir,sigma,gamma,weightForm,weightMatrix,signed,probability,attackDim,attackT,attackSigma,attackBoxConstraint,forceRecalc )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

threadId=num2str(round(1000000*rand));
log=fopen('d:\tmp\Matlab-Trace.log','a');
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,'Starting');
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,[ 'pEmb=' num2str(pEmb)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['dim=' num2str(dim)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['model_correction=' num2str(model_correction)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['cmDir=' num2str(cmDir)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['sgDir=' num2str(sgDir)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['sigma=' num2str(sigma)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['gamma=' num2str(gamma)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['weightForm=' num2str(weightForm)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['weightMatrix=' mat2str(weightMatrix)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['signed=' num2str(signed)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['probability=' num2str(probability)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['attackDim=' num2str(attackDim)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['attackT=' num2str(attackT)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['attackSigma=' num2str(attackSigma)]);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['attackBoxConstraint=' num2str(attackBoxConstraint)]);
fclose(log);

P=inf*ones(numel(sigma)*numel(gamma),3);

pMatrix=zeros(numel(sigma),numel(gamma));

k=1;
PR=1;
for pr=probability
    I=1;
    for i=sigma
        J=1;
        for j=gamma
            dirSGTemp=[sgDir 'pEmb_' num2str(pEmb) '\pr_' num2str(pr) '\' 'dim_' num2str(dim) '\' 'T_' num2str(T) '\'  'signed_' num2str(signed) '\' '\' 'weightForm_' num2str(weightForm) '\' 'sigma_' num2str(i) '\' 'gamma_' num2str(j) '\'];
            if(exist([dirSGTemp 'test'],'dir')==0)
                mkdir(dirSGTemp,'test');
            end
            if(exist([dirSGTemp 'train'],'dir')==0)
                mkdir(dirSGTemp,'train');
            end
            P(k,1)=i;
            P(k,2)=j;
            P(k,3)=pr;
            [~, P(k,4)] = evalc('HugoModel5embAndAttack2( pEmb,dim,T,model_correction,cmDir,dirSGTemp,i,j,weightForm,weightMatrix,signed,pr,attackDim,attackT,attackSigma,attackBoxConstraint,forceRecalc);');    
            disp(['sigma=' num2str(i) 'gamma=' num2str(j) 'pr=' num2str(P(k,3)) 'p=' num2str(P(k,4))]);
            
            log=fopen('d:\tmp\Matlab-Trace.log','a');
            fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['sigma=' num2str(i) 'gamma=' num2str(j) 'p=' num2str(P(k,3))]);
            fclose(log);
            
            pMatrix(I,J)=P(k,3);
            k=k+1;
            J=J+1;
    end
    I=I+1;
    end
    PR=PR+1;
end

for p=pr
    figure=surf(gamma,sigma,pMatrix);
    xlabel('gamma');
    ylabel('sigma');
    zlabel('pErr(sigma,gamma)');
    title(['pr=' num2str(p) ])
end

saveas(figure,['d:\tmp\fig' num2str(threadId) '.png' ]);

log=fopen('d:\tmp\Matlab-Trace.log','a');
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,['Saved result to ' 'd:\tmp\fig' num2str(threadId) '.png']);
fprintf(log,'\n%s [%s-%s] %s',datestr(clock),mfilename,threadId,'Finished');
fclose(log);

end

