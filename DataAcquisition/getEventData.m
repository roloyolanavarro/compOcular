%GETEVENTDATA Returns an event structure with data inside
%
%   output = getEventData(eventName,processedAsc) will return an structure
%   containing data according to the given event
%
%   For example:
%
%       blinkl = getEventData('EBLINK L',processedAsc);
%
%   Will return an structure with startTimes and endTimes vector inside.
%   Note that although "end blink" event is called, this event contains
%   also starting blink event info.
%
%   In this example:
%
%       mouseEvents = getEventData('MOUSE',processedAsc);
%
%   Mouse event data will be stored, this means MOUSE_UP, MOUSE_DOWN and
%   MOUSE_MOVE events will be stored. Other possible events that can be
%   stored are: KEYBOARD, EFIX L/R, ESACC L/R, etc.
%
%   This function was created to implement an easy way to extend event 
%   extraction capacity: If a new kind of event appears, then this function
%   can be easily extended by current dev.
%   
%   For information about the possible uses of these outputs
%   SEE ALSO getTimesOf cleanSaccades interpolateBlinks
%
function output = getEventData(event,asc)

    %Find lines where event is
    foundLines = countLines(event, asc);

    %Initialize output (it will depend on event)
    foundEvents = {foundLines};
    output.startTimes = NaN(length(foundLines),1);
    output.unknown = NaN(length(foundLines),1);
    dataPosition = {[1 2]};

    %Fill every value inside output
    variables = fieldnames(output);
    counter = 0;
    
    for i = 1:length(foundEvents)
        event = foundEvents{i};
        auxDataMatrix = NaN(length(event),length(dataPosition{i}));
     
        for j = 1:length(event)
           numbers = str2numVector(asc{event(j)});
           auxDataMatrix(j,:) = numbers(dataPosition{i}');
        end
        
        for k = 1:length(dataPosition{i})
            output.(variables{k+counter}) = auxDataMatrix(:,k);
        end
        
        counter = counter + length(dataPosition{i});
      
    end

end

