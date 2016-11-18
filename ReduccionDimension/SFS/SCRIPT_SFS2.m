muestras = DatosBalanceados;

X = muestras(:, 1:end-1);
Y = muestras(:, end);
%----- First output.

opts = statset('display','iter');

indices  = sequentialfs(@FisherCriterial2, X, Y, 'options',opts);

indices = [indices,1];

muestrasSFS = muestras(:,(indices==1));
