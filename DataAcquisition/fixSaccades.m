%This function differs from the fixSaccadesOffsets function as it fixes
%offsets only by mosaic intervals
function output = fixSaccades(time, pupilSignal, saccEvent, mosaicEvent)

    output = pupilSignal;
    
    for i = 1:length(mosaicEvent.startTimes)
        
        %find start and end index of mosaic by searching it's times
        startIndex = find(time<=mosaicEvent.startTimes(i),1,'last');
        endIndex = find(time>=mosaicEvent.endTimes(i),1,'first');
        
        %fix saccades inside that interval
        if ~isempty(startIndex)&&~isempty(endIndex)
            
            output(startIndex:endIndex) = fixSaccadesOffsets(time(startIndex:endIndex),pupilSignal(startIndex:endIndex),saccEvent,10);
            
        end
        
    end

end