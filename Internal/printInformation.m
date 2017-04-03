%PRINTINFORMATION 
%
%optimizar

function  printInformation(processedAsc)

    %inicialización
    count = 0; line = '**';
    
    %busqueda e impresión de lineas '**'
    while ~isempty(regexp(line,'**','match'));
        disp(line);
        count = count + 1;    
        line = processedAsc{count};
        
    end
            
end

