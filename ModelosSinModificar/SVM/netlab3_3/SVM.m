
function SVM
   clear all
   clc
   %load('Data');
   load('XData');
   load('YData');
   
   
   %vectorH = [0.001,0.01,0.1,1,10]; %vector parametro sigma
   %vectorC = [1,10,100,1000]; %Vector parametro C
   vectorC = [1 10 100 1000]; 
   vectorH =  [0.001 0.01 0.1 1 10];
   
    
   Nd = size(X,1); % Número de muestras en la base de datos
   Nc = max(Y);
   CN = size(vectorC,2);
   HN = size(vectorH,2);
   eficienciaParcial = size(10,1);
   VectorEfi = zeros(CN,HN);
   VectorError = zeros(CN,HN);
   IntervaloConfi = zeros(CN,HN);
   %Crear la primera particion de datos obteniendo porcentajes iguales
   %Por clase
     %Generación de folds para crossvalidation
    
   %%Ciclo para regularizacion
   for c = 1:CN
       for h =1:HN
           
           %VectorError = 0;
           %Iteraciones definidas para el parametro
           
           for iter=1:10
                  
                  %[XtrainG,YtrainG,Xtest,Ytest] = ClasifierData(X,Y);
                  %Separación de los conjuntos de entrenamiento y validación
                      cv = cvpartition(Nd,'Kfold',10);
                      XtrainG = X(cv.training(iter),:);
                      Xtest = X(cv.test(iter),:);
                      YtrainG = Y(cv.training(iter));
                      Ytest = Y(cv.test(iter));
                  
                   %Normalizamos conjuntos de entrenamiento
                  [XtrainGN,mu,sigma] = zscore(XtrainG);
                  XvalGN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);

                   %Se realizar el proceso de entrenamiento y validacion por
                   %cada clase
                   %SVM[Matriz,1,SVM2,SVM3] = SVMWork(XtrainMN,YtrainM,XvalN,vectorC(c),vectorH(h));
                  [Matriz,SVM1,SVM2,SVM3]=SVMWork(XtrainGN,YtrainG,XvalGN,vectorC(c),vectorH(h));

                   %Se determina el Yest general tomando la distancia cuando el
                   %hay indeterminacion de clases
                  % Yest = determination(SVM1,SVM2,SVM3,XvalN,Matriz,vectorH(h));
                  Yest = determination(SVM1,SVM2,SVM3,XvalGN,Matriz,vectorH(h));

               MatrizConfusion = zeros(Nc,Nc);
                for i=1:size(XvalGN,1)
                    MatrizConfusion(Yest(i),Ytest(i)) = MatrizConfusion(Yest(i),Ytest(i)) + 1;
                end
%                 disp('Matriz');
%                 disp(MatrizConfusion);
                Eficiencia = (sum(diag(MatrizConfusion)))/sum(MatrizConfusion(:));
                eficienciaParcial(iter) = Eficiencia;
           end 
           VectorEfi(c,h) = mean(eficienciaParcial);
           VectorError(c,h) = 1-(mean(eficienciaParcial));
           IntervaloConfi(c,h) = std(eficienciaParcial);
       end    
        
   end 
   disp('error');
   disp(VectorError);
   disp('Eficiencia');
   disp(VectorEfi);
   disp('IC +-');
   disp(IntervaloConfi);
   
   %%Reentrenar y sacar con test los datos finales
   %%Normalizamos
   
   %Mejores valores de los parametros
   [Ci,Hi] = BestSVM(VectorEfi);
   
   %Entrenamiento y validacion final
   [MatrizFinal,SVM1,SVM2,SVM3] = SVMWork(XtrainGN,YtrainG,XvalGN,vectorC(Ci),vectorH(Hi));
   
   Yest = determination(SVM1,SVM2,SVM3,XvalGN,MatrizFinal,vectorH(Hi));

   
   %Calculo de eficiencia final            
   MatrizConfusion = zeros(Nc,Nc);
       for i=1:size(XvalGN,1)
            MatrizConfusion(Yest(i),Ytest(i)) = MatrizConfusion(Yest(i),Ytest(i)) + 1;
            Eficiencia = (sum(diag(MatrizConfusion)))/sum(MatrizConfusion(:)); %preguntar para que esos dos puntos
            
       end
   
   disp(strcat('Error final = ',num2str(1-Eficiencia),'; con valores Ci=  ',num2str(vectorC(Ci)),'; con valores Hi =',num2str(vectorH(Hi))));   

   
   
   
  