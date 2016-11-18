function  [ error ,IC , sensin , especifi,Precision ]  = SVM_Lineal( XtrainN , Ytrain ,XtestN,Ytest , C_kernel , iteraciones )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

vectorEficiencia = zeros(iteraciones,1);
vectorSensi = zeros(iteraciones,1);
vectorEspe = zeros(iteraciones,1);
vectorPres = zeros(iteraciones,1);
C = C_kernel;
X = [XtrainN;XtestN];
Y = [Ytrain;Ytest];
muestras = [X,Y];


    for itera = 1:iteraciones
            % Validacion Bootstrap, se separan aleatoriamente loa datos en 70-30
            [XtrainN,Ytrain,XtestN,Ytest] = splitData(muestras,70);

            %Normalizamos conjuntos de entrenamiento
%             [XtrainN,mu,sigma] = zscore(Xtrain);
%             XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
       
            matrizConfusion = zeros(2,2);

            % ------------------------ENTRENAMIENTO-----------------------------------%
            %Modelos SVM para clasificacion one vs all
          %  modeloSVM = svmtrain(XtrainN,Ytrain,'boxconstraint',vectorC(c),'kernel_function','linear');
            options.MaxIter = 100000;
             modeloSVM = svmtrain(XtrainN,Ytrain,'Options',options,'boxconstraint',100,'kernel_function','rbf','rbf_sigma',10);
%             modeloSVM = svmtrain(XtrainN,Ytrain,'Options',options,'boxconstraint',C_kernel,'kernel_function','linear');

            % ------------------------VALIDACION------------------------------------- %
            clasifica = svmclassify(modeloSVM,XtestN);
          % Muestra la clasificiacion realizada por cada SVM contra el Y real
           desicion = clasifica;
           Yest = desicion;

           for i=1:size(Yest,1)
                   matrizConfusion(Yest(i),Ytest(i)) =  matrizConfusion(Yest(i),Ytest(i)) + 1;
           end

    vectorEficiencia(itera) = (sum(diag(matrizConfusion)))/sum(matrizConfusion(:));
    vectorSensi(itera) = (matrizConfusion(1,1)/sum(matrizConfusion(1,1)+matrizConfusion(1,2)));
    vectorEspe(itera) = (matrizConfusion(2,2)/sum(matrizConfusion(2,2)+matrizConfusion(2,1)));
    vectorPres(itera) = matrizConfusion(1,1) /(matrizConfusion(1,1)+matrizConfusion(1,2));
 
 
    end
    error = 1- mean(vectorEficiencia);
    IC = std(vectorEficiencia);
    sensin = mean(vectorSensi);
    especifi = mean(vectorEspe);
    Precision = mean(vectorPres);
    
    
end