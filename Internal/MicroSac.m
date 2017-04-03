% Recibe los smaples dentro de una fijacion y los analiza para detectar si
% hay una microsac en ellos.
%
% Llamada por MicroSac_xSuj
%
% Entrega el inicio y termino de microsac.
% 
% Engbert 2006 y Engbert 2003


function outout = MicroSac(SAM)

% disp('======> func MicroSac')

% 00) Variables
% SAM % Arreglo con solo los samples del asc formato
%  1     2   3     4    5     6    7    8     9     10    11   12    13
% tpo posxL poyL diaL posxR poyR diaR velxL velyL velxR velyR resx resy
posxR = SAM(:,5);
posyR = SAM(:,6);
posxL = SAM(:,2);
posyL = SAM(:,3);
lambda = 6; % 6 en Martinez-Conde 2012 (SfN); 5 en Engber 2006

% 10) Calculo de velocidad
% velxR = (posxR(5:end)+posxR(4:end-1)-posxR(2:end-3)-posxR(1:end-4))/(6*2e-3); % el delta en ms?????
% velyR = (posyR(5:end)+posyR(4:end-1)-posyR(2:end-3)-posyR(1:end-4))/(6*2e-3);
% 
% velxL = (posxL(5:end)+posxL(4:end-1)-posxL(2:end-3)-posxL(1:end-4))/(6*2e-3); % el delta en ms?????
% velyL = (posyL(5:end)+posyL(4:end-1)-posyL(2:end-3)-posyL(1:end-4))/(6*2e-3);

velxR = filter([1/3,1/3,1/3],1,SAM(:,10));
velyR = filter([1/3,1/3,1/3],1,SAM(:,11));
velxL = filter([1/3,1/3,1/3],1,SAM(:,8));
velyL = filter([1/3,1/3,1/3],1,SAM(:,9));

% Revisar, problemas por calibración
velxR = velxR(~isnan(velxR));
velyR = velyR(~isnan(velyR));
velxL = velxL(~isnan(velxL));
velyL = velyL(~isnan(velyL));

% 20) Estimacion del ruido
sigxR = sqrt(median(velxR.^2)-median(velxR)^2);
sigyR = sqrt(median(velyR.^2)-median(velyR)^2);
% disp(['Desviacion estandar en X: ' num2str(sigxR) ' DER'])
% disp(['Desviacion estandar en Y: ' num2str(sigyR) ' DER'])
sigxL = sqrt(median(velxL.^2)-median(velxL)^2);
sigyL = sqrt(median(velyL.^2)-median(velyL)^2);
% disp(['Desviacion estandar en X: ' num2str(sigxL) ' IZQ'])
% disp(['Desviacion estandar en Y: ' num2str(sigyL) ' IZQ'])
% disp(['Ruido estimado ojo derecho ' num2str(sigxR) ', ' num2str(sigyR) ', ' num2str(sigxL) ', ' num2str(sigyL)])
 
% 21) Umbral de microsaccada
etaxR = lambda*sigxR;
etayR = lambda*sigyR;
% disp(['Umbral de deteccion en X: ' num2str(etaxR) ' DER'])
% disp(['Umbral de deteccion en Y: ' num2str(etayR) ' DER'])
etaxL = lambda*sigxL;
etayL = lambda*sigyL;
% disp(['Umbral de deteccion en X: ' num2str(etaxL) ' IZQ'])
% disp(['Umbral de deteccion en Y: ' num2str(etayL) ' IZQ'])

% 22) Elipse de velocidad para las microsaccadas
aux = (velxR./etaxR).^2 + (velyR./etayR).^2;
posiR = 1*(aux>1);
% tposR = SAM(3:end-2,1);
tposR = SAM(:,1);
MiSacR = IniTerSac(posiR,tposR);

aux = (velxL./etaxL).^2 + (velyL./etayL).^2;
posiL = 1*(aux>1);
% tposL = SAM(3:end-2,1);
tposL = SAM(:,1);
MiSacL = IniTerSac(posiL,tposL);

% 30) Cut-off de microSac >6ms
duraR = [];
duraL =[];
try
    duraR = MiSacR(:,2)-MiSacR(:,1);
end
    MiSacR2 = MiSacR(duraR>6,:);
% disp(['Total microsacadas ojo derecho: ' num2str(size(MiSacR2,1))])
try
    duraL = MiSacL(:,2)-MiSacL(:,1);
end
    MiSacL2 = MiSacL(duraL>6,:);
% disp(['Total microsacadas ojo izquierdo: ' num2str(size(MiSacL2,1))])

% 40) Microsacadas binoculares
aa = size(MiSacR2,1);
bb = size(MiSacL2,1);
MiSacBi = zeros(max([aa,bb]),4); % IniR, TerR, IniL, TerL
MiSacBi2 = zeros(max([aa,bb]),2); % IniR, TerR, IniL, TerL
con = 1;
unos = ones(bb,1);

for ik =1:1:aa
    % Toma una microsac (unos*MiSacR2)
    aux = [unos*MiSacR2(ik,1),unos*MiSacR2(ik,2)];
    % Reglas
    Re1 = aux(:,2)-MiSacL2(:,1); % r2>l1 --> r2-l1>0
    Re2 = MiSacL2(:,2)-aux(:,1); % r1<l2 --> 0<l2-r1
    out = find(Re1>0 & Re2>0);
    if ~isempty(out)
        if length(out)==1
            MiSacBi(con,:) = [MiSacL2(out,:),MiSacR2(ik,:)];
            MiSacBi2(con,1) = min(MiSacL2(out,1),MiSacR2(ik,1));
            MiSacBi2(con,2) = max(MiSacL2(out,2),MiSacR2(ik,2));
            con = con+1;
        elseif length(out)>1
            MiSacBi(con,1) = MiSacL2(out(1),1);
            MiSacBi(con,2) = MiSacL2(out(end),2);
            MiSacBi(con,3) = MiSacR2(ik,1);
            MiSacBi(con,4) = MiSacR2(ik,2);
            MiSacBi2(con,1) = min(MiSacBi(con,1),MiSacBi(con,3));
            MiSacBi2(con,2) = max(MiSacBi(con,2),MiSacBi(con,4));
            con = con+1;
        %    disp(['Error doble sacada: ' num2str(MiSacBi(con-1,:))])
        end
    end
    
end
% MiSacBi = MiSacBi(1:con-1,:);
outout = MiSacBi2(1:con-1,:);