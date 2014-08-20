classdef sequenceEncoder
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        iGop;
        fid;
        nGops;
        outputFileName;
        gopParam;
    end
    
    methods
        function  obj=sequenceEncoder(inputSequence,outputFileName,gopParam)
          
             [m n q z]=size(inputSequence);
             if(q~=3||mod(z,gopParam(1)))
                 if(gopParam(1)~=1)
                    error('frame: Incorrect dimension of input gop.');
                 end
             end           
            
             obj.nGops=z/gopParam(1);
             obj.gopParam=gopParam;
                          
             obj.outputFileName=outputFileName;
                         
             obj.iGop=1;
             obj.fid=fopen(outputFileName,'w');
             
             fwrite(obj.fid,[gopParam(1) gopParam(2) m n typecast(uint64(z),'uint16')],'uint16');
             
             for i=1:obj.nGops
                obj=obj.saveNextGop(gopParam,inputSequence);
             end
            
             fclose(obj.fid);            
                        
        end
        
        function obj = saveNextGop(obj,gopParam,inputSequence)
            iGop=obj.iGop;
            
            gop=gopEncoder(gopParam,inputSequence(:,:,:,(iGop-1)*gopParam(1)+1:iGop*gopParam(1)));
            fwrite(obj.fid,numel(gop.gbs),'uint64');
            fwrite(obj.fid,gop.gbs,'uint16');
            
            obj.iGop=obj.iGop+1;
        end
        
        function obj=addGop(obj,inputSequence)
            obj.fid=fopen(obj.outputFileName,'r+');
            fseek(obj.fid,0,'eof');
            
            gop=gopEncoder(obj.gopParam,inputSequence);
            fwrite(obj.fid,numel(gop.gbs),'uint64');
            fwrite(obj.fid,gop.gbs,'uint16');
            
            fseek(obj.fid,8,'bof');
            
            zt= (fread(obj.fid,4,'uint16'))';
            z=typecast(uint16(zt),'uint64');
            z=z+1;
            fseek(obj.fid,8,'bof');
            
            fwrite(obj.fid,typecast(uint64(z),'uint16'),'uint16');
        
        
            fclose(obj.fid);
        end
    
    end

end
