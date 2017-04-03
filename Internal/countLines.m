%COUNTLINES Gives an index vector with lines where pattern is found.
%
%   lineIndexes = countLines(pattern,processedAsc) will search for a
%   pattern in each line in the processed asc matrix, this function is used
%   internally in other data extraction functions to know the space to be
%   allocated by them.
%   
%   For more information in how the argument 'pattern' works or where the
%   argument processedAsc comes from:
%
%   SEE ALSO regexp
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function lineIndexes = countLines(pattern,processedAsc)
    
    %Count number of lines and fill indexes
    count = 0;
    lineIndexes = cell(length(processedAsc),1);
    
    for i = 1:length(processedAsc)
        
        line = processedAsc{i};
        if ~isempty(regexp(line,pattern,'match'))
            count = count+1;
            lineIndexes{count} = i;
        end
    end
    
    lineIndexes = cell2mat(lineIndexes);

end