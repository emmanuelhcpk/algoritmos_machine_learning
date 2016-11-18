%llamo el algoritmo, le enviamos como parametros, las clases minoritarias
%T, el porcetaje N% que hace referencia a la cantidad de smote que se
%quiere realizar y el numero de vecinos a evaluar K. El algoritmo me
%devolvera nuevas muestras de la clase minoritaria creadas sinteticamente,
%el numero de muestras sera (N/100) * T

function synthetic = smote(T, N, k)
	    
    numattrs = size(T,2); %numero de atributos	
    nt = size(T,1); %cantidad de muestras
    
    if(N < 100)      
        %combino las filas aleatoreamente
        T = T(randperm(size(T,1)),:);
        nt = floor((N/100)*nt); %redondeo el numero
        N = 100;
    end
    
    N = floor(N/100);
    
    %calculo los k vecinos y retorno su indice en la muestra original
	cercaindex = kvecinos(k, T);
    
    synthetic = []; %nueva muestra
	for i =1:nt
        %claculo las nuevas muestras, envio como parametros el % de smote,
        %el indice de la muestra, sus k vecinos, el numero de atrivutos y
        %las muestras
		synthetic = [synthetic; populate(N,i,cercaindex(i,:), numattrs, T)];
    end
end