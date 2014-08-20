classdef iFrame < mpeg2.frame
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj=iFrame(frameBody)
         obj=obj@mpeg2.frame(frameBody);
         obj.frameType='I';
                  
        end
    end
    
end

