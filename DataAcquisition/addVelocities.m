%ADDVELOCITIES Genera y asigna las velocidades a la matriz de datos
%
%   newDataMatrix = addVelocities(eyesAmount,dataMatrix) retornar� una 
%   nueva matriz de datos la cual contendr� en este caso las velocidades 
%   faltantes. Es importante notar que la adici�n de velocidades es 
%   independiente de si existe previamente, por tanto el investigador debe
%   saber si sus datos las contienen previamente o no. 
%
%   Por ejemplo:
%
%       data = addVelocities(2,data);
% 
%   La funci�n retornar� una matriz con las velocidades generadas para
%   ambos ojos en las columnas correspondientes a las que ser�an obtenidas
%   normalmente por el eyeTracker.
%
%   To understand how this function works and how can it be used
%   SEE ALSO generateVelocities
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Mu�oz
%   Versi�n 1.0
%   23.09.2014

function newDataMatrix = addVelocities(eyesAmount,dataMatrix)

    addpath Internal

    newDataMatrix = dataMatrix;

    % Se agregan las velocidades dependiendo de cuantos ojos hayan 
    if eyesAmount == 1
        
        disp('--Registration of an eye');
        try
            newDataMatrix(:,7) = newDataMatrix(:,5);
            newDataMatrix(:,8) = newDataMatrix(:,6);
        end
        newDataMatrix(:,5) = generateVelocities(dataMatrix(:,2));
        newDataMatrix(:,6) = generateVelocities(dataMatrix(:,3));

    elseif eyesAmount == 2

        disp('--Registration of two eye');
        try
            newDataMatrix(:,12) = newDataMatrix(:,8);
            newDataMatrix(:,13) = newDataMatrix(:,9);
            newDataMatrix(:,14) = newDataMatrix(:,10);
            newDataMatrix(:,15) = newDataMatrix(:,11);
        end
        newDataMatrix(:,8) = generateVelocities(dataMatrix(:,2));
        newDataMatrix(:,9) = generateVelocities(dataMatrix(:,3));
        newDataMatrix(:,10) = generateVelocities(dataMatrix(:,5));
        newDataMatrix(:,11) = generateVelocities(dataMatrix(:,6));

    else
        
        disp(['--Warning: ' num2str(eyesAmount) ' is invalid, must choose either 1 or 2 eyes']);
        
    end
   
end