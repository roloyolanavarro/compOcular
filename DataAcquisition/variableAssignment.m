%VARIABLEASSIGNMENT Asigna nombres a los vectores de la matriz de datos
%
%   variableAssignment es un script que toma las columnas importantes de la
%   matriz de datos, y le asigna el nombre correspondiente. Resulta util
%   para la posterior manipulación de datos como el tiempo o las pupilas de
%   ambos ojos, pero no es extrictamente necesario.
%
%   To understand how this function works and how can it be used
%   SEE ALSO addVelocities
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

time = data(:,1);

% % Si hay 2 ojos registrados
% % if length(data(1,:)) >= 10

    eyeLeftPositionX = data(:,2);
    eyeLeftPositionY = data(:,3);
    eyeLeftPupilSize = data(:,4);
    eyeRightPositionX = data(:,5);
    eyeRightPositionY = data(:,6);
	eyeRightPupilSize = data(:,7);
    eyeLeftVelocityX = data(:,8);
    eyeLeftVelocityY = data(:,9);    
    eyeRightVelocityX = data(:,10);
    eyeRightVelocityY = data(:,11);

% % Si hay un ojo registrado    
% else
% 
%     eyePositionX = data(:,2);
%     eyePositionY = data(:,3);
%     eyePupilSize = data(:,4);
% %     eyeVelocityX = data(:,5);
%     eyeVelocityY = data(:,6);

% end
