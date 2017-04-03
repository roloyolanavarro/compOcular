%GETMICROSACCEVENT Returns an event structure with data inside
%
%   output = getMicrosaccEvent(fixL,fixR,time,data) will return an 
%   structure containing microsaccades data.
%
%   For example:
%
%       microsacc = getMicrosaccEvent(eyeLeftFix,eyeRightFix,time,data);
%
%   Will return an structure with startTimes and endTimes vector inside.
%   The parameters eyeLeftFix and eyeRightFix are to ensure that the two
%   eyes are in a fixation event.

%   Es importante destacar que en esta función se utilizaron las funciones
%   MicroSac y IniTerSac creadas por Christ Devia, basadas en los
%   documentos de Engbert 2006 y Engbert 2003 para la generación de
%   microsacadas.
%   
%   For information about the possible uses of these outputs
%   SEE ALSO event2steps getDataFromTo
%
%   Toolbox 
%   Laboratorio Neurosistemas
%   Samuel Madariaga & Kristofher Muñoz
%   Versión 1.0
%   23.09.2014

function output = getMicrosaccEvent(fixL,fixR,time,data)

    addpath Internal

    ones1 = event2steps(fixL,time);
    ones2 = event2steps(fixR,time);
    ones = ones1.*ones2;
    
    microTimes = IniTerSac(ones,time);

    microsacc.startTimes = [];
    microsacc.endTimes = [];
    
    for i = 1:length(microTimes)
                
        auxData = getDataFromTo(microTimes(i,1),microTimes(i,2),data);
        
        auxMicrosacc = MicroSac(auxData);
        
        microsacc.startTimes = [microsacc.startTimes;auxMicrosacc(:,1)];
        microsacc.endTimes = [microsacc.endTimes;auxMicrosacc(:,2)];
        
    end

    output = microsacc;
    
end

    