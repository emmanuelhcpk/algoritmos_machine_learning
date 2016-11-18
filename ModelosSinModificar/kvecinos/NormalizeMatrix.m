function m = NormalizeMatrix(matrix, mean, std)
   % m = (matrix - ones(size(matrix, 1), 1) .* mean) ./ (ones(size(matrix, 1), 1) .* std);
     m = (matrix - repmat(mean,size(matrix,1)))./repmat(std,size(matrix,1));