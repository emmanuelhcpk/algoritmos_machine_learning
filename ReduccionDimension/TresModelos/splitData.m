function [ Xtrain , Ytrain, Xtest, Ytest, totalTrain, total] = splitData( Group, percentage )
%UNTITLED Summary of this function goes here
%   Funcion para realizar bootstrap sobre las muestras

    %tamano total X
    totalDatos = size(Group,1);
    totalTrain = (totalDatos*percentage)/100;
    totalTest = totalDatos - totalTrain;
    % Total variables X
    var = size(Group,2) - 1;
    % Se crean indices aleatorios sin repeticion de 1 hasta el total de las
    % muestras
    indexTrain= randperm(totalDatos);
  
    train = floor(totalTrain);

    
    Xtrain = Group(indexTrain(1:train),1:var);
    Ytrain = Group(indexTrain(1:train),var+1);
        
    Xtest = Group(indexTrain(train:end),1:var);
    Ytest = Group(indexTrain(train:end),var+1);
end

