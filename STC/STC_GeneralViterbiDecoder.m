function [ m, error ] = STC_GeneralViterbiDecoder( y,trellis )
% Function implementing Viterbi algorithm for decoding when there are more
% then one path can be used for transmission 0 or 1 
%y - bit chain to decode
%trellis - matrix describing structure of the trellis - all allowed paths
%for all allowed stated. Use STC_gentransitionMatrix to generate proper
%trellis.

%Choose all unique states from trellis (Calculating parameters indirectly
%from input)
states=unique(trellis(:,1));
numStates=numel(states);
n=numel(y);
prevStates=(trellis(:,1));
nextStates=(trellis(:,4));
blockSize=numel(dec2bin(max(trellis(:,3))));
%Creating matrices to work with
wght=inf*ones(numStates,1);
newwght=wght;
wght(1)=0;
path=inf*ones(numStates,floor(n/blockSize));
outputBitsPath=inf*ones(numStates,floor(n/blockSize));
inputBitsPath=inf*ones(numStates,floor(n/blockSize));
%Forward part
disp('Starting forward part');
%Loop by columns of the trellis i.e. by blocck of bits of the message
for i=1:floor(n/blockSize)
    if(mod(i,10)==0)
        disp(['Forward part: block ' num2str(i) ' from ' num2str(floor(n/blockSize)) ]);
    end
    Y=y(1+blockSize*(i-1):blockSize*i);
    %Loop by destination states on current step
    for newState=states'
        
        newStateIndexes=find(nextStates==newState);
        partialTrellis=trellis(newStateIndexes,:);
        %Loop by previous states
        for prevState=states'
            if(wght(prevState+1)==inf)% Assuming that states are continious
                continue;
            end
            
            %Calculate weight of transition from prevState to newState
            prevStates=partialTrellis(:,1);
            possibleTransitionsIndexes=find(prevStates==prevState);
            possibleTransitions=partialTrellis(possibleTransitionsIndexes,:);
            
            %We can move from one state to another with more then 1 or even
            %2 paths
            [nTransitions,~]=size(possibleTransitions);
            %Loop by possible transitions
            for transition=1:nTransitions
                wTrans=sum(dec2binvec(double(possibleTransitions(transition,3)),blockSize)~=Y);
                w=wTrans+wght(prevState+1);
                if(w<newwght(newState+1))
                    newwght(newState+1)=w;
                    path(newState+1,i+1)=prevState;
                    outputBitsPath(newState+1,i+1)=possibleTransitions(transition,3);
                    inputBitsPath(newState+1,i+1)=possibleTransitions(transition,2);
                end
            end
            
        end   
    end
    
    wght=newwght;
    newwght(:)=inf;
end


%Backward part
disp('Starting backward part');
[error,indexOfSurvivedState]=min(wght);
m=inf*ones(1,floor(n/blockSize));
state=indexOfSurvivedState-1;

for i=floor(n/blockSize):-1:1
    m(i)=inputBitsPath(state+1,i+1);
    state=path(state+1,i+1);
end

end

