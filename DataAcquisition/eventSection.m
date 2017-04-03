%EVENTSECTION Extracts the times for one event in every specific section.
%
%   Genera los tiempos de inicio y término dentro de la sección deseada
%   Se crea la variable eventSection, la cual puede ser una celda del largo
%   igual a la cantidad de eventos, un una matriz con los valores de inicio
%   y fin.
%   En cada cerda se encontradá una matriz la cual contiene en la primera
%   columna los tiempos de inicio y en la segunda los de termino.
%
%   ejemplo
%
%   eventSection = eventSection(eyeLeftFix,trialEvent.etapa2,trialEvent.etapa3,1)
%   Entrega una matriz con los tiempos de las fijaciones en la etapa 2, con
%   una tercera columla la cual corresponde a la sección correspondiente
%
%   eventSection = eventSection(eyeLeftFix,trialEvent.etapa2,trialEvent.etapa3,2)
%   Entrega una celda, donde:
%
%       eventSection{4}
%
%   ans =
%
%       5259118     5259074
%       5259342     5259322
%       5259652     5259630
%       5260130     5260110
%       5260556     5260544
%
%
%   Toolbox
%   Laboratorio Neurosistemas
%   Samuel Obama Trump
%   Versión 2.0
%   13.09.2015

function eventSection = eventSection(event,sectionStartTimes,sectionEndTimes,typeData)

% Inicialización
eventSection = [];

for i = 1:length(sectionStartTimes)
    
    % Recuperación de los tiempos del evento en la sección indicada
    auxStartTimes = getDataFromTo(sectionStartTimes(i),sectionEndTimes(i),event.startTimes);
    auxEndTimes = getDataFromTo(sectionStartTimes(i),sectionEndTimes(i),event.endTimes);
    
    try
    if auxStartTimes(1) > auxEndTimes(1)
        auxEndTimes = auxEndTimes(2:end);
        auxStartTimes = auxStartTimes(1:end-1);
    end
    end
    
    if isempty(auxStartTimes) || isempty(auxEndTimes)
        continue
    end
    
    % Limpiado de datos, dejando los que realmente corresponden
    if length(auxStartTimes) < length(auxEndTimes)
        auxEndTimes = auxEndTimes(2:end);
    elseif length(auxStartTimes) > length(auxEndTimes)
        auxStartTimes = auxStartTimes(1:end-1);
    end 
    
    % Entrega de resultados según lo ingresado en la función
    if typeData == 1
        largoMatrizFinal = size(eventSection,1);
        largoMatrizAuxiliar = length(auxStartTimes);
                
        eventSection(largoMatrizFinal+1:largoMatrizFinal+largoMatrizAuxiliar,:) = [auxStartTimes auxEndTimes ones(largoMatrizAuxiliar,1)*i];
        
    elseif typeData == 2
        eventSection{i} = [auxStartTimes auxEndTimes];
    else
        eventSecion = NaN;
        %         disp('Valor de entrada inválido. Ver Help de la función');
    end
    
end


