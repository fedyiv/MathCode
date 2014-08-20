classdef macroblockDecoder
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        luma;
        Cb;
        Cr; 
        mbs;
        mv;
        mbType;
        nFx;
        nFy;       
        refDirection;%{-1|0|1} 0 - no prediction, -1 - prediction from previous frame, 1 - prediction from next frame
    end
    
    methods
        function  obj=macroblockDecoder(mbs,nFx,nFy,prevFrameY,nextFrameY)
            if(nargin>0)
            
                obj.nFx=nFx;
                obj.nFy=nFy;
                obj=obj.fromBitStream(mbs,nFx,nFy,prevFrameY,nextFrameY);
                        
            
            end
            
        
        end
        
        function Y=getY(obj)
            Y=[obj.luma(1,1).blockBody obj.luma(1,2).blockBody;obj.luma(2,1).blockBody obj.luma(2,2).blockBody];
        end
        
        function Cb=getCb(obj)
            Cb=obj.Cb.blockBody;
        end
        
        function Cr=getCr(obj)
            Cr=obj.Cr.blockBody;
        end
        
        function obj = fromBitStream(obj,mbs,nFx,nFy,ref1,ref2)
        %   if(obj.mbType=='I')
        %       mbs=[0 obj.luma(1,1).bbs obj.luma(1,2).bbs obj.luma(2,1).bbs obj.luma(2,2).bbs obj.Cb.bbs obj.Cr.bbs];
               %0 means I-mb, then blocks go
        %       obj.mbs=mbs;        
        %   elseif(obj.mbType=='P')
        %   elseif(obj.mbType=='B')
        %   end
           header=mbs(1);
           mbs=mbs(2:numel(mbs));
           
           if(mbs(1)==0)%I-mb
               obj.mbType='I';
               luma(1,1)=blockDecoder(mbs(2:65),'Y',1);
               luma(1,2)=blockDecoder(mbs(66:129),'Y',1);
               luma(2,1)=blockDecoder(mbs(130:193),'Y',1);
               luma(2,2)=blockDecoder(mbs(194:257),'Y',1);
               
               obj.luma=luma;
               
               obj.Cb=blockDecoder(mbs(258:321),'Y',1);
               obj.Cr=blockDecoder(mbs(322:385),'Y',1);
               
           elseif(mbs(1)==1)%P-mb
               obj.mbType='P';
               obj.mv(1)=typecast(uint16(mbs(2)),'int16');
               obj.mv(2)=typecast(uint16(mbs(3)),'int16');
               obj.refDirection=-1;
               
               mbs=mbs(3:numel(mbs));
               
               luma(1,1)=blockDecoder(mbs(2:65),'N',1);
               luma(1,2)=blockDecoder(mbs(66:129),'N',1);
               luma(2,1)=blockDecoder(mbs(130:193),'N',1);
               luma(2,2)=blockDecoder(mbs(194:257),'N',1);
               
               
               obj.luma=luma;
             
               
               obj.Cb=blockDecoder(mbs(258:321),'N',1);
               obj.Cr=blockDecoder(mbs(322:385),'N',1);
               
               
           elseif(mbs(1)==2||mbs(1)==3)%B-mb
               obj.mbType='B';
               if(mbs(1)==2)
                   obj.refDirection=-1;
               elseif(mbs(1)==3)
                   obj.refDirection=1;
               end
                   
               obj.mv(1)=typecast(uint16(mbs(2)),'int16');
               obj.mv(2)=typecast(uint16(mbs(3)),'int16');
               mbs=mbs(3:numel(mbs));
               
               luma(1,1)=blockDecoder(mbs(2:65),'N',1);
               luma(1,2)=blockDecoder(mbs(66:129),'N',1);
               luma(2,1)=blockDecoder(mbs(130:193),'N',1);
               luma(2,2)=blockDecoder(mbs(194:257),'N',1);
               
               
               obj.luma=luma;
             
               
               obj.Cb=blockDecoder(mbs(258:321),'N',1);
               obj.Cr=blockDecoder(mbs(322:385),'N',1);
               
           end
           
        end
        
        function obj=motionCompensation(obj,ref,ref2)
            if(obj.refDirection==-1)
                refMB=ref((obj.nFy-1)*16+obj.mv(2)+1:obj.nFy*16+obj.mv(2),(obj.nFx-1)*16+obj.mv(1)+1:obj.nFx*16+obj.mv(1));
            elseif(obj.refDirection==1)
                refMB=ref2((obj.nFy-1)*16+obj.mv(2)+1:obj.nFy*16+obj.mv(2),(obj.nFx-1)*16+obj.mv(1)+1:obj.nFx*16+obj.mv(1));
            end
            
            obj.luma(1,1)=obj.luma(1,1).blockCompensation(refMB(1:8,1:8));
            obj.luma(1,2)=obj.luma(1,2).blockCompensation(refMB(1:8,9:16));
            obj.luma(2,1)=obj.luma(2,1).blockCompensation(refMB(9:16,1:8));
            obj.luma(2,2)=obj.luma(2,2).blockCompensation(refMB(9:16,9:16));
            
            
        end
        
        %function obj=doCompensate(obj,nFx,nFy,ref1)
         %     obj=obj.motionCompensation(obj.luma,nFx,nFy,ref1);
        %end
    end
    
end

