clc;

numComp = [3 6 9 12 15 18 21 24];
% 1 : SVM
% 2 : TreeBagger
% 3 :NeuralNetwork
eleccion = 1; 

iters = 10;
err = zeros(iters,1);
interCerr = zeros(iters,1);
sensi = zeros(iters,1);
especi = zeros(iters,1);
presi = zeros(iters,1);
bestPCAs = struct('errorTrain', 0,'IC_train',0, 'errorTest', 0,'IC_test',0, 'NC', 0, ...
    'sen',0,'esp',0,'pres', 0);
muestras = DatosBalanceados;

for nc = 1:size(numComp, 2)
    [Xtrain, Ytrain, Xtest, Ytest] = splitData(muestras, 70);

    structForK = struct('errorTrain', 0,'IC_train',0, 'errorTest', 0,'IC_test',0, 'NC', 0, ...
    'sen',0,'IC_sen',0,'esp',0,'IC_esp',0,'pres', 0,'IC_pres',0);
    error = 0;
    
    for i = 1:iters
        [Xtrainnew, Ytrainnew, Xval, Yval] = splitData([Xtrain,Ytrain],70);

        [Xtrainnew, means, stds] = zscore(Xtrainnew);
        model = pca(Xtrainnew', numComp(1, nc));
        Xmodel = linproj(Xtrainnew', model);

        Xval = normalize(Xval, means, stds);
        Xval = linproj(Xval', model);
                

        switch eleccion
        case 1
            [error ,IC, sen , esp, pres  ] = SVM_Lineal(Xmodel', Ytrainnew, Xval', Yval,1,1);
        case 2
            [error ,IC, sen , esp, pres  ] = TreeBagger_Dimension(Xmodel', Ytrainnew, Xval', Yval,1,40);
        case 3
            [error ,IC, sen , esp, pres  ] =  neuronWork_Dimension(Xmodel', Ytrainnew, Xval', Yval,2,1);
        end
%        error = error + functionKN(Xmodel', Ytrainnew, Xval', Yval);
%        [error ,IC, sen , esp, pres  ] = SVM_Lineal(Xmodel', Ytrainnew, Xval', Yval,1,1);
%        [error ,IC, sen , esp, pres  ] = TreeBagger_Dimension(Xmodel', Ytrainnew, Xval', Yval,1,40);
%          [error ,IC, sen , esp, pres  ] =  neuronWork_Dimension(Xmodel', Ytrainnew, Xval', Yval,2,1);
%         fprintf('Error: %f - IC: %f - Sensi: %f - Espe: %f - Presi: %f NC: %d\n', error,IC,sen,esp,pres, numComp(1, nc));
        
        err(i) = error;
        sensi(i) =  sen;
        especi(i) = esp;
        presi(i) = pres;
    end
    
    structForK(nc).error = mean(err);
    structForK(nc).IC_train  = std(err);
    structForK(nc).NC = numComp(1, nc);
    structForK(nc).sen = mean(sensi);
    structForK(nc).IC_sen = std(sensi);
    structForK(nc).esp = mean(especi);
    structForK(nc).IC_esp = std(especi);
    structForK(nc).pres = mean(presi);
    structForK(nc).IC_pres = std(presi);
    
    structTemp = findbestpcastruct(structForK);
    bestPCAs(nc).errorTrain = structTemp.error;
    bestPCAs(nc).NC = structTemp.NC;
    bestPCAs(nc).IC_train = structTemp.IC_train;
    bestPCAs(nc).sen = structTemp.sen;
    bestPCAs(nc).IC_sen = structTemp.IC_sen;
    bestPCAs(nc).esp = structTemp.esp;
    bestPCAs(nc).IC_esp = structTemp.IC_esp;
    bestPCAs(nc).pres = structTemp.pres;
    bestPCAs(nc).IC_pres = structTemp.IC_pres;

%     [Xtrain, means, stds] = zscore(Xtrain);
%     Xtest = normalize(Xtest, means, stds);
% 
%     model = pca(Xtrain', bestPCAs(nc).NC);
%     Xmodel = linproj(Xtrain', model);
%     Xtest = linproj(Xtest', model);
%     
%     switch eleccion
%     case 1         
%     [ bestPCAs(nc).errorTest, bestPCAs(nc).IC_test,...
%         bestPCAs(nc).sen,bestPCAs(nc).esp,bestPCAs(nc).pres] = SVM_Lineal(Xmodel', Ytrain, Xtest', Ytest,1,10);
%     case 2
%     [ bestPCAs(nc).errorTest, bestPCAs(nc).IC_test,...
%         bestPCAs(nc).sen,bestPCAs(nc).esp,bestPCAs(nc).pres] = TreeBagger_Dimension(Xmodel', Ytrain, Xtest', Ytest,10,40); 
%     case 3
%     [ bestPCAs(nc).errorTest, bestPCAs(nc).IC_test,...
%         bestPCAs(nc).sen,bestPCAs(nc).esp,bestPCAs(nc).pres] = neuronWork_Dimension(Xmodel', Ytrain, Xtest', Ytest,40,1);
%     end  
%     

end
for nc = 1:size(numComp, 2)
    bestPCAs(nc)
 end
fprintf('END\n');
