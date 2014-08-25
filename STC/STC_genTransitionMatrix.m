function [ transitions ] = STC_genTransitionMatrix( h_hat )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
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
        Y=flipud((dec2bin(outputBits,w)=='1')');
        nextStateBits=mod(h_hat*Y+stateBits,2);
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

    

end

