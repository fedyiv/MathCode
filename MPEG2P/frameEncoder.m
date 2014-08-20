classdef frameEncoder
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = public, GetAccess = public)
        sizeH;
        sizeV;
        frameBody;
        frameType; %(I,P,B)
        fbs;
        PMO;
    end
    
    methods
        function obj=frameEncoder(frameBody,frameType,referenceFrameBodyF,referenceFrameBodyB,PMO)
            
                if(nargin>0)
                    obj.PMO=PMO;
            
                [m n q]=size(frameBody);
                if(q~=3 || mod(m,16)~=0 || mod(n,16)~=0 )
                    error('frame: Incorrect dimension of input image. Must be 16nx16mx3');
                end
            
                tic;
            
                obj.sizeH=n;
                obj.sizeV=m;
                obj.frameType=frameType;
            
            
                if(frameType=='I')
                    obj=encodeI(obj,frameBody);  
                    disp(['I-frame encoded. Time ellapsed: ' num2str(toc)]);
                elseif(frameType=='P')
                    obj=encodeP(obj,frameBody,referenceFrameBodyF);                
                    disp(['P-frame encoded. Time ellapsed: ' num2str(toc)]);
                elseif(frameType=='B')
                   
                    obj=encodeB(obj,frameBody,referenceFrameBodyF,referenceFrameBodyB);                                
                    disp(['B-frame encoded. Time ellapsed: ' num2str(toc)]);
                end       
                
                obj=obj.toBitStream();
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
           
           for i=1:mbV
               for j=1:mbH
                    frameBody(i,j)=macroblockEncoder(Y((i-1)*16+1:i*16,(j-1)*16+1:j*16),Cb((i-1)*8+1:i*8,(j-1)*8+1:j*8),Cr((i-1)*8+1:i*8,(j-1)*8+1:j*8),'Y',-1,-1,-1,-1,obj.PMO);
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
           
           for i=1:mbV
               for j=1:mbH
                    frameBody(i,j)=macroblockEncoder(Y((i-1)*16+1:i*16,(j-1)*16+1:j*16),Cb((i-1)*8+1:i*8,(j-1)*8+1:j*8),Cr((i-1)*8+1:i*8,(j-1)*8+1:j*8),'P',j,i,ref1,-1,obj.PMO);
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
           
           for i=1:mbV
               for j=1:mbH
                    frameBody(i,j)=macroblockEncoder(Y((i-1)*16+1:i*16,(j-1)*16+1:j*16),Cb((i-1)*8+1:i*8,(j-1)*8+1:j*8),Cr((i-1)*8+1:i*8,(j-1)*8+1:j*8),'P',j,i,ref1,ref2,obj.PMO);
               end
           end
           obj.frameBody=frameBody;
        end   
        
        
        function obj=toBitStream(obj)
            
            mbH=obj.sizeH/16;
            mbV=obj.sizeV/16;
            frameBody=obj.frameBody;
            
            
            
            if(obj.frameType=='I')
                fbs(1)=0;
                for i=1:mbV
                    for j=1:mbH
                        fbs=horzcat(fbs,frameBody(i,j).mbs);
                    end
                end
            elseif(obj.frameType=='P')
                 fbs(1)=1;
                for i=1:mbV
                    for j=1:mbH
                        fbs=horzcat(fbs,frameBody(i,j).mbs);
                    end
                end
            elseif(obj.frameType=='B')
                  fbs(1)=2;
                for i=1:mbV
                    for j=1:mbH
                        fbs=horzcat(fbs,frameBody(i,j).mbs);
                    end
                end
            end
            
            header=typecast(uint32(numel(fbs)),'uint16');
            
            
            obj.fbs=horzcat(header,fbs);
            
        end
        
        function Y = getY(obj)
            mbH=obj.sizeH/16;           
            mbV=obj.sizeV/16;
            frameBody=obj.frameBody;
            
            for i=1:mbV
                for j=1:mbH
                    Y((i-1)*16+1:i*16,(j-1)*16+1:j*16)=uint8(frameBody(i,j).getY());                    
                end
            end
        end       
        
    end
    
end

