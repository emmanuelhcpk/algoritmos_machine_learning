function [ Error ,IC , sensi , especi, presi ]  = TreeBagger_Dimension( XtrainN , Ytrain ,XtestN,Ytest ,  iteraciones,NumArboles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%--------------------------------------------------------------------------

Rept = iteraciones;
EfiTest= zeros(1, Rept);
sensibTest= zeros(1, Rept);
especifi= zeros(1, Rept);
Pres = zeros(1,Rept);

X = [XtrainN;XtestN];
Y = [Ytrain;Ytest];
muestras = [X,Y];

for fold = 1:Rept
    %Separación de los conjuntos de entrenamiento y validación
    [ XtrainN , Ytrain, XtestN, Ytest] = splitData(muestras,70);
    %----------------------------------------------------------------------
    %------------- Normalización ------------------------------------------
%     [XtrainN,mu,sigma] = zscore(Xtrain);
%     XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
    %----------------------------------------------------------------------
    %------------- Entrenamiento ------------------------------------------  
    perm = randperm(5);
    Modelo = TreeBagger(NumArboles, XtrainN, Ytrain, 'oobpred', 'on','NVarToSample',perm(3));     % Obteniendo �r.

     %----------------------------------------------------------------------
    %------------- Validaci�n ---------------------------------------------
    Yest = predict(Modelo, XtestN);        % Invocaci�n a la validaci�n.
    Yest = convertcell2double(Yest);            % M�todo de utilidad.
    
   MatrizConfusion = zeros(2,2);
   for i=1:size(XtestN,1)
     MatrizConfusion(Yest(i),Ytest(i)) = MatrizConfusion(Yest(i),Ytest(i)) + 1;
   end
   EfiTest(fold) = sum(diag(MatrizConfusion))/sum(sum(MatrizConfusion));
   sensibTest(fold) = (MatrizConfusion(1,1)/sum(MatrizConfusion(1,1)+MatrizConfusion(2,1)));
   especifi(fold) = (MatrizConfusion(2,2)/sum(MatrizConfusion(2,2)+MatrizConfusion(1,2)));
   Pres(fold) = MatrizConfusion(1,1) / ( (MatrizConfusion(1,1) +MatrizConfusion(1,2)));

end

Error = 1 - mean(EfiTest);
IC = std(EfiTest);
sensi = mean(sensibTest);
especi = mean (especifi);
presi = mean(Pres);


end

