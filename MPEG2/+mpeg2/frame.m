classdef frame 
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = public, GetAccess = public)
        sizeH;
        sizeV;
        frameBody;
        frameType; %(I,P,B)
    end
    
    methods
        function obj=frame(frameBody,frameType,referenceFrameBodyF,referenceFrameBodyB,action)
            
            if(strcmp(action,'encode'))
                [m n q]=size(frameBody);
                if(q~=3 || mod(m,16)~=0 || mod(n,16)~=0 )
                    error('frame: Incorrect dimension of input image. Must be 16nx16mx3');
                end
            
            
                obj.sizeH=n;
                obj.sizeV=m;
                obj.frameType=frameType;
            
            
                if(frameType=='I')
                    obj=obj.encodeI(frameBody);                
                elseif(frameType=='P')
                    obj=obj.encodeP(frameBody,referenceFrameBodyF);                
                elseif(frameType=='B')
                    obj=obj.encodeB(frameBody,referenceFrameBodyF,referenceFrameBodyB);                                
                end           
            elseif(strcmp(action,'decode'))
            end
        end
        
        function obj = encodeI(obj,RGB)
           mbH=obj.sizeH/16;
           mbV=obj.sizeV/16;
           
           YCbCr=rgb2ycbcr(RGB);
           Y=YCbCr(:,:,1);
           Cb=YCbCr(:,:,2);
           Cr=YCbCr(:,:,3);
           
           cnv=vision.ChromaResampler('Resampling','4:4:4 to 4:2:0 (MPEG2)');
           [Cb Cr]=cnv.step(Cb,Cr);
           
           for i=1:mbH
               for j=1:mbV
                    frameBody(i,j)=mpeg2.macroblock(Y((i-1)*16+1:i*16,(j-1)*16+1:j*16),Cb((i-1)*8+1:i*8,(j-1)*8+1:j*8),Cr((i-1)*8+1:i*8,(j-1)*8+1:j*8),'YCbCr','Y');
               end
           end
           obj.frameBody=frameBody;
        end                              
        
        function obj = encodeP(obj,RGB,ref1)
           mbH=obj.sizeH/16;
           mbV=obj.sizeV/16;
           
           YCbCr=rgb2ycbcr(RGB);
           Y=YCbCr(:,:,1);
           Cb=YCbCr(:,:,2);
           Cr=YCbCr(:,:,3);
           
           cnv=vision.ChromaResampler('Resampling','4:4:4 to 4:2:0 (MPEG2)');
           [Cb Cr]=cnv.step(Cb,Cr);
           
           for i=1:mbH
               for j=1:mbV
           %         frameBody(i,j)=mpeg2.macroblock(Y((i-1)*16+1:i*16,(j-1)*16+1:j*16),Cb((i-1)*8+1:i*8,(j-1)*8+1:j*8),Cr((i-1)*8+1:i*8,(j-1)*8+1:j*8),'YCbCr','Y');
               end
           end
           obj.frameBody=frameBody;
        end                              
        
        function obj = encodeB(obj,RGB,ref1,ref2)
           mbH=obj.sizeH/16;
           mbV=obj.sizeV/16;
           
           YCbCr=rgb2ycbcr(RGB);
           Y=YCbCr(:,:,1);
           Cb=YCbCr(:,:,2);
           Cr=YCbCr(:,:,3);
           
           cnv=vision.ChromaResampler('Resampling','4:4:4 to 4:2:0 (MPEG2)');
           [Cb Cr]=cnv.step(Cb,Cr);
           
           for i=1:mbH
               for j=1:mbV
           %         frameBody(i,j)=mpeg2.macroblock(Y((i-1)*16+1:i*16,(j-1)*16+1:j*16),Cb((i-1)*8+1:i*8,(j-1)*8+1:j*8),Cr((i-1)*8+1:i*8,(j-1)*8+1:j*8),'YCbCr','Y');
               end
           end
           obj.frameBody=frameBody;
        end      
        
        function obj=decodeI(obj,dY,dCb,dCr)
               mbH=obj.sizeH/16;
           mbV=obj.sizeV/16;
           
           YCbCr=rgb2ycbcr(RGB);
           Y=YCbCr(:,:,1);
           Cb=YCbCr(:,:,2);
           Cr=YCbCr(:,:,3);
           
           cnv=vision.ChromaResampler('Resampling','4:4:4 to 4:2:0 (MPEG2)');
           [Cb Cr]=cnv.step(Cb,Cr);
           
           for i=1:mbH
               for j=1:mbV
                    frameBody(i,j)=mpeg2.macroblock(Y((i-1)*16+1:i*16,(j-1)*16+1:j*16),Cb((i-1)*8+1:i*8,(j-1)*8+1:j*8),Cr((i-1)*8+1:i*8,(j-1)*8+1:j*8),'YCbCr','Y');
               end
           end
           obj.frameBody=frameBody;                    
        end
        
    end
    
end

