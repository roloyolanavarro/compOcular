%GETTIMESOF Returns times and indexes when a certain event happens in data.
%
%   [times lineIndexes] = getTimesOf(word,processedAsc) will return every
%   time and line where a certain string word is found inside the
%   processedAsc matrix.
%
%   For example:
%
%       [sfixLTimes sfixLIndexes] = getTimesOf('SFIX L',processedAsc);
%
%   Will return a time vector and an index vector where a fixation for the
%   left eye starts. Any event recognizable with a word inside ascii file
%   can be used as argument in 'word'.
%
%   Also note in this example:
%
%       [startTimes] = getTimesOf('START',processedAsc);
%
%   That only the times vector is saved and the index vector is suppressed
%   for a cleaner process.
%
%   For information about the possible uses of these outputs
%   SEE ALSO cleanSaccades interpolateBlinks
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function [times lineIndexes] = getTimesOf(word,processedAsc)

    addpath Internal

    %Find lines where word is
    lineIndexes = countLines(word, processedAsc);
    
    %Initialize output
    times = zeros(length(lineIndexes),1);
    
    %Extract number at position depending on word input
    if ~isempty(regexp(word,'^ESACC|^EBLINK|^EFIX','once'))
        timePosition = 2;
    else
        timePosition = 0; 
        %Zero means to use default position: where max number is.
    end
    
    %If foundLines is not empty then we search times
    if ~isempty(lineIndexes)
        for i = 1:length(lineIndexes)
            numVector = str2numVector(processedAsc{lineIndexes(i)});
            switch timePosition
                case 0
                    times(i) = max(numVector);
                otherwise
                    times(i) = numVector(timePosition);
            end
        end
    end

end