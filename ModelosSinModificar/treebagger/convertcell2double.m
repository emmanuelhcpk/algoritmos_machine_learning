function vector = convertcell2double(cell)
    dimen = size(cell, 1);
    vector = zeros(dimen, 1);
    
    for pos = 1 : dimen
       vector(pos) = str2double(cell{pos});
    end