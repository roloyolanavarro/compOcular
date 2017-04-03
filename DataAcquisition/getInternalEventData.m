%GETINTERNALEVENTDATA Returns an event structure with data inside
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
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function output = getInternalEventData(event,asc)

    %Find lines where event is
    foundLines = countLines(event, asc);
    
    %Initialize output (it will depend on event)
    switch true
        case ~isempty(regexp(event,'^!CAL','once'))
            foundEvents = {foundLines};
            output.startTimes = NaN(length(foundLines),1);
            output.minError = NaN(length(foundLines),1);
            output.avgError = NaN(length(foundLines),1);
            dataPosition = {[1 3 4]};
            
        case ~isempty(regexp(event,'^display','once'))
            foundEvents = {foundLines};
            output.startTimes = NaN(length(foundLines),1);
            output.pageNumber = NaN(length(foundLines),1);
            output.scrollNumber = NaN(length(foundLines),1);
            dataPosition = {[1 3 4]};
            
        case ~isempty(regexp(event,'^ESACC','once'))
            foundEvents = {foundLines};
            output.startTimes = NaN(length(foundLines),1);
            output.endTimes = NaN(length(foundLines),1);
            output.startX = NaN(length(foundLines),1);
            output.startY = NaN(length(foundLines),1);
            output.endX = NaN(length(foundLines),1);
            output.endY = NaN(length(foundLines),1);
            output.gradeAmplitude = NaN(length(foundLines),1);
            output.peakVelocity = NaN(length(foundLines),1);
            
            dataPosition = {[1 2 4 5 6 7 8 9]};
            
        case ~isempty(regexp(event,'^EFIX','once'))
            foundEvents = {foundLines};
            output.startTimes = NaN(length(foundLines),1);
            output.endTimes = NaN(length(foundLines),1);
            output.meanX = NaN(length(foundLines),1);
            output.meanY = NaN(length(foundLines),1);
            output.meanPupilSize = NaN(length(foundLines),1);
            
            dataPosition = {[1 2 4 5 6]};
            
        case ~isempty(regexp(event,'^MOUSE','once'))
            foundUpEvents = foundLines(countLines('MOUSE_UP',asc(foundLines)));
            foundDownEvents = foundLines(countLines('MOUSE_DOWN',asc(foundLines)));
            foundMoveEvents = foundLines(countLines('MOUSE_MOVE',asc(foundLines)));
            foundEvents = {foundUpEvents;foundDownEvents;foundMoveEvents};
            
            output.mouseUpTimes = NaN(length(foundUpEvents),1);
            output.mouseUpButton = NaN(length(foundUpEvents),1);
            output.mouseUpEventNumber = NaN(length(foundUpEvents),1);
            output.mouseUpNumber = NaN(length(foundUpEvents),1);
            output.mouseUpX = NaN(length(foundUpEvents),1);
            output.mouseUpY = NaN(length(foundUpEvents),1);
            
            output.mouseDownTimes = NaN(length(foundDownEvents),1);
            output.mouseDownButton = NaN(length(foundDownEvents),1);
            output.mouseDownEventNumber = NaN(length(foundDownEvents),1);
            output.mouseDownNumber = NaN(length(foundDownEvents),1);
            output.mouseDownX = NaN(length(foundDownEvents),1);
            output.mouseDownY = NaN(length(foundDownEvents),1);
            
            output.mouseMoveTimes = NaN(length(foundMoveEvents),1);
            output.mouseMoveButtonPress = NaN(length(foundMoveEvents),1);
            output.mouseMoveEventNumber = NaN(length(foundMoveEvents),1);
            output.mouseMoveXpos = NaN(length(foundMoveEvents),1);
            output.mouseMoveYpos = NaN(length(foundMoveEvents),1);
            
            dataPosition = {[1 2 3 4 5 6];[1 2 3 4 5 6];[1 2 3 4 5]};
            
        case ~isempty(regexp(event,'^KEY','once'))
            foundDownEvents = foundLines(countLines('KEY_DOWN',asc(foundLines)));
            foundUpEvents = foundLines(countLines('KEY_UP',asc(foundLines)));
            foundEvents = {foundDownEvents;foundUpEvents};
            
            output.keyDownTimes = NaN(length(foundDownEvents),1);
            output.keyDownNumber = NaN(length(foundDownEvents),1);
            output.keyDownEventNumber = NaN(length(foundDownEvents),1);
            output.keyDownKey = cell(length(foundDownEvents),1);
            
            output.keyUpTimes = NaN(length(foundUpEvents),1);
            output.keyUpNumber = NaN(length(foundUpEvents),1);
            output.keyUpEventNumber = NaN(length(foundUpEvents),1);
            output.keyUpKey = cell(length(foundUpEvents),1);
            
            dataPosition = {[1 2 3];[1 2 3]}; 
            %Last variable will be filled specially (keyboard char)
            
        case ~isempty(regexp(event,'^EBLINK','once'))
            foundEvents = {foundLines};
            output.startTimes = NaN(length(foundLines),1);
            output.endTimes = NaN(length(foundLines),1);
            dataPosition = {[1 2]};
            
        otherwise
            disp('--Warning: This might not be an internal event data');
            disp('--Please use the documentation of getInternalEventData');
            output = [];
            return;
    end
    
    %Key event present
    keyEvent = ~isempty(regexp(event,'^KEY','once'));
    
    %Fill every value inside output
    variables = fieldnames(output);
    counter = 0;
    for i = 1:length(foundEvents)
        event = foundEvents{i};
        auxDataMatrix = NaN(length(event),length(dataPosition{i}));
        
        if keyEvent 
           keys = cell(length(event),1); 
        end
        
        for j = 1:length(event)
       numbers = str2numVector(asc{event(j)});
           auxDataMatrix(j,:) = numbers(dataPosition{i}');
           
            %Special case: key character
            if keyEvent
                key = regexp(asc{event(j)},'(\[)(\w*)(\])','match');
                keys{j,1} = key(2:end-1);
            end
           
        end
        
        for k = 1:length(dataPosition{i})
            output.(variables{k+counter}) = auxDataMatrix(:,k);
        end
        
        if keyEvent %Fill character key used in event
           output.(variables{length(dataPosition{i})+1+counter}) = keys;
           counter = counter + 1;
        end
        
        counter = counter + length(dataPosition{i});
      
    end

end