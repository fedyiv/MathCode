classdef speedTest
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        z;
        i;
    end
    
    methods
        function obj = speedTest(nTimes)
            tic;
            obj.z=0;
            %z=obj.z;
            
            for i=1:nTimes
                obj.z(i)=i+1;
            end
            %obj.z=z;
            disp(toc);            
        end
    end
    
end

