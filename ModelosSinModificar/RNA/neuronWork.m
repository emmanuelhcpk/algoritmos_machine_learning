
%                     P = XtrainN';
%                     T = Ytrain';
%                     Xval = XvalN';           
%                     Yval = Yval';
%                     Nc = 2;

Npeceptrons = 40;
iter = 10;
eficiencia = zeros(10,1);
error = zeros(10,1);
sensibilidad = zeros(10,1);
especificidad = zeros(10,1);
presicion = zeros(10,1);
Data = DatosBalanceados;

for j = 1:iter

[ Xtrain , Ytrain, Xtest, Ytest] = splitData(Data,70);
%----------------------------------------------------------------------
%------------- Normalización ------------------------------------------
[XtrainN,mu,sigma] = zscore(Xtrain);
XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);

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
matrizConfusion = zeros(Nc,Nc);
 Ytest = Ytest';
                    Yest = Yest';
%%Aqui va es la matriz de confusion para una eficiencia
for i=1:size(Yest,1)
     matrizConfusion(Yest(i),Ytest(i)) =  matrizConfusion(Yest(i),Ytest(i)) + 1;
end
matrizConfusion
eficiencia(j) = (sum(diag(matrizConfusion)))/sum(matrizConfusion(:));
error(j) = 1 - (sum(diag(matrizConfusion)))/sum(matrizConfusion(:));
sensibilidad(j) = (matrizConfusion(1,1)/sum(matrizConfusion(1,1)+matrizConfusion(1,2)));
especificidad(j) = (matrizConfusion(2,2)/sum(matrizConfusion(2,2)+matrizConfusion(2,1)));
presicion(j) = matrizConfusion(1,1) /(matrizConfusion(1,1)+matrizConfusion(1,2));


end
Efi= nanmean(eficiencia);
IC= nanstd(eficiencia);
Sen = nanmean(sensibilidad);
IcSen = nanstd(sensibilidad);
Espe = nanmean(especificidad);
IcEspe= nanstd(especificidad);
pres = nanmean(presicion);
IcPres = nanstd(presicion);

fprintf('Error: %f - IC: %f - Sensi: %f -  IC : %f \n Espe: %f -IC : %f -Presi: %f - IC : %f \n',...
    (1-Efi),IC,Sen,IcSen,Espe,IcEspe,pres,IcPres);


