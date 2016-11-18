close all
clc

dim = 2;

x1 = randn(350,dim)+1;
x2 = randn(350,dim)+5;
x3 = randn(350,dim)+10;
ncentros = 3;
concat=[x1;x2;x3];

%indice=randperm(size(concat,1));
centroides=zeros(2,ncentros);

for i = 1:ncentros
    centroides(:,i) = randn(dim,1);
end
disp(centroides);

opciones = zeros(1,14);
opciones(14)=20;

k=kmeans2(centroides',concat,opciones,x1,x2,x3);












%figure
%plot(k);