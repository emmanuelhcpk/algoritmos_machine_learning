clc;
clear all;
close all;
a=readtable('hour.csv');
b=a;
b(:,2)=[];
DatosBalanceados=table2array(b);
save('datos.mat','DatosBalanceados');)