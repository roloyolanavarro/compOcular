%STR2NUMVECTOR Outputs a double vector with numbers found in lineString.
%
%   output = str2numVector(lineString) will give a double vector with
%   numbers found in lineString argument, this function recognises decimal
%   numbers and other cases (see example below).
%
%   For example:
%
%       output = str2numVector('-20.1axk)1987ooo.2aaa.aaa');
%
%   Will return [-20.1; 1987; 0.2; NaN];
%
%   Note that in the case '.' alone a NaN output is given, this was chosen
%   this way because in EyeLink data inside a blink we'll get a '.' when
%   data can't be seen but still we have to mark it as "a number that can't
%   be seen" and finally note that also recognices e+00X nomenclature.
%   
%   SEE ALSO regexp
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function output = str2numVector(lineString)

    %Generate numeric strings
    numStrings = regexp(lineString,'(\s(\.|\,)\s)|(-?\d*(\.|\,)?\d+)(\e(\+|\-)\d+)*','match');
    
    %Allocate output memory
    output = NaN(length(numStrings),1);
    
    %Transform str to numbers
    for i = 1:length(numStrings)
        %Replace comma decimal notation to point decimal notation
        numStrings{i} = strrep(numStrings{i},',','.');
        output(i,1) = str2double(numStrings{i});
    end

end