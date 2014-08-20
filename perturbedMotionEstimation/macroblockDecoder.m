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
    end
    
    methods
        function  obj=macroblockDecoder(mbs,prevFrameI,nextFrameY)
            if(nargin>0)
            
            obj=obj.fromBitStream(mbs);
                
                
                %if(isIntra=='Y')
            %    obj.mbType='I';
                                      
            %    luma(1,1)=blockEncoder(Y(1:8,1:8),isIntra,1);
            %    luma(1,2)=blockEncoder(Y(1:8,9:16),isIntra,1);
            %    luma(2,1)=blockEncoder(Y(9:16,1:8),isIntra,1);
            %    luma(2,2)=blockEncoder(Y(9:16,9:16),isIntra,1);
                
            %    obj.luma=luma; 
                
            %    obj.Cb=blockEncoder(Cb,isIntra,1);
            %    obj.Cr=blockEncoder(Cr,isIntra,1); 
                
           % elseif(isIntra=='P')
           % elseif(isIntra=='B')
           % end
                
            
            end
            
        
        end
        
        function Y=getY(obj)
            Y=[obj.luma(1,1).blockBody obj.luma(1,2).blockBody;obj.luma(2,1).blockBody obj.luma(2,2).blockBody];
        end
        
        function Cb=getCb(obj)
            Cb=Cb.blockBody;
        end
        
        function Cr=getCr(obj)
            Cr=Cr.blockBody;
        end
        
        function obj = fromBitStream(obj,mbs)
        %   if(obj.mbType=='I')
        %       mbs=[0 obj.luma(1,1).bbs obj.luma(1,2).bbs obj.luma(2,1).bbs obj.luma(2,2).bbs obj.Cb.bbs obj.Cr.bbs];
               %0 means I-mb, then blocks go
        %       obj.mbs=mbs;        
        %   elseif(obj.mbType=='P')
        %   elseif(obj.mbType=='B')
        %   end
           header=mbs(1);
           mbs=mbs(2,numel(mbs));
           
           if(mbs(1)==0)%I-mb
               luma(1,1)=blockDecoder(mbs(2:65),'Y',1);
               luma(1,2)=blockDecoder(mbs(66:129),'Y',1);
               luma(2,1)=blockDecoder(mbs(130:193),'Y',1);
               luma(2,2)=blockDecoder(mbs(194:257),'Y',1);
               
               obj.luma=luma;
               
               obj.Cb=blockDecoder(mbs(258:321),'Y',1);
               obj.Cr=blockDecoder(mbs(322:385),'Y',1);
               
           elseif(1)
           elseif(1)
           end
           
        end
    end
    
end

