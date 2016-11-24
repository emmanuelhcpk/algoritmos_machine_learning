function W = regresionMultiple(X,Y,eta)
%N es el numero de filas, D es el numero columnas%
[N,D]=size(X);
W=zeros(D,1);
Witer=zeros(D,1);
for iter = 1:50
    %%% Completar el c�digo %%% 
    for j=1:D
        derivadaE=derivadaError(W,X,Y,j);
        W(j)=W(j)-eta*derivadaE;
    end
    %%% Fin de la modificaci�n %%%
end


end