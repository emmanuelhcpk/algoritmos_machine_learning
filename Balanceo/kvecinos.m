function cercaindex = kvecinos(k, x)
	
	num = size(x,1) ; %numero de filas
	
	cercaindex = zeros(num,k);
	for i=1:num		
		
        %para calcular la distancia se puede hacer manualmente de la
        %siguiente manera:
        %----------------------------------------------------------------
		%N1 = size(x, 1);
		%N2 = size(x(i,:), 1);
		%L = x(i,:)*x';		
		%|xi-x*|^2 = sum(Xtrain.^2,2)*ones(1,N1)+ones(N2,1)*sum(X.^2,2)'-2*L
		%D = (sum(x(i,:).^2,2)*ones(1,N1)+ones(N2,1)*sum(x.^2,2)'-2*L).^(1/2)
        %----------------------------------------------------------------
        
        %sin embargo investigando se encontro que existe una funcion en
        %matlab que permite calcular la distancia de manera mas simple
        %usando dist:
        D = dist(x(i,:), x');
        %utilizamos la funcion sort para encontrar los k vecinos mas
        %cercanos al vector, luego obtenemos su indice (o) y los extraemos
		[c, o] =  sort(D);		
		cercaindex(i,:) = o(:,2:k+1);
    end
end