function Yest = KNeighbors(Xtrain, Ytrain, Xval, Yval, K, isRegression)
    N = size(Xval, 1);
    Yest = zeros(N, 1);
    
    m = mean(Xtrain);
    s = std(Xtrain);
    Xtrain_temp = zscoreadaptado(Xtrain, m, s,size(Xtrain,1));
    Xval_temp = zscoreadaptado(Xval, m, s,size(Xval,1));
    
    for i = 1:N
       distances = CalculateEuclideanDistance(Xtrain_temp, Xval_temp(i, :));
       [distances, sortIndexes] = sort(distances);
       temp = Ytrain(sortIndexes(1 : K));
       
       if (isRegression == 1)
          Yest(i) = mean(temp);
       else
          Yest(i) = mode(temp); 
       end
       %disp(strcat('Vecinos = ', num2str(sortIndexes(1 : K)), '-', num2str(i)))
    end
    Error= CalculateError(Yval, Yest, isRegression);
    disp(strcat('Error total = ', num2str(Error)))