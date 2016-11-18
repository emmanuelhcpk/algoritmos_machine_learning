clc;
% muestras = german_data;
muestras = muestrasSFS;
% muestras = DatosBalanceados;
totalDatos = length(muestras);
%muestras = german_data(:,[resultadoSFS,1]==1);

% Y = muestras(:,1); % Separa varibles de entrada de variables de entrada
% muestras(:,1) = []; % Separa varibles de entrada de variables de salida
% X = muestras;
% 
% modeloSVM = svmtrain(X,Y');

% Cuenta el total de muestras por clase 
% totalUNO = sum(muestras(:,7)==1);
% totalDOS = sum(muestras(:,7)==2);
% totalTRES = sum(muestras(:,7)==3);
iteraciones = 10;
vectorEficiencia = zeros(iteraciones,1);
sensibTest = zeros(iteraciones,1);
especifi =  zeros(iteraciones,1);
Precision = zeros(iteraciones,1);
vectorC = [1,10,100,1000]; %Vector parametro C
vectorH = [0.001,0.01,0.1,1,10]; %vector parametro sigma


for c=1:1
    for itera = 1:iteraciones
            % Validacion Bootstrap, se separan aleatoriamente loa datos en 70-30
            [Xtrain,Ytrain,Xtest,Ytest,totalTrain] = splitData(muestras,70);

            %Normalizamos conjuntos de entrenamiento
            [XtrainN,mu,sigma] = zscore(Xtrain);
            XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);
            totalUNOTrain = sum(Ytrain==1);
            totalDOSTrain = sum(Ytrain==2);

            matrizConfusion = zeros(2,2);

            % ------------------------ENTRENAMIENTO-----------------------------------%
            %Modelos SVM para clasificacion one vs all
          %  modeloSVM = svmtrain(XtrainN,Ytrain,'boxconstraint',vectorC(c),'kernel_function','linear');
            options.MaxIter = 3000000;
            tiempoEntrena = tic;
            modeloSVM = svmtrain(XtrainN,Ytrain,'Options',options,'boxconstraint',100,'kernel_function','rbf','rbf_sigma',10);
%             modeloSVM = svmtrain(XtrainN,Ytrain,'Options',options,'boxconstraint',1,'kernel_function','linear');
%            modeloSVM_DOS_DEMAS = svmtrain(claseDOS_DEMAS,YDOS_DEMAS,'boxconstraint',vectorC(c),'kernel_function','linear' );
         %   modeloSVM_TRES_DEMAS = svmtrain(claseTRES_DEMAS,YTRES_DEMAS,'boxconstraint',vectorC(c),'kernel_function','linear' );
            toc(tiempoEntrena);
            % ------------------------VALIDACION------------------------------------- %
            tiempoValida = tic;
            clasifica = svmclassify(modeloSVM,XtestN);
            %clasificaDOS_DEMAS = svmclassify(modeloSVM_DOS_DEMAS,XtestN);
        %    clasificaTRES_DEMAS = svmclassify(modeloSVM_TRES_DEMAS,XtestN);
 
            % Muestra la clasificiacion realizada por cada SVM contra el Y real
           desicion = clasifica;
           Yest = desicion;

           for i=1:size(Yest,1)
                   matrizConfusion(Yest(i),Ytest(i)) =  matrizConfusion(Yest(i),Ytest(i)) + 1;
           end
           vectorEficiencia(itera)  = (sum(diag(matrizConfusion)))/sum(matrizConfusion(:));
           sensibTest(itera) = (matrizConfusion(1,1)/sum(matrizConfusion(1,1)+matrizConfusion(1,2)));
           especifi(itera) = matrizConfusion(2,2)/sum(matrizConfusion(2,2)+matrizConfusion(2,1));
           Precision(itera) = matrizConfusion(1,1) /(matrizConfusion(1,1)+matrizConfusion(1,2));
          toc( tiempoValida);
           
    end
matrizConfusion;
Efi= mean(vectorEficiencia);
IC= std(vectorEficiencia);
Sen = nanmean(sensibTest);
IcSen = nanstd(sensibTest);
Espe = nanmean(especifi);
IcEspe= nanstd(especifi);
pres = mean(Precision);
IcPres = std(Precision);

% disp('C');
% disp(vectorC(c));
disp('Eficiencia:');
disp(num2str(Efi));
disp(' +- ');
disp(num2str(IC));

fprintf('Error: %f - IC: %f - Sensi: %f -  IC : %f \n Espe: %f -IC : %f -Presi: %f - IC : %f \n Entrena: %f Valida :%f \n',...
    (1-Efi),IC,Sen,IcSen,Espe,IcEspe,pres,IcPres,mean(tiempoEntrena),mean(tiempoValida));

end
% Efi= mean(vectorEficiencia);
% IC= std(vectorEficiencia);
% disp('Eficiencia:');
% disp(num2str(Efi));
% disp(' +- ');
% disp(num2str(IC));
