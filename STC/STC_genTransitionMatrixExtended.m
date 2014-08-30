function [ transitions ] = STC_genTransitionMatrixExtended( h_hat,exclusionProbability )
%Generates transition matrix from h_hat. Also introduces error correcting
%properties for the code based on the transition matrix by excluding some
%possible paths from trellis creating some redundacny in that way.
[h,w]=size(h_hat);
nStates=2^(h-1);

%Taking into account that from each state can be paths to half of
%the other states(in our case when half of the states are forbidden);
trellisHeight=nStates*2^(w-1);
%Description  |state | inputBits| outputBits| nextState|
%Columns      |   0  |      1   |     2     |     3    |
transitions=uint32(inf*ones(trellisHeight,4));

recNum=1;


%Directions
%Y1     s1
%Y2     s2
%Y3     s3
%...    ...
%Yn     sn


for state=0:nStates-1
    stateBits=flipud((dec2bin(state,h)=='1')');
    for outputBits=0:2^w-1     
        
        %Randomly exclude some paths based on exclusion probability.
        %WARNING: when probability is high it is possible that we will have
        %inconsistent trellis - such that there is a dead-end states or
        %unreachable states. It will be good to create a procedure that
        %validates trellis after generation.
        if(randsrc(1,1,[1 0;exclusionProbability 1- exclusionProbability]))
            continue;
        end
        
        Y=flipud((dec2bin(outputBits,w)=='1')');
        nextStateBits=mod(double(h_hat)*double(Y)+stateBits,2);
        inputBit=nextStateBits(1);
         %add shift here
        nextState=uint32(floor(binvec2dec(nextStateBits')/2));
        
        transitions(recNum,1)=state;
        transitions(recNum,2)=inputBit;
        transitions(recNum,3)=outputBits;
        transitions(recNum,4)=nextState;
        recNum=recNum+1;
        
        if(recNum>=5)
          %  return;
        end

    end
    
end

transitions=transitions(1:recNum-1,:);
    

end

