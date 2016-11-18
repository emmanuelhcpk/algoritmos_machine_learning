function criterial = FisherCriterial2( Xtrain, Ytrain, Xtest, Ytest)

[XtrainN,mu,sigma] = zscore(Xtrain);
XtestN = (Xtest - repmat(mu,size(Xtest,1),1))./repmat(sigma,size(Xtest,1),1);

CLASS = classify(XtestN,XtrainN,Ytrain);
criterial = sum(CLASS ~= Ytest);



% d = size(Xtrain,2);
% X= [Xtrain; Xtest];
% Y=[Ytrain; Ytest];
% CN= length( unique(Y));
% criterial=0;
% 
%     for i= min(Y) : CN -1
%        for j= i+1 : CN
%           X1=X((Y==i),:);
%           X2=X((Y==j),:);
% 
%           mean1= mean(X1);
%           mean2= mean(X2);
%           cov1= cov(X1);
%           cov2= cov(X2);
% 
%           %criterial = criterial + (d^2)*((det(cov1) + det(cov2))/norm(mean1-mean2));
%           criterial = criterial + ((sum(diag(cov1)) + sum(diag(cov2))))/norm(mean1-mean2);
%        end
%     end
% 
% end

