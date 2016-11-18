% function Yest = ValidarGMM(Modelo,Xtest) recibe un conjunto de modelos
% entrenados utilizando EntrenaGMM y devuelve la clase a la cual pertencen
% cada una de las muestras en Xtest


function Yest = ValidarGMM(Modelo,Xtest)

Nc = length(Modelo.Clase); % Número de clases
Matriz = zeros(size(Xtest,1),Nc);
for i = 1: Nc
    
    %-------------- COMPLETAR ---------------------------------------------
    %-- Estimar la probabilidad de las muestras en Xtest dado el modelo i -
    vtem = xxxx(Modelo.Clase(i).mix,Xtest);
    %----------------------------------------------------------------------
    if size(vtem,2) ~= 1 %Vericación de orientación del vector
        vtem = vtem';
    end
    Matriz(:,i) = vtem;
end

[~,Yest] = max(Matriz,[],2);

    