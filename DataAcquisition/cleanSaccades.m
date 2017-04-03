%CLEANSACCADES Checks anidated blinks in saccades and fixes them.
%
%   [newSACC newBLINK] =
%   cleanSaccades(SACC,BLINK) will return new saccades and
%   blinks event structure with the new intervals as anidated blinks inside 
%   saccades will be extended to saccade interval and last mentioned will 
%   be deleted from the saccade structure. In other words this funcion does
%   the same that cleanSaccades but for structure inputs.
%
%   Graphically:
%
%   start saccade|--------|---------|---------|end saccade
%                            blink
%
%   Transforms to only:
%                            blink
%                |----------------------------|
%
%   Note that same argument may be passed as output to rewrite arguments
%   instead of creating new ones.
%
%   For more informaton in what arguments it may receive
%   SEE ALSO getEventData
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function [newSacc newBlink] = cleanSaccades(saccEvent,blinkEvent)
    
    %Preallocate memory, final saccade and blinks are in the worst case as
    %their initial size
    newSaccStartTimes = cell(size(saccEvent.startTimes));
    newSaccEndTimes = cell(size(saccEvent.endTimes));
    newSaccStartX = cell(size(saccEvent.startX));
    newSaccStartY = cell(size(saccEvent.startY));
    newSaccEndX = cell(size(saccEvent.endX));
    newSaccEndY = cell(size(saccEvent.endY));
    newSaccGradeAmplitude = cell(size(saccEvent.gradeAmplitude));
    newSaccPeakVelocity = cell(size(saccEvent.peakVelocity));
    
    newBlinkStartTimes = cell(size(blinkEvent.startTimes));
    newBlinkEndTimes = cell(size(blinkEvent.endTimes));
    blinkCount = 0;
    saccCount = 0;
    
    %Check every saccade interval, and if it contains a blink, extend that
    %blink to saccade interval and remove saccade
    i = 1; j = 1;
    while i <= length(saccEvent.startTimes) && j <= length(blinkEvent.startTimes)
        
        switch logical(true)
            case  saccEvent.startTimes(i) <= blinkEvent.startTimes(j) && saccEvent.endTimes(i) >= blinkEvent.endTimes(j)            %Saccade contains blink
                newBlinkStartTimes{blinkCount+1} = saccEvent.startTimes(i);
                newBlinkEndTimes{blinkCount+1} = saccEvent.endTimes(i);
                i = i+1;
                j = j+1;
                blinkCount = blinkCount+1;
                
            case saccEvent.startTimes(i) >= blinkEvent.endTimes(j)                                                                  %A blink passed not touching a saccade
                newBlinkStartTimes{blinkCount+1} = blinkEvent.startTimes(j);
                newBlinkEndTimes{blinkCount+1} = blinkEvent.endTimes(j);
                j = j+1;
                blinkCount = blinkCount+1;
                
            case  blinkEvent.startTimes(j) >= saccEvent.endTimes(i)                                                                 %A saccade passed not touching a blink
                newSaccStartTimes{saccCount+1} = saccEvent.startTimes(i);
                newSaccEndTimes{saccCount+1} = saccEvent.endTimes(i);
                newSaccStartX{saccCount+1} = saccEvent.startX(i);
                newSaccStartY{saccCount+1} = saccEvent.startY(i);
                newSaccEndX{saccCount+1} = saccEvent.endX(i);
                newSaccEndY{saccCount+1} = saccEvent.endY(i);
                newSaccGradeAmplitude{saccCount+1} = saccEvent.gradeAmplitude(i);
                newSaccPeakVelocity{saccCount+1} = saccEvent.peakVelocity(i);
                i = i+1;
                saccCount = saccCount+1;
                
            case blinkEvent.startTimes(j) <= saccEvent.startTimes(i) && blinkEvent.endTimes(j) >= saccEvent.endTimes(i)             %A blink contains a saccade
                newBlinkStartTimes{blinkCount+1} = blinkEvent.startTimes(j);
                newBlinkEndTimes{blinkCount+1} = blinkEvent.endTimes(j);
                i = i+1;
                j = j+1;
                blinkCount = blinkCount+1;
                
        end
    end
    
    %Fill remaining data 
    for a = i:length(saccEvent.startTimes)
       newSaccStartTimes{saccCount+1} = saccEvent.startTimes(a);
       newSaccEndTimes{saccCount+1} = saccEvent.endTimes(a);
       newSaccStartX{saccCount+1} = saccEvent.startX(a);
       newSaccStartY{saccCount+1} = saccEvent.startY(a);
       newSaccEndX{saccCount+1} = saccEvent.endX(a);
       newSaccEndY{saccCount+1} = saccEvent.endY(a);
       newSaccGradeAmplitude{saccCount+1} = saccEvent.gradeAmplitude(a);
       newSaccPeakVelocity{saccCount+1} = saccEvent.peakVelocity(a);
       saccCount = saccCount+1;
    end
    for b = j:length(blinkEvent.startTimes)
       newBlinkStartTimes{blinkCount+1} = blinkEvent.startTimes(b);
       newBlinkEndTimes{blinkCount+1} = blinkEvent.endTimes(b);
       blinkCount = blinkCount+1;
    end
    
    %Cast cells to matrix arrays
    newSacc.startTimes = cell2mat(newSaccStartTimes);
    newSacc.endTimes = cell2mat(newSaccEndTimes);
    newSacc.startX = cell2mat(newSaccStartX);
    newSacc.startY = cell2mat(newSaccStartY);
    newSacc.endX = cell2mat(newSaccEndX);
    newSacc.endY = cell2mat(newSaccEndY);
    newSacc.gradeAmplitude = cell2mat(newSaccGradeAmplitude);
    newSacc.peakVelocity = cell2mat(newSaccPeakVelocity);
    newBlink.startTimes = cell2mat(newBlinkStartTimes);
    newBlink.endTimes = cell2mat(newBlinkEndTimes);
    
end
                