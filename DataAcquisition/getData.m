%GETDATA Returns a numbers matrix from processedAsc
%
%   data = getData(processedAsc) will return a data matrix where
%   each column is a numeric vector with the data from the processed
%   asc matrix.
%
%   To understand how this function works and how can it be used
%   SEE ALSO regexp countLines interpolateBlinks cleanSaccades
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function data = getData(processedAsc)

    %addpath Internal

    %Get line indexes and quantity of lines with a time-data structure
    %Note that time-data structure always have a positive number as first
    %number, then comes x-y numbers that may be negative and then a posive
    %number containing pupil size (binocular or monocular struct)
    pattern = '^[^0 (\-)]\d+[^(\.|\,)]\d+\s+(-?)((\d*(\.|\,)+\d*)|\d+)\s+(-?)((\d*(\.|\,)+\d*)|\d+)\s+((\d*(\.|\,)+\d*)|\d+)';
    lineIndexes = countLines(pattern,processedAsc);
 
    exampleLine = processedAsc{lineIndexes(1),1};
    
    %Allocate memory for output data
    data = zeros(length(lineIndexes),length(str2numVector(exampleLine)));
    
    if length(exampleLine) > 9
        
        %Start filling data matrix
        for i = 1:length(lineIndexes)
            %Get line and then it's numbers inside
            line = processedAsc{lineIndexes(i),1};
            numVector = str2numVector(line)';
            try
            data(i,:) = numVector;
            end
        end
        
    end
            
end