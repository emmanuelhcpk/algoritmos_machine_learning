% %--------------------------------SMOTE-----------------------------------
% Smote es el algoritmo para sobre muestrear la clase minoritaria, en
% nuesto caso la clase 2
% %--------------------------------------------------------------------------

%ahora seleccionas el numero de muestras minoritarias
datos= german_data(german_data(:,end) == 2, :); %ya se que son los que tienen 2 

%separamos x y y
% lo valores de entrada x 
x = datos(:, 1:end-1);
y = datos(:,end);
% los valores de salida en este caso la clase a que pertenece (1 y 2)

%llamo el algoritmo, le enviamos como parametros, las clases minoritarias
%X, el porcetaje N% que hace referencia a la cantidad de smote que se
%quiere realizar y el numero de vecinos a evaluar K. El algoritmo me
%devolvera nuevas muestras de la clase minoritaria creadas sinteticamente,
%el numero de muestras sera (N/100) * T
sobreClase2= smote(x, 63.6, 7); %5864 MUESTRAS NUEVAS
%muestras de la clase minoritaria combinadas con las nuevas muestras;
x = sobreClase2;
%-------------------------------------------------------------------------
%Número de atributos
D = size(x,2);
%------------------------------------------------------------------------
%armo de nuevo el conjunto de datos
x = [x ones(size(x,1),1)*2];
datosNewSobre = x;

%--------------------------------------------------------------------------
%subplot(1,3,2)
%tem = datosNewSobre(datosNewSobre(:,end) == 1, 1:2);
%plot(tem(:,1),tem(:,2),'xb');
%hold on
%tem = datosNewSobre(datosNewSobre(:,end) == 0, 1:2);
%plot(tem(:,1),tem(:,2),'xr');
%title('Over-Sampled Dataset')
%--------------------------------------------------------------------------


%-------------------------UNDER-SAMPLING----------------------------------


% los valores de salida en este caso la clase a que pertenece (0 y 1)
datos = [german_data;datosNewSobre];
x = datos(:, 1:end-1);
y = datos(:,end);

D = size(x,2);
%para el uso de submuestreo inteligente se uso una libreria ya construida,
%para ello se usa la funcion underSamplig del CSNN, se le entrega como
%parametro, el conjunto de datos x, su salida y, las clases, la relacion de
%salida, y un vector que indica si los datos son numericos o discretos 
%(0 para numericos), entrega como salida el conjunto de los nuevos datos (x,y)

[newTrain,newTrainLabel]=UnderSampling(x',y',[1 2],[2 2],zeros(1,D));
DatosBalanceados= [newTrain' newTrainLabel']; %nuevos datos
%--------------------------------------------------------------------------


%subplot(1,3,3)
%tem = datosNewSub(datosNewSub(:,end) == 1, 1:2);
%plot(tem(:,1),tem(:,2),'xb');
%hold on
%tem = datosNewSub(datosNewSub(:,end) == 0, 1:2);
%plot(tem(:,1),tem(:,2),'xr');
%title('Over and Under - Sampled Dataset')
%--------------------------------------------------------------------------

