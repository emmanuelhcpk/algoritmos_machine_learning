function synthetic = populate(N, i, nnarray, numattrs, sample)

	newindex = 1;
	synthetic = []; %tamaño de la nueva muestra
    %mientras N sea diferente de cero
	while (N ~= 0)
		
        %selecciono un indice del array aleatoriamente
		nn = randi(size(nnarray,2));
		for attr = 1:numattrs
            %diferencia entre un atributo seleccionado aleatoriamente de
            %los k vecinos mas cercanos y el atributo en cuestion
			dif  = sample(nnarray(nn),attr) -sample(i,attr);
            % numero aleatorio entre 0 -1 
			gap = rand(1);
            %final mente se calcula la nueva muestra
			synthetic(newindex, attr) = sample(i,attr) +(gap*dif);
        end
        %avanzo en el for
		newindex = newindex +1;
		N = N -1;
       
    end
end