
 model = pca(DatosBalanceados(:,1:end), 24)
 out_data = linproj(DatosBalanceados,model);
 figure; ppatterns(out_data);