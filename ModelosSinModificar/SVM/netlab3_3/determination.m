function Yest = determination(SVM1,SVM2,SVM3,X,matriz,sigma)

N = size(matriz,1);
Yest = zeros(N,1);

for i=1:N
    
    %Hay decision unanime de que clase es por ejemplo 1 -1 -1
    pos = find(matriz(i,:) == 1);
    if(size(pos,2) == 1)
        Yest(i) = pos;    
    else
        %Hay conflicto entre clases                    
            vector = matriz(i,:);
            if(vector(1) == 1 && vector(2) == 1 && vector(3) == 1)              
                %%Aqui para cuando eligio 1 1 1
                %%Conflicto entre las tres clases
                alfa1 = SVM1.Alpha;
                alfa2 = SVM2.Alpha;
                alfa3 = SVM3.Alpha;
                b1 = SVM1.Bias;                
                XSVM1 = SVM1.SupportVectors;
                b2 = SVM2.Bias;
                XSVM2 = SVM2.SupportVectors;
                b3 = SVM3.Bias;
                XSVM3 = SVM3.SupportVectors;    
                
                distance1 = abs(sum((alfa1).*(kernel_mat(X(i,:),XSVM1,sigma,'gauss'))) + b1);           
                distance2 = abs(sum((alfa2).*(kernel_mat(X(i,:),XSVM2,sigma,'gauss'))) + b2);           
                distance3 = abs(sum((alfa3).*(kernel_mat(X(i,:),XSVM3,sigma,'gauss'))) + b3);           
                
                clases = [abs(distance1) abs(distance2) abs(distance3)];
                clase = find(clases == max(clases));
                Yest(i) = clase(1);
            end
            if(vector(1) == -1 && vector(2) == -1 && vector(3) == -1)              
                %%Aqui para cuando es -1 -1 -1
                %%Conflicto entre las tres
                
                alfa1 = SVM1.Alpha;
                alfa2 = SVM2.Alpha;
                alfa3 = SVM3.Alpha;
                b1 = SVM1.Bias;                
                XSVM1 = SVM1.SupportVectors;
                b2 = SVM2.Bias;                
                XSVM2 = SVM2.SupportVectors;
                b3 = SVM3.Bias;                
                XSVM3 = SVM3.SupportVectors;    
                
                distance1 = abs(sum((alfa1).*(kernel_mat(X(i,:),XSVM1,sigma,'gauss'))) + b1);           
                distance2 = abs(sum((alfa2).*(kernel_mat(X(i,:),XSVM2,sigma,'gauss'))) + b2);           
                distance3 = abs(sum((alfa3).*(kernel_mat(X(i,:),XSVM3,sigma,'gauss'))) + b3);           
                
                clases = [abs(distance1) abs(distance2) abs(distance3)];
                clase = find(clases == min(clases));
                Yest(i) = clase(1);
                
                
            end            
            if(vector(1) == 1 && vector(2) == 1 && vector(3) == -1)              
                %%Aqui para cuando eligio 1 1 -1
                %%Conflicto entre las clases 1 y 2
                alfa1 = SVM1.Alpha;
                alfa2 = SVM2.Alpha;                
                b1 = SVM1.Bias;                
                XSVM1 = SVM1.SupportVectors;
                b2 = SVM2.Bias;                
                XSVM2 = SVM2.SupportVectors;
                
                distance1 = sum((alfa1).*(kernel_mat(X(i,:),XSVM1,sigma,'gauss'))) + b1;           
                distance2 = sum((alfa2).*(kernel_mat(X(i,:),XSVM2,sigma,'gauss'))) + b2;           
                
                clases = [abs(distance1) abs(distance2)];
                %clases = [abs(distance1) abs(distance2) (abs(min(clases))-1)];
                clase = find(clases == max(clases));
                Yest(i) = clase(1);
                
            end 
            
            if(vector(1) == 1 && vector(2) == -1 && vector(3) == 1)              
                %%Aqui para cuando eligio 1 -1 1
                %%Conflicto entre las clases 1 y 3
                                
                alfa1 = SVM1.Alpha;
                alfa3 = SVM3.Alpha;                
                b1 = SVM1.Bias;                
                XSVM1 = SVM1.SupportVectors;
                b3 = SVM3.Bias;                
                XSVM3 = SVM3.SupportVectors;    
                
                distance1 = sum((alfa1).*(kernel_mat(X(i,:),XSVM1,sigma,'gauss'))) + b1;           
                distance3 = sum((alfa3).*(kernel_mat(X(i,:),XSVM3,sigma,'gauss'))) + b3;           
                
                %clases = [abs(distance1) (abs(min(clases))-1) abs(distance3)];
                clases = [abs(distance1) abs(distance3)];
                clase = find(clases == max(clases));
                Yest(i) = clase(1);
                
            end            
                 
            if(vector(1) == -1 && vector(2) == 1 && vector(3) == 1)              
                %%Aqui para cuando eligio -1 1 1
                %%Conflicto entre las clases 2 y 3
                                
                alfa2 = SVM2.Alpha;
                alfa3 = SVM3.Alpha;                
                b2 = SVM2.Bias;                
                XSVM2 = SVM2.SupportVectors;
                b3 = SVM3.Bias;                
                XSVM3 = SVM3.SupportVectors;    
                
                distance2 = sum((alfa2).*(kernel_mat(X(i,:),XSVM2,sigma,'gauss'))) + b2;           
                distance3 = sum((alfa3).*(kernel_mat(X(i,:),XSVM3,sigma,'gauss'))) + b3;           
                
                clases = [abs(distance2) abs(distance3)];
                %clases = [(abs(min(clases))-1) abs(distance2) abs(distance3)];
                clase = find(clases == max(clases));
                Yest(i) = clase(1);
                
            end                 
    end
    
end    
 