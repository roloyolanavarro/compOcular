%EPOCADO Corta la matriz de datos en epocas
%
%   
%
function epocas = epocado(events,backwardTime,forwardTime,data)
    
    %Inicialización
    time = data(:,1);
    epocas = cell(length(events),1);
    
    %Epocas
    for i = 1:length(events)
        
        epocas{i,1} = getDataFromTo(events(i)-backwardTime,events(i)+forwardTime,data);
        
    end