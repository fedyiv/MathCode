classdef block < handle
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Constant=true)
        blockSize=8;
        quantizationMatrixIntra=[8 16 19 22 26 27 29 34;16 16 22	24	27	29	34	37;19	22	26	27	29	34	34	38;22	22	26	27	29	34	37	40;22	26	27	29	32	35	40	48;26	27	29	32	35	40	48	58;26	27	29	34	38	46	56	69;27	29	35	38	46	56	69	83];
        quantizationMatrixNonIntra=[16	17	18	19	21	23	25	27;	17	18	18	21	23	25	27	29;18	19	20	22	24	26	28	31;19	20	22	24	26	28	30	33;20	22	24	26	28	30	32	35;21	23	25	27	29	32	35	38;23	25	27	29	31	34	38	42;25	27	29	31	34	38	42	47];
        intra_dc_mult=1;
        quant_scale_type=0;
        quantiser_scale=[2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62;1 2 3 4 5 6 7 8 10 12 14 16 18 20 22 24 28 32 36 40 44 48 52 56 64 72 80 88 96 104 112];
        
    end
    
    properties
        blockBody;
        blockDCT;
        isIntra;% (Y|N)
        quantiser_scale_code;
    end
    
    methods
     function obj = block(inBlock,space,isIntra,quantiser_scale_code)
            if nargin > 0
                 obj.isIntra=isIntra;
                 obj.quantiser_scale_code=quantiser_scale_code;
                if(strcmp(space, 'spatial'))
                    obj.blockBody=inBlock;
                    obj.blockDCT=dct2(obj.blockBody);
                    obj.quantize();
                elseif(strcmp(space, 'dct'))
                    obj.blockDCT=inBlock;
                    obj.deQuantize();
                    obj.blockBody=idct2(obj.blockDCT);                    
                end
            else
                obj.blockBody=zeros(obj.blockSize);
                obj.blockDCT=zeros(obj.blockSize);
            end
            
           
                
        end
        
        function quantize(obj)
            if(obj.isIntra=='Y')
                DC=obj.blockDCT(1,1);
                obj.blockDCT=(16*obj.blockDCT./(obj.quantizationMatrixIntra*obj.quantiser_scale(obj.quant_scale_type+1, obj.quantiser_scale_code)))+sign(obj.blockDCT)/2;
                obj.blockDCT(1,1)=DC/obj.intra_dc_mult;
                
            else
                obj.blockDCT=(16*obj.blockDCT./(obj.quantizationMatrixNonIntra*obj.quantiser_scale(obj.quant_scale_type+1,obj.quantiser_scale_code)));
            end
            obj.blockDCT=round(obj.blockDCT);
            
        end
        
        
        
        function deQuantize(obj)
       
       %Inverse-quantization ariphmetic
       if(obj.isIntra=='Y')
           DC=obj.blockDCT(1,1);
           obj.blockDCT=((2*obj.blockDCT+sign(obj.blockDCT)).*obj.quantizationMatrixIntra*obj.quantiser_scale(obj.quant_scale_type+1,obj.quantiser_scale_code))/32;
           obj.blockDCT(1,1)=obj.intra_dc_mult*DC;       
       else
           obj.blockDCT=((2*obj.blockDCT).*obj.quantizationMatrixNonIntra*obj.quantiser_scale(obj.quant_scale_type+1,obj.quantiser_scale_code))/32;
       end
       
       %Saturation
       for i=1:8
           for j=1:8
               if(obj.blockDCT(i,j)< -2048)
                   obj.blockDCT(i,j)= -2048;
               elseif(obj.blockDCT(i,j)> 2047)
                   obj.blockDCT(i,j)= 2047;
               end
           end
       end
       %Mismatch control
       if(mod(sum(reshape(obj.blockDCT,1,[])),2)==0)
           if(mod(obj.blockDCT(8,8),2)==0)
               obj.blockDCT(8,8)=obj.blockDCT(8,8)+1;
           else
               obj.blockDCT(8,8)=obj.blockDCT(8,8)-1;
           end
       end
       
           
        end
        
        function bbs = toBitStream(obj)
            blockSize=obj.blockSize;
            k=blockSize^2;
            bbs=uint16(zeros(1,k));
            blockDCT=obj.blockDCT+2048;
            for i=1:k
                bbs(k)=uint16(blockDCT(floor((i-1)/blockSize)+1,mod(i-1,blockSize)+1));
            end
        end
        
        function obj = fromBitStream(obj,bbs)
            blockSize=obj.blockSize;
            k=blockSize^2;
            blockDCT=zeros(blockSize);            
            for i=1:k
                blockDCT(floor((i-1)/blockSize)+1,mod(i-1,blockSize)+1)=bbs(k);
            end
            obj.blockDCT=blockDCT-2048;
        end
        
    end    
end

