%PRINTINFORMATION 
%
%optimizar

function  printInformation(processedAsc)

    %inicializaci�n
    count = 0; line = '**';
    
    %busqueda e impresi�n de lineas '**'
    while ~isempty(regexp(line,'**','match'));
        disp(line);
        count = count + 1;    
        line = processedAsc{count};
        
    end
            
end

