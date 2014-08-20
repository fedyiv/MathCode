classdef gopDecoder
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        gopParam;
        gopStructure;
        gopBody;
        gbs;
        gopReorder;
        sizeV;
        sizeH;
    end
    
    methods
        function  obj=gopDecoder(gbs,sizeV,sizeH)
            
            obj.sizeV=sizeV;
            obj.sizeH=sizeH;
            
            obj=obj.fromBitStream(gbs);   
                                 
            
           
            obj=generateGopSructure(obj,obj.gopParam);
            
        end
        
        function RGB = decodeGOP(obj)
            
            RGB=uint8(zeros(obj.sizeV,obj.sizeH,3,obj.gopParam(1)));
            
            for i=obj.gopReorder
                if(obj.gopStructure(i)=='I')
                    RGB(:,:,:,i)=obj.gopBody(i).decodeI();
                    disp('I-frame decoded');
                elseif(obj.gopStructure(i)=='P')
                    RGB(:,:,:,i)=obj.gopBody(i).decodeP(obj.gopBody(obj.previousIP(i)).getY());
                    disp('P-frame decoded');
                elseif(obj.gopStructure(i)=='B')
                    RGB(:,:,:,i)=obj.gopBody(i).decodeB(obj.gopBody(obj.previousIP(i)).getY(),obj.gopBody(obj.nextIP(i)).getY());                    
                    disp('B-frame decoded');
                end
            end                
        end
        
         function obj = generateGopSructure(obj,gopParam)
            gopStructure(1)='I';            
            bCount=0;
            for i=2:gopParam(1)
                if(bCount< gopParam(2))
                    gopStructure(i)='B';
                    bCount=bCount+1;
                else
                    gopStructure(i)='P';
                    bCount=0;
                end                            
            end
            if(gopStructure(gopParam(1))=='B')
                error('gopEncoder: incorrect gop params');
            end
            
            gopReorder(1)=1;
            n=1;
            nr=2;
            for i=1:(gopParam(1)-1)/(gopParam(2)+1)
                while(gopStructure(n)~='P')
                    n=n+1;
                end
                
                gopReorder(nr)=n;
                nr=nr+1;
                
                for j=1:gopParam(2)
                    gopReorder(nr)=n-gopParam(2)+j-1;
                    nr=nr+1;
                end
                
                 n=n+1;                           
            end
            
            obj.gopStructure=gopStructure;
            obj.gopReorder=gopReorder;
            
        end
        
                
 
        
        function obj = fromBitStream(obj,gbs)
            
            if(gbs(1)~=184)
                error('gopDecoder: incorrect  GOP start code')
            end
            gopParam(1)=gbs(2);
            gopParam(2)=gbs(3);
            obj.gopParam=gopParam;
            obj=generateGopSructure(obj,gopParam);
            
            
            
            n=uint32(4);
            for i=1:obj.gopParam(1)
                header=typecast(uint16(gbs(n:n+1)),'uint32');
                gopBody(i)=frameDecoder(gbs(n:n+header+1),obj.sizeV,obj.sizeH,-1,-1);%to -1,-1 to be replaced!!!!!
                n=n+header+2;               
            end
            obj.gopBody=gopBody;
            
        end
        
        
        
        function prev = previousIP(obj,current)
            i=current-1;
            while(obj.gopStructure(i)=='B')
                i=i-1;
            end            
            prev=i;
        end
        
        function next = nextIP(obj,current)
            i=current+1;
            while(obj.gopStructure(i)=='B')
                i=i+1;
            end            
            next=i;
        end
        
    end
    
end

