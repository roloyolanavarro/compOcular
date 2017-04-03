%AMOUNTOFMISSINGDATA cuenta la cantidad de missing Data.
%
%   completar
%

function [amount,percent] = amountOfMissingData(processedAsc)
    
    count = 0;
    
    for i = 1:length(processedAsc)   
        if isnan(processedAsc(i))
            count = count + 1;
        end
    end
    
    amount = count;
    percent = amount*100/length(processedAsc);
    
end