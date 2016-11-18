%Script para pruebas de clasificaci贸n Taller No 3. Asignatura Simulaci贸n de
%Sistemas, Dpto. Ingenier铆a de Sistemas, Universidad de Antioquia.

load('Data.mat');
M = 6;
disp(Data(1,1));
%Separaci贸n de caracter铆sticas y variables a predecir
X = Data(:,1:6);
Y = Data(:,end);
%--------------------------------------------------------------------------
Nd = size(X,1); % N煤mero de muestras en la base de datos
Nc = length(unique(Y)); %N煤mero de clases
Rept = 10;
ErrorTest = zeros(1,Rept);

MatrizConfusionAcumulada = zeros(Nc,Nc);
cv = cvpartition(Nd,'Kfold',Rept); %Generaci贸n de folds para crossvalidation
for fold = 1:Rept
    %Separaci贸n de los conjuntos de entrenamiento y validaci贸n
    Xtrain = X(cv.training(fold),:);
    Xtest = X(cv.test(fold),:);
    Ytrain = Y(cv.training(fold));
    Ytest = Y(cv.test(fold));
    %----------------------------------------------------------------------
    %------------- Normalizaci贸n ------------------------------------------
    [XtrainN,mu,sigma] = zscore(Xtrain);
    XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
    %----------------------------------------------------------------------
    %------------- Entrenamiento ------------------------------------------
    
    Modelo = EntrenarAD(X,Y);
    %disp('MODELO: ');
    %disp(Modelo.Clase(1).mix)
    %disp('--------------------');
    %----------------------------------------------------------------------
    %------------- Validaci贸n
    %---------------------------------------------
    Yest = ValidarAD(Modelo,XtestN);
    %disp('VALIDACION: ');
    %disp(Yest');
    %disp('--------------------');
   %-----------------------------------------------------------------------
   %-------------- C谩lculo del error --------------------------------------
   MatrizConfusion = zeros(Nc,Nc);
   for i=1:size(Xtest,1)
       MatrizConfusion(Yest(i),Ytest(i)) = MatrizConfusion(Yest(i),Ytest(i)) + 1;
   end
   disp('Matriz de confusi髇: ');
   disp(MatrizConfusion);
   MatrizConfusionAcumulada = MatrizConfusionAcumulada + MatrizConfusion;
   disp('--------------------');
   
   EfiTest(fold) = sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));
end
disp('Matriz de confusi髇 acumulada: ');
disp('--------------------');
disp(MatrizConfusionAcumulada);
Efi = mean(EfiTest);
IC = std(EfiTest);
disp('El error obtenido fue = ');
disp(num2str(1-Efi));
disp(' +- ');
disp(num2str(IC));
    