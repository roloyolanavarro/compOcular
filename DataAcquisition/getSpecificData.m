%GETSPECIFICDATA Returns a number matrix where each column is desired data. 
%
%   data = getSpecificData(processedAsc,varargin) will return a data matrix where
%   each column is a numeric vector with the desired data from the
%   processed asc matrix. Note that many inputs at the same time is
%   possible.
%
%   For example:
%   
%       data = getSpecificData(processedAsc,'line','time','psl','psr');
%
%   Will return a data matrix where each column will be line number, time,
%   pupil size for the left eye and pupil size for the right eye
%   respectively. Note that if a value can't be found then NaN will be
%   saved.
%
%   Possible inputs for this function are:
%   
%   *For any data type:
%
%       'line' saves line indexes of data.
%       'time'saves times of data.
%       'xr' is x-axis resolution proportion of data.
%       'yr' is y-axis resolution proportion of data.
%
%   *For monocular data:
%
%       'xp' is x-axis position of eye.
%       'yp' is y-axis position of eye.
%       'ps' is pupil size.
%       'xv' is x-axis velocity of eye.
%       'yv' is y-axis velocity of eye.
%
%   *For binocular data:
%
%       'xpl' is x-axis position of left eye.
%       'ypl' is y-axis position of left eye.
%       'xvl' is x-axis velocity of left eye.
%       'yvl' is y-axis velocity of left eye.
%       'psl' is pupil size of left eye.
%       **And the same goes for the right eye (e.g. 'xpr','psr',etc).
%
%   These inputs follow the same names as the EyeLink manual uses. Note
%   that this function may take a long time depending on processedAsc size
%   and computer performance, so it's advisable to use once.
%
%   For example if we want a vector with pupil sizes:
%
%       data = getSpecificData(processedAsc,'lines','times','psl','psr');
%       lines = data(:,1);
%       times = data(:,2);
%       psl = data(:,3);
%       psr = data(:,4);
%
%   We also saved line indexes and times because is useful information for
%   any type of data. To get events like fixations and saccades the
%   'getEventData' or 'getTimesOf' function is used instead.
%
%   To understand how this function works and how can it be used
%   SEE ALSO regexp processAsc interpolateBlinks cleanSaccades
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function data = getSpecificData(processedAsc,varargin)

    addpath Internal

    %Get line indexes and quantity of lines with a time-data structure
    %Note that time-data structure always have a positive number as first
    %number, then comes x-y numbers that may be negative and then a posive
    %number containing pupil size (binocular or monocular struct)
    pattern = '^[^0 (\-)]\d+[^(\.|\,)]\d+\s+(-?)((\d*(\.|\,)+\d*)|\d+)\s+(-?)((\d*(\.|\,)+\d*)|\d+)\s+((\d*(\.|\,)+\d*)|\d+)';
    lineIndexes = countLines(pattern,processedAsc);

    %Allocate memory for output data
    data = zeros(length(lineIndexes),length(varargin));

    %Save data positions to be filled
    dataPositions = zeros(length(varargin),1);
    for i = 1:length(varargin)
        exampleLine = processedAsc{lineIndexes(1),1};
        switch char(varargin(i))
            case 'time'
                dataPositions(i) = 1;
            case 'xp'
                dataPositions(i) = 2;
            case 'yp'
                dataPositions(i) = 3;
            case 'ps'
                dataPositions(i) = 4;
            case 'xv'
                dataPositions(i) = 5;
            case 'yv'
                dataPositions(i) = 6;
            case 'xr'
                dataPositions(i) = length(str2numVector(exampleLine))-1;
            case 'yr'
                dataPositions(i) = length(str2numVector(exampleLine));
            case 'xpl'
                dataPositions(i) = 2;
            case 'ypl'
                dataPositions(i) = 3;
            case 'psl'
                dataPositions(i) = 4;
            case 'xpr'
                dataPositions(i) = 5;
            case 'ypr'
                dataPositions(i) = 6;
            case 'psr'
                dataPositions(i) = 7;
            case 'xvl'
                dataPositions(i) = 8;
            case 'yvl'
                dataPositions(i) = 9;
            case 'xvr'
                dataPositions(i) = 10;
            case 'yvr'
                dataPositions(i) = 11;
            case 'line'
                dataPositions(i) = 0;
            otherwise
                dataPositions(i) = -1;
        end
        
    end

    %Start filling data matrix
    for i = 1:length(lineIndexes)
        
        %Get line and then it's numbers inside
        line = processedAsc{lineIndexes(i)};
        numVector = str2numVector(line);

        for j = 1:length(varargin)
            if dataPositions(j) == 0
                data(i,j) = lineIndexes(i);
            else
                try
                    data(i,j) = numVector(dataPositions(j));
                catch
                    data(i,j) = NaN;
                end
            end
        end
    
    end

end