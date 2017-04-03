%INTERPOLATEBLINKS Interpolates indexed data in blinks interval.
%
%   output = interpolateBlinks(time,input,sblink,eblink,timeExtention)
%   will return new output just like input but with blink intervals
%   interpolated.
%
%   For example, if we have pupil size data in a vector, a time vector and
%   blink time indexes we can interpolate this way:
%
%       newPupil = interpolateBlinks(times, pupilSize, blink,20);
%
%       Where newPupil will be a Nx1 vector with interpolated pupil size,
%       with a time window of 20 ms, this means we will interpolate in a
%       bigger window than just the blink interval, this is useful because
%       some data can be missing in the near neighbor of a blink.
%
%   Graphically:
%
%       |----------|--------------------------|-----------|
%       +timeExt        blink missing data      +timeExt
%
%   Transforms to:
%
%       |-------------------------------------------------|
%                       interpolated data
%
%   For more information about where inputs come from
%   SEE ALSO getData getEventData
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function output = interpolateBlinks(time,input,blink,timeExtension)

    output = input;
    
    for i = 1:length(blink.startTimes)
        
        %Find nearest indexes in data to those of blinks interval
        first = find(time<=blink.startTimes(i),1,'last');
        last = find(time>=blink.endTimes(i),1,'first');
        
        %Extend interval to 'timeExtension' ms
        while(first > 1 && blink.startTimes(i)-time(first) < timeExtension)
           first = first - 1; 
        end
        while(last < length(time) && time(last)-blink.endTimes(i) < timeExtension)
           last = last + 1; 
        end

        %Interpolate between found interval
        output(first:last) = linspace(input(first),input(last),last-first+1);
    end
   
end