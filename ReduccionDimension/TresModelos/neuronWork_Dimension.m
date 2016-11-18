function [error,IC, sensibilidad, especificidad, presicion] = neuronWork_Dimension( XtrainN , Ytrain ,XtestN,Ytest,Npeceptrons,flag)

%                     P = XtrainN';
%                     T = Ytrain';
%                     Xval = XvalN';           
%                     Yval = Yval';
%                     Nc = 2;
                    X = [XtrainN;XtestN];
                    Y = [Ytrain;Ytest];
                    Data = [X,Y];
                    [ XtrainN , Ytrain, XtestN, Ytest] = splitData(Data,70);
                    %----------------------------------------------------------------------
                    %------------- Normalización ------------------------------------------
%                     [XtrainN,mu,sigma] = zscore(Xtrain);
%                     XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
                    
                    P = XtrainN';
                    T = Ytrain';
                    Xval = XtestN';           
                    Yval = Ytest';
                    Nc = 2;                    
                    
                    

                    net = newpr(P,T,Npeceptrons,{'logsig','logsig'},'trainbfg');
                    net.trainParam.epochs = 50;


                    [netT,tr] = train(net,P,T);

                    Yest = sim(netT,Xval);
                    
                    %Se debe redondiar el valor
                    Yest = round(Yest);
                    
                    %%Aqui va es la matriz de confusion para una eficiencia
%                     [eficiencia, sensibilidad, especificidad] = matrizConfusion(Nc,Yest', Yval')
                    
                    matrizConfusion = zeros(2,2);
                    Ytest = Ytest';
                    Yest = Yest';
                    
                    for i=1:size(Yest,1)
                         matrizConfusion(Yest(i),Ytest(i)) =  matrizConfusion(Yest(i),Ytest(i)) + 1;
                    end
                    
                    error = 1 - (sum(diag(matrizConfusion)))/sum(matrizConfusion(:));
                    IC = 0;
                    sensibilidad = (matrizConfusion(1,1)/sum(matrizConfusion(1,1)+matrizConfusion(1,2)));
                    especificidad = (matrizConfusion(2,2)/sum(matrizConfusion(2,2)+matrizConfusion(2,1)));
                    presicion = matrizConfusion(1,1) /(matrizConfusion(1,1)+matrizConfusion(1,2));
                    
                                        %Parametro para visualizar la red
%                     if(flag == 1)
%                         view(net)                        
%                     end    
end