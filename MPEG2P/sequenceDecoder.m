 classdef sequenceDecoder < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        iGop;
        iEl;
        fid;
        nGops;
        sizeV;
        sizeH;
        gopParam;
        saveDir;
        
        
        
    end
    
    methods
        function  obj=sequenceDecoder(inputFileName,saveDir)
          
            obj.fid=fopen(inputFileName,'r');
            %fwrite(fid,[gopParam(1) gopParam(2) m n typecast(uint64(z),'uint16')],'uint16');
            gopParam(1)=fread(obj.fid,1,'uint16');
            gopParam(2)=fread(obj.fid,1,'uint16');
            m = fread(obj.fid,1,'uint16');
            n = fread(obj.fid,1,'uint16');
            
            zt= (fread(obj.fid,4,'uint16'))';
            z=typecast(uint16(zt),'uint64');
            
            obj.nGops=z/gopParam(1);
            obj.sizeV=m;
            obj.sizeH=n;
                          
                         
            obj.gopParam=gopParam;
             obj.iGop=1;
             obj.iEl=1;
             
             obj.saveDir=saveDir;
            
             %to be rewised from here
            %% for i=1:obj.nGops
            %%    readNextGop(obj,gopParam);
           %%  end
            
             
                        
        end
        
        function RGB=readNextGop(obj)
            iGop=obj.iGop;
            gopParam=obj.gopParam;
            
            gopNumel=fread(obj.fid,1,'uint64');
            gbs=fread(obj.fid,gopNumel,'uint16');
            gop=gopDecoder(gbs,obj.sizeV,obj.sizeH);
            RGB=zeros(obj.sizeV,obj.sizeH,3,gopParam(1));
            RGB=gop.decodeGOP();
            iGop=iGop+1;
            obj.iGop=iGop;
            
            if(obj.saveDir~='N')
                for k=1:gopParam(1)
                    imwrite(RGB(:,:,:,k),[obj.saveDir '\' num2str((iGop-2)*gopParam(1)+k,'%03u') '.bmp'],'bmp');
                
                end
            end
                
        end
        
        function closeSeq(obj)
            fclose(obj.fid);        
        end
        
        function frames=readAll(obj)
        
            for i=1:obj.nGops
                frames(:,:,:,(i-1)*obj.gopParam(1)+1:i*obj.gopParam(1))=obj.readNextGop();
             end
        
        
        end
        
        
        function readAllToImages(obj)
        
            for i=1:obj.nGops
                obj.readNextGop();
             end
        
        
        end
    
    end

end
