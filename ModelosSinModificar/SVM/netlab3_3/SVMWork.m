function [Matriz,SVM1,SVM2,SVM3] = SVMWork(Xtrain,Ytrain,Xval,Constraint,Sigma)

           %Por cada uno de las combinaciones solo para entrenamiento

           %Clasificador para clase 1 vs (2,3)
           Ttrain1 = Partion(Ytrain,1); %nuevas muestras para entrenar del primer clasificador
           SVM1 = svmtrain(Xtrain,Ttrain1,'kernel_function','rbf','rbf_sigma',Sigma,'boxconstraint',Constraint); %Entrena la primera combinacion
           Yest1 = svmclassify(SVM1,Xval); %Salida de la primera combinacion
           
    
           %Clasificador para clase 2 vs (1,3)
           Ttrain2 = Partion(Ytrain,2);
           SVM2 = svmtrain(Xtrain,Ttrain2,'kernel_function','rbf','rbf_sigma',Sigma,'boxconstraint',Constraint);
           Yest2 = svmclassify(SVM2,Xval);


           %Clasificador para clase 3 vs (1,2)
           Ttrain3 = Partion(Ytrain,3);
           SVM3 = svmtrain(Xtrain,Ttrain3,'kernel_function','rbf','rbf_sigma',Sigma,'boxconstraint',Constraint);
           Yest3 = svmclassify(SVM3,Xval);     
           
           Matriz = [Yest1,Yest2,Yest3];