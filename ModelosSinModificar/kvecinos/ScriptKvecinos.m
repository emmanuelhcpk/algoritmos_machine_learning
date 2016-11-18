%Script para pruebas de clasificación Taller No 3. Asignatura Simulación de
%Sistemas, Dpto. Ingeniería de Sistemas, Universidad de Antioquia.

Data = DatosBalanceados;
%Separa
%Separación de características y variables a predecir

%--------------------------------------------------------------------------
Nd = size(X,1); % Número de muestras en la base de datos
Ntr = ceil(Nd*0.7); % Número de muestras de entrenamiento
Nc = size(unique(Y),1); %Número de clases
Rept = 10;
K= 20;
EfiTest= zeros(1, Rept);
sensibTest= zeros(1, Rept);
especifi= zeros(1, Rept);
ErrorTest = zeros(1,Rept);
time= tic;
for fold = 1:Rept
    %Separación de los conjuntos de entrenamiento y validación
    [ Xtrain , Ytrain, Xtest, Ytest, totalTrain, totalTest] = splitData(Data,70);
    %----------------------------------------------------------------------
    %------------- Normalización ------------------------------------------
    [XtrainN,mu,sigma] = zscore(Xtrain);
    XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
    %----------------------------------------------------------------------
    %------------- Entrenamiento ------------------------------------------
    time= tic;
    Yest = KNeighbors(XtrainN,Ytrain,XtestN,Ytest,7,0);
    toc(time);
    %----------------------------------------------------------------------
    %------------- Validación ---------------------------------------------
    
    %Yest = ValidarGMM(Modelo,XtestN);
    
   %-----------------------------------------------------------------------
   %-------------- Cálculo del error --------------------------------------
   time= tic;
   MatrizConfusion = zeros(Nc,Nc);
   for i=1:size(Xtest,1)
     MatrizConfusion(Yest(i),Ytest(i)) = MatrizConfusion(Yest(i),Ytest(i)) + 1;
   end
   EfiTest(fold) = sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));
   sensibTest(fold) = (MatrizConfusion(1,1)/sum(MatrizConfusion(1,1)+MatrizConfusion(2,1)));
    especifi(fold) = (MatrizConfusion(2,2)/sum(MatrizConfusion(2,2)+MatrizConfusion(1,2)));
    toc(time);
end
Efi = mean(EfiTest);
sensi = mean(sensibTest);
IcSensi = std(sensibTest); 
IC = std(EfiTest);
especi = mean (especifi);
IcEspe = std(especifi);

toc(time);
fprintf('El error obtenido fue = %3.3f  +- %3.3f \n ', 1-Efi,IC);
fprintf('La sensibilidad obtenida = %3.3f +- %3.3f \n ', sensi,IcSensi);
fprintf('La especificidad obtenida = %3.3f +- %3.3f \n ', especi,IcEspe);

    