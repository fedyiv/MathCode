function [  ] = HugoEmulateEmbeddingJ2f(alpha,dim,T,model_correction,directorySource,directorySG,ext,sigma,gamma,weightForm,weightMatrix,sign,h)
%Differs from HugoEmulateEmbeddingJ2 by the fact, that it takes h as parameter, instead of using default value 10.
% h is height of matrix used in STC


costsList=eurModel3getFiles([directorySource 'Costs\'],['d_' num2str(dim) 'T_' num2str(T) 'sigma_' num2str(sigma) 'gamma_' num2str(gamma) 'wf_' num2str(weightForm) 'sign_' num2str(sign) '.costs5']);
list=eurModel3getFiles(directorySource,ext);
N=numel(list);

if(numel(costsList)~=N)
    hugoExecutor=HugoExecutor(5,directorySource,dim,T,gamma,sigma,weightForm,weightMatrix,sign);
    hugoExecutor.calculateAllCosts();
end






for i=1:N

   if(~mod(i,20)) 
       disp(['Image ' list{i} ' is being processed'])
   end
   
    [fp fn fe]=fileparts(list{i});
    if(exist([directorySG fn '.' ext],'file'))
        continue;
    end
       
   im=imread(list{i});
    
    if(ndims(im)==3)
        im1=im(:,:,1);
    else
        im1=im;
    end
    
   % im1=im1(1:5,1:5);
    
    
    sz=size(im1);
    sizeX=sz(1);
    sizeY=sz(2);
    
    
    emb=round(rand(floor(alpha*sizeX*sizeY),1));
    
    
    
    Costs=HugoGetCostsCacheJ2(list{i},dim,T,sigma,gamma,weightForm,weightMatrix,sign);
    minCosts=min(Costs,[],3);
    rho_min=reshape(minCosts,[],1);
    lsbs=logical(bitget(reshape(im1,[],1),1));
   
    w=floor(1/alpha);
    H_hat=STC_Gen_Rnd_h_hat(h, w);
    
    sglsbs=logical(HugoSTCcode(lsbs,emb,rho_min,H_hat));
    
    bits_to_change=find(mod(lsbs+sglsbs,2))';
    
    if(model_correction==0)
            %Without model correction
            for ind = bits_to_change
                [i1 j]=ind2sub(size(im1),ind);
                if(Costs(i1,j,1)==Costs(i1,j,2))
                    if(round(rand)==1)%important change!!!
                        im1(i1,j)=im1(i1,j)-1;
                    else
                        im1(i1,j)=im1(i1,j)+1;
                    end                        
                elseif(Costs(i1,j,1)>Costs(i1,j,2))
                    im1(i1,j)=im1(i1,j)+1;
                else
                    im1(i1,j)=im1(i1,j)-1;
                end
            end
    elseif(model_correction==1)
            %Model correction strategy 1 - natural order of pixels           
           
            for ind = bits_to_change
                [i1 j]=ind2sub(size(im1),ind);
                
                Yp=im1(i1,j)+1;
                Ym=im1(i1,j)-1;
                dp=HugoGetDistortion3(im1,Yp,dim,T,sigma,gamma);
                dm=HugoGetDistortion3(im1,Ym,dim,T,sigma,gamma);
        
                if(dp>dm)
                    im1(i1,j)=im1(i1,j)-1;
                else
                    im1(i1,j)=im1(i1,j)+1;
                end
            end
    else
        assert(0);
        
    end
    
    
    if(ndims(im)==3)
        im(:,:,1)=im1;
    else
        im=im1;
    end
    [fp fn fe]=fileparts(list{i});
    imwrite(im,[directorySG fn '.' ext],ext);
    
end
end

