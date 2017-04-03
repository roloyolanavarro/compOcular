%GENERATEVELOCITIES Retorna las velocidades a partir de un vector de posiciones.
%
%   velocities = generateVelocities(positionVector) generará y entregará 
%   un vector con las velocidades de las mismas dimensiones del vector de 
%   posiciones.
%
%   Por ejemplo:
%
%       eyeLeftVelocityX = generateVelocities(eyeLeftPositionX);
%
%   La funcion generateVelocities retornará un vector con las velocidades 
%   de eyeLeftPositionX, y en este caso, estas velocidades se guardarán en
%   la variable eyeLeftVelocityX.
%
%   Para generar las velocidades la función promedia la derivada discreta
%   hacia adelante (v(t) = (x(t+1)-x(t))/2) con la derivada discreta hacia
%   atras (v(t) = (x(t)-x(t-1))/2), por lo tanto de haber valores tipo NaN
%   las velocidades que los usarán para su calculo quedarán expresadas como
%   NaN también.
%
%   Los valores extremos (velocityVector(1) y velocityVector(end)) se
%   calcularán con la velocidad discreta hacia adelante o hacia atrás
%   correspondientemente sin promediarlas
%
%   To understand how this function works and how can it be used
%   SEE ALSO addVelocities
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function velocityVector = generateVelocities(positionVector)

    % Inicialización
     velocityVector = NaN(length(positionVector),1);

    % Asignación de valores de las derivadas
    derivedBack = (positionVector(2:end)-positionVector(1:end-1))/2;
    derivedForward = (positionVector(2:end)-positionVector(1:end-1))/2;
    
    % Promedio de ambas derivadas
    velocityVector(1) = derivedForward(1);
    velocityVector(end) = derivedBack(end);
    velocityVector(2:end-1) =  (derivedBack(1:end-1)+derivedForward(2:end))/2;
    
end



