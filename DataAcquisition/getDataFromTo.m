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

function dataFromTo = getDataFromTo(startTime,endTime,data)

    %Encontrar indices de los tiempos 
    startIndex = find(data(:,1)>=startTime,1,'first');
    endIndex = find(data(:,1)<=endTime,1,'last');
    
    %Cortar la matriz de datos entre indices
    dataFromTo = data(startIndex:endIndex,:);

end