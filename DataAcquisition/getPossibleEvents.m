%GETPOSSIBLEEVENTS 
%
%optimizar

function [possibleEvents,indexes] = getPossibleEvents(processedAsc)

    addpath ../Internal

    count = 0;
    countToStart = 0; 

    %lineIndexes = cell(length(processedAsc),1);
    line = '';
    while isempty(regexp(line,'START','match'));
        countToStart = countToStart + 1;    
        line = processedAsc{countToStart}; 
    end
    
    possibleEvents{1} = '';
    
    for i = countToStart:length(processedAsc)
        
        line = processedAsc{i};
        [match,events] = regexp(line,'MSG\s\d+\s','match','split');
        
        if ~isempty(match)
            event = regexp(events{2},'(-)?\w+(\s.\w+)?(.)?','match');
        
            if noRepeatEvent(event{1},possibleEvents)
                count = count+1;
                possibleEvents{count} = event{1};
                indexes(count) = i;
            end
            
        end
        
    end
    
    try
        indexes = indexes';
        possibleEvents = possibleEvents';
    catch
        disp('No events found');
    end
    
end