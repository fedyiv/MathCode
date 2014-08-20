classdef blockEncoder < handle
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
        bbs;
        blockBody;
        blockDCT;
        isIntra;% (Y|N)
        quantiser_scale_code;
        
    end
    
    methods
     function obj = blockEncoder(inBlock,isIntra,quantiser_scale_code)
            if( nargin > 0)
                 obj.isIntra=isIntra;
                 obj.quantiser_scale_code=quantiser_scale_code;
                
                    obj.blockBody=inBlock;
                    obj.blockDCT=dct2(inBlock);
                    obj.quantize();
                    obj.toBitStream();
                    
                
            else
                obj.blockBody=zeros(obj.blockSize);
                obj.blockDCT=zeros(obj.blockSize);
            end
        end
        
        function quantize(obj)
            blockDCT=obj.blockDCT;
            quantizationMatrixIntra=obj.quantizationMatrixIntra;
            quantiser_scale=obj.quantiser_scale;
            quant_scale_type=obj.quant_scale_type;
            quantizationMatrixNonIntra=obj.quantizationMatrixNonIntra;
            intra_dc_mult=obj.intra_dc_mult;
            quantiser_scale_code=obj.quantiser_scale_code;
            
            
            if(obj.isIntra=='Y')
                DC=blockDCT(1,1);
                blockDCT=(16*blockDCT./(quantizationMatrixIntra*quantiser_scale(quant_scale_type+1, quantiser_scale_code)));%+sign(blockDCT)/2;
                blockDCT(1,1)=DC/intra_dc_mult;
                
            else
                blockDCT=(16*blockDCT./(quantizationMatrixNonIntra*quantiser_scale(quant_scale_type+1,quantiser_scale_code)));
            end
            blockDCT=round(blockDCT);
            
            
            obj.blockDCT=blockDCT;
   
            
        end
        
        
        
       
        %Two functions below are to be fixed (+2048???), not critical if
        %using uint16
        function  toBitStream(obj)
            blockSize=obj.blockSize;
            k=blockSize^2;
            bbs=uint16(zeros(1,k));
            blockDCT=obj.blockDCT+2048;
            for i=1:k
                bbs(i)=uint16(blockDCT(floor((i-1)/blockSize)+1,mod(i-1,blockSize)+1));
            end
            obj.bbs=bbs;
            %s=obj.bbs;
                        
        end               
    end    
end

