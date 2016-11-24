clear all
close all
clc
load('datos.mat')
Rept=4;
NumMuestras=size(X,1);
punto=input('Pulse 1 para realizar Regresión Multiple, 2 para Regresión con ventana de Parzen: ');
matrizSinPotencia=X;
if(punto==1)
    eta=0.1; %%% Taza de aprendizaje
    grado=5; %%% Grado del polinomio
    for i=1:grado
  
        for fold=1:Rept

                %%% Se hace la partición de las muestras %%%
                %%%      de entrenamiento y prueba       %%%
                Xaux=potenciaPolinomio(X,grado);
                particion=cvpartition(NumMuestras,'Kfold',Rept);
                indices=particion.training(fold);
                Xtrain=Xaux(particion.training(fold),:);
                Xtest=Xaux(particion.test(fold),:);
                Ytrain=Y(particion.training(fold));
                Ytest=Y(particion.test(fold));
                %%Se normalizan los datos
                [Xtrain,mu,sigma]=zscore(Xtrain);
                Xtest=(Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
                %%% Se extienden las matrices %%%
                Xtrain=[Xtrain,ones(size(Xtrain,1),1)];
                Xtest=[Xtest,ones(size(Xtest,1),1)];

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %%% Se aplica la regresiï¿½n multiple %%%

                W=regresionMultiple(Xtrain,Ytrain,eta); %%% Se optienen los W coeficientes del polinomio

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %%% Se encuentra el error cuadratico medio %%%

                Yesti=(W'*Xtest')';
                Yesti=round(Yesti);
                Yesti(Yesti<0)=Yesti(Yesti<0).*-1;
                ECM(fold)=(sum((Yesti-Ytest).^2))/length(Ytest);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %%

        end
        errorCuadratico=mean(ECM);
        disp(num2str(i))
        Texto=['El Error cuadrï¿½tico medio en prueba es: ',num2str(errorCuadratico)];
        disp(Texto);
    end
elseif(punto==2)
    for h=[0.05 0.1 1 10];
        for fold=1:Rept
             particion=cvpartition(NumMuestras,'Kfold',Rept);
             indices=particion.training(fold);
             Xtrain=X(particion.training(fold),:);
             Xtest=X(particion.test(fold),:);
             Ytrain=Y(particion.training(fold));
             Ytest=Y(particion.test(fold));
             %%Se normalizan los datos
             [Xtrain,mu,sigma]=zscore(Xtrain);
             Xtest=(Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
             Yesti=ventanaParzen(Xtest,Xtrain,Ytrain,h,'regress');
             Yesti=round(Yesti);
             ECM(fold)=(sum((Yesti-Ytest).^2))/length(Ytest);
         end
         errorCuadratico=mean(ECM);
         disp(num2str(h))
         Texto=['El Error cuadrï¿½tico medio en prueba es: ',num2str(errorCuadratico)];
         disp(Texto);
         
    end
end