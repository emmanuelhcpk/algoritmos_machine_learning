function [Matriz,SVM1,SVM2,SVM3] = SVMWorkLineal(Xtrain,Ytrain,Xval,Constraint)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes her
    Ttrain1 = Partion(Ytrain,1); %nuevas muestras para entrenar del primer clasificador
    SVM1 = svmtrain(Xtrain,Ttrain1,'boxconstraint',Constraint,'kernel_function','linear');
    Yest1 = svmclassify(SVM1,Xval);
    
    Ttrain2 = Partion(Ytrain,2); %nuevas muestras para entrenar del primer clasificador
    SVM2 = svmtrain(Xtrain,Ttrain2,'boxconstraint',Constraint,'kernel_function','linear');
    Yest2 = svmclassify(SVM2,Xval);
    
    Ttrain3 = Partion(Ytrain,3); %nuevas muestras para entrenar del primer clasificador
    SVM3 = svmtrain(Xtrain,Ttrain3,'boxconstraint',Constraint,'kernel_function','linear');
    Yest3 = svmclassify(SVM3,Xval);
    
    Matriz = [Yest1,Yest2,Yest3];
end

