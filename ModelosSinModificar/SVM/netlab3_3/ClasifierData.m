function [XtrainG,YtrainG,XvalG,YvalG] = ClasifierData(X,Y)


            %%Separa la base de datos en 70 y 30 porciento
            %%Utilizando el 70 y 30 respectivo para cada clase
            %%Adicionalmente los separa con un permutacion

            index = (Y == 1);
            Y1 = Y(index,:);
            X1 = X(index,:);
            N1 = size(X1,1);
            Ind1 = randperm(N1); 
            
            index = (Y == 2);
            Y2 = Y(index,:);
            X2 = X(index,:);
            N2 = size(X2,1);
            Ind2 = randperm(N2); 
            
            index = (Y == 3);
            Y3 = Y(index,:);                        
            X3 = X(index,:);
            N3 = size(X3,1);
            Ind3 = randperm(N3); 
            
            XtrainG = [X1(Ind1(1:ceil(0.7*N1)),:);X2(Ind2(1:ceil(0.7*N2)),:);X3(Ind3(1:ceil(0.7*N3)),:)];%saca el 70 de cada clase y las concatena
            YtrainG = [Y1(Ind1(1:ceil(0.7*N1)),:);Y2(Ind2(1:ceil(0.7*N2)),:);Y3(Ind3(1:ceil(0.7*N3)),:)];
            XvalG = [X1(Ind1(ceil(0.7*N1)+1:end),:);X2(Ind2(ceil(0.7*N2)+1:end),:);X3(Ind3(ceil(0.7*N3)+1:end),:)];%saca el 30 de cada clase y las concatena
            YvalG = [Y1(Ind1(ceil(0.7*N1)+1:end),:);Y2(Ind2(ceil(0.7*N2)+1:end),:);Y3(Ind3(ceil(0.7*N3)+1:end),:)];
            
            N = size(XtrainG,1);
            ord = randperm(N);
            XtrainG = XtrainG(ord,:); %70% de los datos total para entrenar
            YtrainG = YtrainG(ord,:);
            
            N = size(XvalG,1);
            ord = randperm(N);
            XvalG = XvalG(ord,:);%30 porciento de los datos total para validar
            YvalG = YvalG(ord,:);            