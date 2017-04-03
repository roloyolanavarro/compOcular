%GETDATA Retorna un exrtacto de matriz de datos entre dos tiempos
%
%   dataFromTo = getDataFromTo(startTime,endTime,data) retornará una matriz
%   de datos extraidos desde la matriz data completa, entre los tiempos
%   startTime y endTime.
%
%   For example:
%
%       dataFromTo = getDataFromTo(time(1),time(end),data)
%
%   Retornará exactamente la misma matriz data, pues el extracto pedido es
%   desde el primer tiempo medido hasta el último.
%
%   To understand how this function works and how can it be used
%   SEE ALSO getData
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function eventFromTo = getEventFromTo(startTime,endTime,event)

    %Encontrar indices de los tiempos 
    startIndex = find(event.startTimes>=startTime,1,'first');
    endIndex = find(event.endTimes<=endTime,1,'last');
    
    names = fieldnames(event);
    
    %Cortar la matriz de datos entre indices
    for i=1:length(names);
        eventFromTo.(names{i}) = event.(names{i})(startIndex:endIndex);     
    end

end