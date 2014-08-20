classdef PMO < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        isPMO;
        maeOriginal;
        maePMO;
        adjustmentAmount;
        stepsAmount;
        
    end
    
    methods
        function obj = PMO(isPMO)
            obj.isPMO=isPMO;
            maeOriginal=[];
            maePMO=[];
            adjustmentAmount=[];
            stepsAmount=[];
        
        end
        
        function addMaePair(obj,mae1,mae2)
            obj.maeOriginal(numel(obj.maeOriginal)+1)=mae1;
            obj.maePMO(numel(obj.maePMO)+1)=mae2;        
        end
        
        function adjustedMB = adjustMB(obj,curMB,refMB1,refMB2)
            
            [m n]=size(curMB);
            cmb=curMB;
            step=1;
            mae1=obj.mae(curMB,refMB1);
            mae2=obj.mae(curMB,refMB2);
            k=1;
            while(mae1 <=mae2 && k < 50)
                for i=1:m
                    for j=1:n                        
                        if(refMB1(i,j)~=refMB2(i,j))
                            if(cmb(i,j) >= refMB1(i,j) && cmb(i,j) <= refMB2(i,j))
                                cmb(i,j)=cmb(i,j)+step;
                            elseif(curMB(i,j) <= refMB1(i,j) && curMB(i,j) >= refMB2(i,j))
                                cmb(i,j)=cmb(i,j)-step;
                            end
                            
                         %   mae1=obj.mae(cmb,refMB1);
                          %  mae2=obj.mae(cmb,refMB2);
                            
                        end
                    end
                end
                mae1=obj.mae(cmb,refMB1);
                mae2=obj.mae(cmb,refMB2);
                k=k+1;
                
                
            end
            
            obj.adjustmentAmount(numel(obj.adjustmentAmount)+1)=obj.mae(cmb,curMB);
            adjustedMB=cmb;
            obj.stepsAmount(numel(obj.stepsAmount)+1)=k;
            
            
        end
        
        
        function err = mae(obj,mb1,mb2)    
            err=sum(reshape(abs(double(mb1)-double(mb2)),[],1))/numel(mb1);
        end
        
    end
    
end

