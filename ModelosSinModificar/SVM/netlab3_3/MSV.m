clear all
clc
load('XData');
load('YData');

   vectorC = [1,10]; %Vector parametro C
 
   Nc = max(Y);
   CN = size(vectorC,2);
   %CelParametros = {20}; %Celda para almacenar los resultados de los parametros
   %Celparametros = {};
   CelParametros =zeros(CN,1);
   %parametros =zeros(CN,HN);
   CelParam =zeros(CN,1);
   CelIntervalos=zeros(CN,1);
   VectorEfi = zeros(CN,1);
   VectorError = zeros(CN,1);
   IntervaloConfi = zeros(CN,1);
   eficienciaParcial = size(10,1);
   %Crear la primera particion de datos obteniendo porcentajes iguales
   %Por clase

    
   %%Ciclo para regularizacion
   for  c = 1:CN
    
       for  iter=1:10
                  %Se crea la segunda particion 
                  % [XtrainM,YtrainM,Xval,Yval] = ClasifierData(XtrainG,YtrainG);
                  [XtrainG,YtrainG,Xtest,Ytest] = ClasifierData(X,Y);
                
                   %Normalizamos conjuntos de entrenamiento
                  [XtrainGN,mu,sigma] = zscore(XtrainG);
                  XvalGN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);

                   %Se realizar el proceso de entrenamiento y validacion por
                   %cada clase
                   %SVM[Matriz,1,SVM2,SVM3] = SVMWork(XtrainMN,YtrainM,XvalN,vectorC(c),vectorH(h));
                  %[Matriz,SVM1,SVM2,SVM3]=SVMWork(XtrainGN,YtrainG,XvalGN,vectorC(c),vectorH(h));
                  [Matriz,SVM1,SVM2,SVM3]=SVMWorkLineal(XtrainGN,YtrainG,XvalGN,vectorC(c));

                   %Se determina el Yest general tomando la distancia cuando el
                   %hay indeterminacion de clases
                  % Yest = determination(SVM1,SVM2,SVM3,XvalN,Matriz,vectorH(h));
                  Yest = determination_lin(SVM1,SVM2,SVM3,XvalGN,Matriz);

               MatrizConfusion = zeros(Nc,Nc);
                for i=1:size(XvalGN,1)
                    MatrizConfusion(Yest(i),Ytest(i)) = MatrizConfusion(Yest(i),Ytest(i)) + 1;
                end
                Eficiencia = (sum(diag(MatrizConfusion)))/sum(MatrizConfusion(:));
                eficienciaParcial(iter) = Eficiencia;
                
               
       end  
        VectorEfi(c,1) = mean(eficienciaParcial);
        VectorError(c,1) = 1-mean(eficienciaParcial);
        IntervaloConfi(c,1) = std(eficienciaParcial);
       
   end 
   disp('error');
   disp(VectorError);
   disp('Eficiencia');
   disp(VectorEfi);
   disp('IC +-');
   disp(IntervaloConfi);