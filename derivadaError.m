function sum = derivadaError(W,X,Y,posW)
numMue=size(X,1);
sum=0;
for i=1:numMue
    sum=sum+(X(i,:)*W-Y(i))*X(i,posW);
end
sum=sum/numMue;