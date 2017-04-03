%NOREPEATEVENT
%
%arreglar esto

function isRepeat = noRepeatEvent(event,eventList)

    isRepeat = true;

    for i = 1:length(eventList)
        eventCompared = eventList{i};
        if strcmp(eventCompared,event)
            isRepeat = false;
        end
    end
    
end