function structPCA = findbestpcastruct(structForPCA)
    error = inf;

    for row = 1:size(structForPCA, 1)
        for column = 1:size(structForPCA, 2)
            if (error > structForPCA(row, column).error)
                error = structForPCA(row, column).error;
                structPCA = structForPCA(row, column);
            end
        end
    end