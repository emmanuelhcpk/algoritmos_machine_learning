totalDatos = length(Data);
muestras = Data;
% Y = muestras(:,1); % Separa varibles de entrada de variables de entrada
% muestras(:,1) = []; % Separa varibles de entrada de variables de salida
% X = muestras;
% 
% modeloSVM = svmtrain(X,Y');

% Cuenta el total de muestras por clase 
totalUNO = sum(muestras(:,7)==1);
totalDOS = sum(muestras(:,7)==2);
totalTRES = sum(muestras(:,7)==3);

% Validacion Bootstrap, se separan aleatoriamente loa datos en 70-30
[Xtrain,Ytrain,Xtest,Ytest,totalTrain] = splitData(muestras,70);

totalUNOTrain = sum(Ytrain==1);
totalDOSTrain = sum(Ytrain==2);
totalTRESTrain = sum(Ytrain==3);

% ----------------------PROCESAMIENTO DE DATOS----------------------------%
% Separa cada clase de acuerdo a la varible de salida
claseUNO=Xtrain(Ytrain == 1,:);
claseDOS=Xtrain(Ytrain == 2,:);
claseTRES=Xtrain(Ytrain == 3,:);
% Para efectos practicos se reduce las muestras a 10 por clase
claseUNO = claseUNO(1:10,:);
claseDOS = claseDOS(1:10,:);
claseTRES = claseTRES(1:10,:);

% El metodo svmtrain recibe las dos clases juntas, por lo tanto se deben
% concatenar - preparando las muestras para on vs all
% Union se clases con su respectivo identificador de clase
claseUNO_DEMAS = [claseUNO;claseDOS_TRES];
YUNO_DEMAS = [ones(size(claseUNO,1),1);-1*ones(size(claseDOS_TRES,1),1)];

claseDOS_DEMAS = [claseDOS;claseTRES_UNO];
YDOS_DEMAS = [ones(size(claseDOS,1),1);-1*ones(size(claseTRES_UNO,1),1)];

claseTRES_DEMAS = [claseTRES;claseUNO_DOS];
YTRES_DEMAS = [ones(size(claseTRES,1),1);-1*ones(size(claseUNO_DOS,1),1)];

% ------------------------ENTRENAMIENTO-----------------------------------%
%Modelos SVM para clasificacion one vs all
modeloSVM_UNO_DEMAS = svmtrain(claseUNO_DEMAS,YUNO_DEMAS,'boxconstraint',1,'kernel_function','linear' );
modeloSVM_DOS_DEMAS = svmtrain(claseDOS_DEMAS,YDOS_DEMAS,'boxconstraint',1,'kernel_function','linear' );
modeloSVM_TRES_DEMAS = svmtrain(claseTRES_DEMAS,YTRES_DEMAS,'boxconstraint',1,'kernel_function','linear' );

modeloSVM_UNO_DEMAS2 = svmtrain(claseUNO_DEMAS,YUNO_DEMAS,'boxconstraint',1,'kernel_function','rbf' );


% ------------------------VALIDACION------------------------------------- %
clasificaUNO_DEMAS = svmclassify(modeloSVM_UNO_DEMAS,Xtest);
clasificaDOS_DEMAS = svmclassify(modeloSVM_DOS_DEMAS,Xtest);
clasificaTRES_DEMAS = svmclassify(modeloSVM_TRES_DEMAS,Xtest);

% Muestra la clasificiacion realizada por cada SVM contra el Y real
desicion = [clasificaUNO_DEMAS,clasificaDOS_DEMAS,clasificaTRES_DEMAS,Ytest];

enConflicto = zeros(size(Xtest,1),size(Xtest,2));
