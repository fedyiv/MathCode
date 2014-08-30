function [ trellis ] = STC_genTransitionMatrixExtendedWithCheck( h_hat,exclusionProbability )
%Check the matrix after generation. If it is worng then regenerating it;
%


isok=0;
maxAttempts=30;
attempts=1;
while(isok==0)
    trellis=STC_genTransitionMatrixExtended (h_hat,exclusionProbability);
    isok=STC_validateTransitionMatrix(trellis);
    
    if(isok==0)
        warning(['TransitionMatrix is invalid. Regenerating... Attempt ' num2str(attempts)]);
        if(attempts>=maxAttempts)
            error(['Could not generate valid TransitionMatrix in ' num2str(attempts) 'attempts.Exiting']);
        end
    end   
    attempts=attempts+1;
end

end

