classdef StoreArray < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        D;
    end
    
    methods
        function obj = StoreArray(D)
            obj.D=D;
        end
        
        function obj= setD(obj,D)
            objD=D;
        end       
        
    end
    
end

