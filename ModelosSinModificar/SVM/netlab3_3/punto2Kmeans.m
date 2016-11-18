% Punto 2: Laoratorio 2 de Simulaciones

dim = 2; % Dimensión del espacio 
%m1 = floor(randn(1)*10);
m2 = floor(randn(1)*10);
m3 = floor(randn(1)*10);

nmuestras = 100; % total de muestras
experimentales = .3; % corresponde al porcentaje para validación tipo bootstraping
ncentros = 3; %

%-------------------------------------------------------------------------%

ndata = 500;
data = randn(ndata, 2);
prior = [0.3 0.5 0.2];
% Mixture model swaps clusters 1 and 3
datap = [0.2 0.5 0.3];
datac = [0 2; 0 0; 2 3.5];
datacov = repmat(eye(2), [1 1 3]);
data1 = data(1:prior(1)*ndata,:);
data2 = data(prior(1)*ndata+1:(prior(2)+prior(1))*ndata, :);
data3 = data((prior(1)+prior(2))*ndata +1:ndata, :);

% First cluster has axis aligned variance and centre (2, 3.5)
data1(:, 1) = data1(:, 1)*0.1 + 2.0;
data1(:, 2) = data1(:, 2)*0.8 + 3.5;
datacov(:, :, 3) = [0.1*0.1 0; 0 0.8*0.8];

% Second cluster has variance axes rotated by 30 degrees and centre (0, 0)
rotn = [cos(pi/6) -sin(pi/6); sin(pi/6) cos(pi/6)];
data2(:,1) = data2(:, 1)*0.2;
data2 = data2*rotn;
datacov(:, :, 2) = rotn' * [0.04 0; 0 1] * rotn;

% Third cluster is at (0,2)
data3(:, 2) = data3(:, 2)*0.1;
data3 = data3 + repmat([0 2], prior(3)*ndata, 1);

X1 = data1;
X2 = data2;
X3 = data3;

%-------------------------------------------------------------------------%}%
%Datos generales - formato para pasar como parametro a kmeans
data = [X1;X2;X3]; 

%Centros 
perm = randperm(size(data,1));
centros = zeros(dim,ncentros);
dataAleatorio = data(perm);

for i = 1:ncentros
    centros(:,i) = randn(dim,1);
end

disp('centros actuales');
disp(centros);
Opciones = foptions(14);
%Opciones(8) = 1; ni idea esto para qué
Opciones(14) = 50; % Total iteraciones
Opciones(5) = 1;
Opciones(1) = 1;
resultados = kmeans2(centros',data,Opciones,X1,X2,X3);
    
disp(resultados);
vector = 1:1:300;
vectorcentros = 1:1:300;

for i = 1:ncentros
    vectorcentros(1,i) = perm(i);
end
centros = centros';

%plot(centros(:,1),centros(:,2), 'ob');
%plot(resultados(:,1),resultados(:,2), 'or');