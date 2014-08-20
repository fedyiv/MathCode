classdef macroblockEncoder
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        luma;
        Cb;
        Cr; 
        mbs;
        mv;
        mbType;
        Y;
        refDirection;%{-1|0|1} 0 - no prediction, -1 - prediction from previous frame, 1 - prediction from next frame
    end
    
    methods
        function  obj=macroblockEncoder(Y,Cb,Cr,isIntra,nFx,nFy,prevFrameY,nextFrameY)
            if(nargin>0)
                obj.Y=Y;
            
            if(isIntra=='Y')
                obj.mbType='I';
                                      
                luma(1,1)=blockEncoder(Y(1:8,1:8),isIntra,1);
                luma(1,2)=blockEncoder(Y(1:8,9:16),isIntra,1);
                luma(2,1)=blockEncoder(Y(9:16,1:8),isIntra,1);
                luma(2,2)=blockEncoder(Y(9:16,9:16),isIntra,1);
                
                obj.luma=luma; 
                
                obj.Cb=blockEncoder(Cb,isIntra,1);
                obj.Cr=blockEncoder(Cr,isIntra,1); 
                
            elseif(isIntra=='P')
                obj.mbType='P';
                
                obj.Cb=blockEncoder(Cb,'N',1);
                obj.Cr=blockEncoder(Cr,'N',1); 
                
                obj=obj.motionEstimation(Y,nFx,nFy,prevFrameY,nextFrameY);
                obj=obj.motionCompensation(Y,nFx,nFy,prevFrameY);
                
            elseif(isIntra=='B')
                obj.mbType='B';
                obj.Cb=blockEncoder(Cb,'N',1);
                obj.Cr=blockEncoder(Cr,'N',1); 
            
                obj=obj.motionEstimation(Y,nFx,nFy,prevFrameY,nextFrameY);
                if(refDirection==-1)
                    obj=obj.motionCompensation(Y,nFx,nFy,prevFrameY);
                else
                    obj=obj.motionCompensation(Y,nFx,nFy,nextFrameY);
                end
            end
                
            obj=obj.toBitStream();
            end
            
        
        end
        
        function Y=getY(obj)
            %The error is here - this is correct only for I frames
          %  Y=[obj.luma(1,1).blockBody obj.luma(1,2).blockBody;obj.luma(2,1).blockBody obj.luma(2,2).blockBody];
          Y=obj.Y;
        end
        
        
        function obj = motionEstimation(obj,Y,nFx,nFy,prevFrameY,nextFrameY)
            if(obj.mbType=='P')
                [obj.mv min_mae]=obj.motionEstimationMB(Y,nFx,nFy,prevFrameY);                
            elseif(obj.mbType=='B')
                [mvPrev min_maePrev]=obj.motionEstimationMB(Y,nFx,nFy,prevFrameY);                
                [mvNext min_maeNext]=obj.motionEstimationMB(Y,nFx,nFy,prevFrameY);   
                
                if(min_maePrev<min_maeNext)
                    obj.mv=mvPrev;
                    refDirection=-1;
                else
                    obj.mv=mvNext;
                    refDirection=1;
                end
            
            end
        end
        
        function obj=motionCompensation(obj,Y,nFx,nFy,ReferenceFrame)
          %rewrite this part becouse found an error in motion estimation,
          %probably only in indexing
            D=double(Y)-double(ReferenceFrame((nFy-1)*16+obj.mv(2)+1:nFy*16+obj.mv(2),(nFx-1)*16+obj.mv(1)+1:nFx*16+obj.mv(1)));
            
             luma(1,1)=blockEncoder(D(1:8,1:8),'N',1);
             luma(1,2)=blockEncoder(D(1:8,9:16),'N',1);
             luma(2,1)=blockEncoder(D(9:16,1:8),'N',1);
             luma(2,2)=blockEncoder(D(9:16,9:16),'N',1);
             
             obj.luma=luma; 
             
            
            
        end        
        
        function [ mv,min ] = motionEstimationMB(obj,Y,nFx,nFy,ReferenceFrame)
        
            mbSize=16;
            [sizeV,sizeH] = size(ReferenceFrame);
            mv=zeros(1,2);
            min=obj.mae(Y,ReferenceFrame((nFy-1)*mbSize+1:nFy*mbSize,(nFx-1)*mbSize+1:nFx*mbSize));
            
            window=12;
            startX=(nFx-1)*16+1-window/3; if(startX<=0) startX=1; end;
            startY=(nFy-1)*16+1-window/3; if(startY<=0) startY=1; end;
            endX=nFx*16+window/3; if(endX>sizeH-15) endX=sizeH-16+1; end;
            endY=nFy*16+window/3; if(endY>sizeV-15) endY=sizeV-16+1; end;           
                
            
            
            for i=startX:endX
                for j=startY:endY
                    
                    test=obj.mae(Y,ReferenceFrame(j:(j-1)+mbSize,i:(i-1)+mbSize));
                    if( test < min)
                        min=test;
                        mv(1)=i-((nFx-1)*mbSize+1);
                        mv(2)=j-((nFy-1)*mbSize+1);
                    end
                end
            end            
        end
        
        
        function err = mae(obj,mb1,mb2)    
            err=sum(reshape(abs(double(mb1)-double(mb2)),[],1))/numel(mb1);
        end
        
        
        
        
        
        function obj = toBitStream(obj)
           if(obj.mbType=='I')
               mbs=[0 obj.luma(1,1).bbs obj.luma(1,2).bbs obj.luma(2,1).bbs obj.luma(2,2).bbs obj.Cb.bbs obj.Cr.bbs];
               %0 means I-mb, then blocks go
               
           elseif(obj.mbType=='P')
               mbs=[1 typecast(int16(obj.mv(1)),'uint16') typecast(int16(obj.mv(2)),'uint16') obj.luma(1,1).bbs obj.luma(1,2).bbs obj.luma(2,1).bbs obj.luma(2,2).bbs obj.Cb.bbs obj.Cr.bbs];
               %1 means P-mb, then motion vector and blocks go
             
           elseif(obj.mbType=='B')
               if(refDirection==-1)
                   mbs=[2 typecast(int16(obj.mv(1)),'uint16') typecast(int16(obj.mv(2)),'uint16') obj.luma(1,1).bbs obj.luma(1,2).bbs obj.luma(2,1).bbs obj.luma(2,2).bbs obj.Cb.bbs obj.Cr.bbs];
                   %2 means B-mb(forward prediction), then motion vector and blocks go
               else
                   mbs=[3 typecast(int16(obj.mv(1)),'uint16') typecast(int16(obj.mv(2)),'uint16') obj.luma(1,1).bbs obj.luma(1,2).bbs obj.luma(2,1).bbs obj.luma(2,2).bbs obj.Cb.bbs obj.Cr.bbs];
                   %3 means B-mb(backward prediction), then motion vector and blocks go
               end
           end
           header=numel(mbs);
           mbs=horzcat(header,mbs);
           obj.mbs=mbs;        
           
        end
    end
    
end

