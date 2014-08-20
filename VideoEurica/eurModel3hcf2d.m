function [ hcf ] = eurModel3hcf2d(inBlock)
%Function computes HISTOGRAM CHARACTERISTIC FUNCTION (HCF)
% It is Fourier Transform of histogram


h2d=zeros(256,256);
[M N]=size(inBlock);



%for i=1:255
 %   disp(['String ' num2str(i)]);
 %   for j=1:255
 %       
   %     for k=1:M
  %          for l=1:N-1
  %              if(inBlock(k,l)==i & inBlock(k,l+1)==j)
  %                  h2d(i,j)=h2d(i,j)+1;
  %              end            
  %      end
  %      
  %  end
  %  end


    for k=1:M
       % disp(['String ' num2str(k)]);
          for l=1:N-1
            h2d(inBlock(k,l)+1,inBlock(k,l+1)+1)=h2d(inBlock(k,l)+1,inBlock(k,l+1)+1)+1;
          end
    end
    




hcf=abs(fft2(h2d));
hcf=hcf(1:128,1:128);
end

