% Recibe vector de 1 y 0 que indican si la velocidad esta dentro o fuera de
% la elipse de microsac.
% Entrega el tiempo de microsac en mseg considerando cero el tiempo del
% primer sample de velocidad.

function IniTer = IniTerSac(vec,tpo)

if ~isempty(vec) && ~isempty(tpo)
    Dife = diff(vec); 
    if vec(1) == 1 && vec(end) == 1 % Inicia y termina en microsac
        Inis = find(Dife>0)+1;
        Ters = find(Dife<0);
        IniTer = [[tpo(1);tpo(Inis)],[tpo(Ters);tpo(end)]];
    elseif vec(1) == 1 && vec(end) == 0 % Inicia en microsac
        Inis = find(Dife>0)+1;
        Ters = find(Dife<0);
        IniTer = [[tpo(1);tpo(Inis)],[tpo(Ters)]];
    elseif vec(1) == 0 && vec(end) == 1 % Termina en microsac
        Inis = find(Dife>0)+1;
        Ters = find(Dife<0);
        IniTer = [[tpo(Inis)],[tpo(Ters);tpo(end)]];
    else % Ninguna de las anteriores
        Inis = find(Dife>0)+1;
        Ters = find(Dife<0);
        IniTer = [[tpo(Inis)],[tpo(Ters)]];
    end
else
    IniTer = [];
end



% Version antigua, usada hasta el 23.09.2012
% for pk = 1:1:size(Dife,1)
%     if Dife(pk)==1 && estado1==0 % Inicio normal
%         estado1 = 1;
%         Inis(nIni) = tpo(pk+1);
%         nIni = nIni+1;
%     elseif Dife(pk)==1 && estado1==1 % Error dos inicios juntos
%         % disp(['Dos inicios juntos. El primero en ' num2str(Inis(nIni-1)) ', siguiente en ' num2str(tpo(pk+1)) '.'])
%         estado1 = 1;
%         % Se queda con el segundo inicio
%         Inis(nIni-1) = tpo(pk+1);
%     elseif Dife(pk)==-1 && estado1==1 % Termino normal
%         estado1 = 0;
%         Ters(nTer) = tpo(pk);
%         nTer = nTer+1;
%     elseif Dife(pk)==-1 && estado1==0 % Termino al comienzo
%         Ters(nTer) = tpo(pk);
%         nTer = nTer+1;
%         Inis(nIni) = tpo(1);
%         nIni = nIni+1;
%         % disp(['Inicio con microsacada, terminada en ' num2str(tpo(pk))])
%     end
% end
% if estado1 == 1
%     % disp(['Termino en microsacada.'])
%     estado1 = 0;
%     Ters(nTer) = tpo(end);
%     nTer = nTer+1;
% end
% IniTer = [Inis(1:nIni-1),Ters(1:nTer-1)]; 
