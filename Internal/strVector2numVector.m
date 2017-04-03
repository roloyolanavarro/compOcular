
function output = strVector2numVector(cellString)

    %Size
    siz = size(cellString);
    
    for j = 1:siz(1);
        
        output(j,[1 2]) = str2numVector2(cellString{j,1});

    
    end
        

    
    
    function output = str2numVector2(lineString)

    %Generate numeric strings
    numStrings = regexp(lineString,'(\s(\.|\,)\s)|(-?\d*(\.|\,)?\d+)(\e(\+|\-)\d+)*','match');
    
    %Allocate output memory
    output = NaN(length(numStrings),1);
    
    %Transform str to numbers
    for i = 1:length(numStrings)
        %Replace comma decimal notation to point decimal notation
        numStrings{i} = strrep(numStrings{i},',','.');
        output = str2double(numStrings{i});
    end

end
    


end