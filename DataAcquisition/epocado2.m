%EPOCADO2 Corta la matriz de datos en epocas
%
%   
%
function epocas = epocado2(eventsBackward,eventsForward,data)
    
    %Inicialización
    time = data(:,1);
    epocas = cell(length(eventsBackward),1);
    
    %Epocas
    for i = 1:length(eventsBackward)
        
        epocas{i,1} = getDataFromTo(eventsBackward(i),eventsForward(i),data);
        
    end
    