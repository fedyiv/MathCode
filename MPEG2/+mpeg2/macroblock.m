classdef macroblock
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        luma;
        Cb;
        Cr;
        RGB;
        
    end
    
    methods
        function  obj=macroblock(YR,CbG,CrB,space,isIntra)
            if(strcmp(space,'RGB'))
               % obj.RGB=zeros(16,16,3);
               % obj.RGB(:,:,1)=YR;
               % obj.RGB(:,:,2)=CbG;
               % obj.RGB(:,:,3)=CrB;
                
               % chr=vision.ChromaResampler('Resampling','4:4:4 to 4:2:0 (MPEG2)');
                
               % [Cb Cr]=chr.step(C
               
               %not required. Should be processed on the higher level(picture for example)
                
            elseif(strcmp(space,'YCbCr'))
               
                luma(1,1)=mpeg2.block(YR(1:8,1:8),'spatial',isIntra,1);
                luma(1,2)=mpeg2.block(YR(1:8,9:16),'spatial',isIntra,1);
                luma(2,1)=mpeg2.block(YR(9:16,1:8),'spatial',isIntra,1);
                luma(2,2)=mpeg2.block(YR(9:16,9:16),'spatial',isIntra,1);
                
                obj.luma=luma; 
                
                obj.Cb=mpeg2.block(CbG,'spatial',isIntra,1);
                obj.Cr=mpeg2.block(CrB,'spatial',isIntra,1);
            elseif(strcmp(space,'DCT'))
                luma(1,1)=mpeg2.block(YR(1:8,1:8),'dct',isIntra,1);
                luma(1,2)=mpeg2.block(YR(1:8,9:16),'dct',isIntra,1);
                luma(2,1)=mpeg2.block(YR(9:16,1:8),'dct',isIntra,1);
                luma(2,2)=mpeg2.block(YR(9:16,9:16),'dct',isIntra,1);
                
                obj.luma=luma; 
                
                obj.Cb=mpeg2.block(CbG,'dct',isIntra,1);
                obj.Cr=mpeg2.block(CrB,'dct',isIntra,1);
            end
            
        
        end
        
        function Y=getY(obj)
            Y=[obj.luma(1,1).blockBody obj.luma(1,2).blockBody;obj.luma(2,1).blockBody obj.luma(2,2).blockBody];
        end
    end
    
end

