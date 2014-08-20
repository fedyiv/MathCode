classdef frameDecoder
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = public, GetAccess = public)
        sizeH;
        sizeV;
        frameBody;
        frameType; %(I,P,B)
        fbs;
    end
    
    methods
        function obj=frameDecoder(fbs,sizeV,sizeH,referenceFrameBodyF,referenceFrameBodyB)
         
            obj.sizeH=sizeH;            
            obj.sizeV=sizeV;
                
            
            obj=obj.fromBitStream(fbs,referenceFrameBodyF,referenceFrameBodyB);    
                            
            
                %if(frameType=='I')
                %    obj=encodeI(obj,frameBody);                
                %elseif(frameType=='P')
                %    obj=encodeP(obj,frameBody,referenceFrameBodyF);                
                %elseif(frameType=='B')
                %    obj=encodeB(obj,frameBody,referenceFrameBodyF,referenceFrameBodyB);                                
                %end       
                
               
        end
        
       % function obj = encodeI(obj,RGB)
       %    mbH=obj.sizeH/16;
       %    mbV=obj.sizeV/16;
           
        %   YCbCr=rgb2ycbcr(RGB);
        %   Y=YCbCr(:,:,1);
        %   Cb=YCbCr(:,:,2);
        %   Cr=YCbCr(:,:,3);
           
       %    cnv=vision.ChromaResampler('Resampling','4:4:4 to 4:2:0 (MPEG2)');
       %    [Cb Cr]=cnv.step(Cb,Cr);
           
      %     for i=1:mbV
       %        for j=1:mbH
                     
       %             frameBody(i,j)=macroblockEncoder(Y((i-1)*16+1:i*16,(j-1)*16+1:j*16),Cb((i-1)*8+1:i*8,(j-1)*8+1:j*8),Cr((i-1)*8+1:i*8,(j-1)*8+1:j*8),'Y',-1,-1,-1,-1);
       %        end
       %    end
       %    obj.frameBody=frameBody;
       % end                              
        
         
       function RGB = decodeI(obj)
                  
            mbH=obj.sizeH/16;           
            mbV=obj.sizeV/16;
            
            for i=1:mbV
                for j=1:mbH
                    Y((i-1)*16+1:i*16,(j-1)*16+1:j*16)=uint8(obj.frameBody(i,j).getY());
                    Cb((i-1)*8+1:i*8,(j-1)*8+1:j*8)=uint8(obj.frameBody(i,j).getCb());
                    Cr((i-1)*8+1:i*8,(j-1)*8+1:j*8)=uint8(obj.frameBody(i,j).getCr());
                end
            end
        
            cnv=vision.ChromaResampler('Resampling','4:2:0 (MPEG2) to 4:4:4');
           [Cb Cr]=cnv.step(Cb,Cr);
           YCbCr(:,:,1)=Y;
           YCbCr(:,:,2)=Cb;
           YCbCr(:,:,3)=Cr;
           
           RGB=ycbcr2rgb(YCbCr);   
            
       end
       
       
       function RGB = decodeP(obj,ref)
           mbH=obj.sizeH/16;           
           mbV=obj.sizeV/16;
           for i=1:mbV
               for j=1:mbH
                   obj.frameBody(i,j)=obj.frameBody(i,j).motionCompensation(ref,-1);
                   Y((i-1)*16+1:i*16,(j-1)*16+1:j*16)=uint8(obj.frameBody(i,j).getY());
                   Cb((i-1)*8+1:i*8,(j-1)*8+1:j*8)=uint8(obj.frameBody(i,j).getCb());
                   Cr((i-1)*8+1:i*8,(j-1)*8+1:j*8)=uint8(obj.frameBody(i,j).getCr());
               end
           end
           cnv=vision.ChromaResampler('Resampling','4:2:0 (MPEG2) to 4:4:4');
           [Cb Cr]=cnv.step(Cb,Cr);
           YCbCr(:,:,1)=Y;
           YCbCr(:,:,2)=Cb;
           YCbCr(:,:,3)=Cr;               
           RGB=ycbcr2rgb(YCbCr);
       end
       
       function RGB = decodeB(obj,ref,ref2)
           mbH=obj.sizeH/16;           
           mbV=obj.sizeV/16;
           for i=1:mbV
               for j=1:mbH
                   obj.frameBody(i,j)=obj.frameBody(i,j).motionCompensation(ref,ref2);
                   Y((i-1)*16+1:i*16,(j-1)*16+1:j*16)=uint8(obj.frameBody(i,j).getY());
                   Cb((i-1)*8+1:i*8,(j-1)*8+1:j*8)=uint8(obj.frameBody(i,j).getCb());
                   Cr((i-1)*8+1:i*8,(j-1)*8+1:j*8)=uint8(obj.frameBody(i,j).getCr());
               end
           end
           cnv=vision.ChromaResampler('Resampling','4:2:0 (MPEG2) to 4:4:4');
           [Cb Cr]=cnv.step(Cb,Cr);
           YCbCr(:,:,1)=Y;
           YCbCr(:,:,2)=Cb;
           YCbCr(:,:,3)=Cr;               
           RGB=ycbcr2rgb(YCbCr);
       end
       
       
       
       function Y = getY(obj)
           mbH=obj.sizeH/16;           
           mbV=obj.sizeV/16;
           for i=1:mbV
               for j=1:mbH
                   Y((i-1)*16+1:i*16,(j-1)*16+1:j*16)=uint8(obj.frameBody(i,j).getY());                 
               end
           end
       end
           
        function obj=fromBitStream(obj,fbs,ref1,ref2)
            
            mbH=obj.sizeH/16;
            mbV=obj.sizeV/16;            
            
            %if(obj.frameType=='I')
             %   fbs(1)=0;
              %  for i=1:mbV
              %      for j=1:mbH
               %         fbs=horzcat(fbs,obj.frameBody(i,j).mbs);
               %     end
               % end
           % elseif(obj.frameType=='P')
           % elseif(obj.frameType=='B')
           % end
            header=uint16(fbs(1:2));
            headerNum=typecast(header,'uint32');
            
            fbs=fbs(3:numel(fbs));
           
           if(fbs(1)==0) % I-frame
               obj.frameType='I';
               imb=1;
               i=2;
          
               n=uint32(2);
               for i=1:mbV
                   for j=1:mbH
                       header=uint32(fbs(n));
                       frameBody(i,j)=macroblockDecoder(fbs(n:n+header),i,j,-1,-1);
                       n=n+header+1;
                   end
               end             
           
           elseif(fbs(1)==1)% P - frame
               obj.frameType='P';
               imb=1;
               i=2;
          
               n=uint32(2);
               for i=1:mbV
                   for j=1:mbH
                       header=uint32(fbs(n));
                       frameBody(i,j)=macroblockDecoder(fbs(n:n+header),j,i,ref1,-1);
                       n=n+header+1;
                   end
               end
               
            elseif(fbs(1)==2)% B - frame
               obj.frameType='B';
               imb=1;
               i=2;
          
               n=uint32(2);
               for i=1:mbV
                   for j=1:mbH
                       header=uint32(fbs(n));
                       frameBody(i,j)=macroblockDecoder(fbs(n:n+header),j,i,ref1,ref2);
                       n=n+header+1;
                   end
               end
           end
                     
           obj.frameBody=frameBody;         
            
        end
    end
    
end

