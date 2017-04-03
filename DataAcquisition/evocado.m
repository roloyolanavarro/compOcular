%EPOCADO Corta la matriz de datos en epocas
%
%   
%
function evocado = evocado(matchEvents,backwardTime,forwardTime,zerOneEvent,time)
    
    %Inicialización
    epocas = cell(length(matchEvents),1);
    data = [];
    
    %Epocas
    for i = 1:length(matchEvents)
        
        epocas{i} = getDataFromTo(matchEvents(i)-backwardTime,matchEvents(i)+forwardTime,[time zerOneEvent]);
        data = [data;epocas{i}(:,2)'];
        
    end
    
    evocado = mean(data);
    
    plot(1:length(evocado),evocado
    );