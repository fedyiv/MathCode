function [ isok ] = STC_validateTransitionMatrix( transitionMatrix )
%transitionMatrix valid if following conditions hold
%1)From each state there are at least two paths - one for 0 and one for 1
%2)At least one path is entering each state

states=unique(transitionMatrix(:,1));
newStates=unique(transitionMatrix(:,4));

nextStates=transitionMatrix(:,4);
prevStates=transitionMatrix(:,4);
isok=0;
%check that there are two paths from each state - for 0 and 1
for state=states'     
    prevStateIndexes=find(prevStates==state);
    partialTrellis=transitionMatrix(prevStateIndexes,:);
    
    if(~sum(partialTrellis(:,2)==1))
        warning(['There are no "1" paths from state ' num2str(state)]);
        return;
    end
       
    if(~sum(partialTrellis(:,2)==0))
        warning(['There are no "0" paths from state ' num2str(state)]);
        return;
    end 
end

%Check that there exists at least one incoming paths for each state
for state=newStates'     
    nextStateIndexes=find(nextStates==state);
    partialTrellis=transitionMatrix(nextStateIndexes,:);
    
    if(~numel(partialTrellis))
        warning(['There are no paths enterig state ' num2str(state)]);
        return;
    end
       
     
end
isok=1;

end

