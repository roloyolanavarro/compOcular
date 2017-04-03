%EVENT2STEPS Genera un vector con unos en donde existe el evento
%
%   onesVector = event2steps(event,time) retorna un vector el cual constar�
%   solo de zeros y unos. Para todo dato en donde el evento est� presente
%   se generar� un uno, en caso contrario un cero.
%   
%   For information about the possible uses of these outputs
%   SEE ALSO time2index
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Mu�oz
%   Versi�n 1.0
%   23.09.2014

function onesVector = event2steps(event,time)
    
    %Inicializaci�n
    globalZeros = zeros(length(time),1);
    indexes = time2index([event.startTimes event.endTimes],time);
    
    %Unos
    for i = 1:length(event.startTimes)
        
        globalZeros(indexes(i,1):indexes(i,2)) = ones(indexes(i,2)-indexes(i,1)+1,1);
        
    end
    
    onesVector = globalZeros;
    
end