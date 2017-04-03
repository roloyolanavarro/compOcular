%ASC2MAT Process Asc EyeLink File to a matrix inside matlab.
%
%   processedFile = asc2mat(filePath) transforms asc text data to a
%   matrix inside matlab to be used by other data-extraction functions.
%   Each matrix row is a string containing a line from the asc document.
% 
%   For example 
%   
%       asc = asc2mat('path/ascName.asc'); 
%
%   Will return a matrix asc where we can extract, for example, blink
%   events for the left eye with the 'getEventData' function this
%   way:
%
%       blinkl = getEventData('EBLINK L',asc);}
%
%   To understand how this function works and how can it be used
%   SEE ALSO fopen textscan
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function processedFile = asc2mat(filePath)
    
    fid = fopen(filePath);
    processedFile = textscan(fid, '%s','delimiter', '\n');
    processedFile = processedFile{1};
   
end