function [ y, cost ] = STC_GeneralViterbiEncoder( x,rho,m,trellis )
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
n=numel(x);
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
    disp(['Forward part: block ' num2str(i) ' from ' num2str(floor(n/blockSize)) ]);
    X=x(1+blockSize*(i-1):blockSize*i);
    RHO=rho(1+blockSize*(i-1):blockSize*i);
    
    %Selecting only transitions thet convey m(i) bit
    inputBits=trellis(:,2);
    selectedMTransitionIndexes=find(inputBits==m(i));
    selectedMTransition=trellis(selectedMTransitionIndexes,:);
    
    
    %Loop by destination states on current step
    for newState=states'
        %Selecting rows of the trellis only corresponding to the state in question 
        nextStates=selectedMTransition(:,4);
        newStateIndexes=find(nextStates==newState);
        partialTrellis=selectedMTransition(newStateIndexes,:);
        %Loop by previous states
        for prevState=states'
            if(wght(prevState+1)==inf)% Assuming that states are continious
                continue;
            end
            
            %Selecting only transitions leading to prevState
            prevStates=partialTrellis(:,1);
            possibleTransitionsIndexes=find(prevStates==prevState);
            possibleTransitions=partialTrellis(possibleTransitionsIndexes,:);
            
            %We can move from one state to another with more then 1 or even
            %2 paths
            [nTransitions,~]=size(possibleTransitions);
            %Loop by possible transitions
            for transition=1:nTransitions
                %Calculate weight of transition from prevState to newState
                wTrans=sum((dec2binvec(double(possibleTransitions(transition,3)),blockSize)~=X).*RHO);
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
[cost,indexOfSurvivedState]=min(wght);

y=inf*ones(1,n);
state=indexOfSurvivedState-1;

for i=floor(n/blockSize):-1:1
    y(1+(i-1)*blockSize:i*blockSize)=dec2binvec(outputBitsPath(state+1,i+1),blockSize);
    state=path(state+1,i+1);
end

end

