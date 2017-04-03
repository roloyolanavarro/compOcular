%INDEX2TIME Retorna los tiempos de los indices ingresados
%
%   times = index2time(eventIndexes,time) retorna una matriz de la mismas
%   dimensiones de eventIndexes en las cuales para cada indice del vector
%   time, le asigna el tiempo correspondiente.
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Mu�oz
%   Versi�n 1.0
%   23.09.2014

function times = index2time(eventIndexes,time)

    % Inicializaci�n
    times = zeros(size(eventIndexes));
    
    % Generaci�n �ndices
    [A,B] = size(eventIndexes);
    
    for i = 1:B
        
        for j = 1:A
            
            times(j,i) = time(eventIndexes(j,i));
            
        end
        
    end
    
end