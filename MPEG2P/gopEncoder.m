classdef gopEncoder
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        gopParam;
        gopStructure;
        gopReorder;
        gopBody;
        gbs;
        isPMO;        
    end
    
    methods
        function  obj=gopEncoder(gopParam,frames,isPMO)
            
            [m n q z]=size(frames);
             if(q~=3||z~=gopParam(1))
                 if(gopParam(1)~=1)
                    error('frame: Incorrect dimension of input gop.');
                 end
             end            
            
             obj.isPMO=isPMO;
            obj.gopParam=gopParam;                        
            obj=generateGopSructure(obj,gopParam);
            
          
            
             for i=obj.gopReorder
                if(obj.gopStructure(i)=='I')
                    gopBody(i)=frameEncoder(frames(:,:,:,i),'I',-1,-1,obj.isPMO);
                elseif(obj.gopStructure(i)=='P')
                    gopBody(i)=frameEncoder(frames(:,:,:,i),'P',gopBody(obj.previousIP(i)).getY(),-1,obj.isPMO);
                elseif(obj.gopStructure(i)=='B')
                    gopBody(i)=frameEncoder(frames(:,:,:,i),'B',gopBody(obj.previousIP(i)).getY(),gopBody(obj.nextIP(i)).getY(),obj.isPMO);
                end
             end        
            
             
             
            
            obj.gopBody=gopBody;
                        
            obj=obj.toBitStream();                   
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
        
                
        function obj = toBitStream(obj)
            gbs(1)=184; % GOP start code
            gbs(2)=obj.gopParam(1);            
            gbs(3)=obj.gopParam(2);
            
            for i=1:obj.gopParam(1)
                gbs=horzcat(gbs,obj.gopBody(i).fbs);
            end
            obj.gbs=gbs;
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

