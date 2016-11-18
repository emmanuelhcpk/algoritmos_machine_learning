% function Yest = ValidarGMM(Modelo,Xtest) recibe un conjunto de modelos
% entrenados utilizando EntrenaGMM y devuelve la clase a la cual pertencen
% cada una de las muestras en Xtest


function Yest = ValidarAD(Modelo,Xtest)

Ycest = eval(Modelo,Xtest);
Yest = str2double(Ycest);


    