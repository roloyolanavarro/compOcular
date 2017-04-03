%TIME2INDEX Retorna los indices de los tiempos ingresados
%
%   indexes = time2index(eventTimes,time) retorna una matriz de la mismas
%   dimensiones de eventTimes en las cuales para cada tiempo le asigna el
%   indice del vector de tiempo correspondiente.
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function indexes = time2index(eventTimes,time)

    % Inicialización
    indexes = zeros(size(eventTimes));
    
    % Generación índices
    [A,B] = size(eventTimes);
    
    for i = 1:B
        
        for j = 1:A
            
            indexes(j,i) = find(time>=eventTimes(j,i),1,'first');
            
        end
        
    end
    
end