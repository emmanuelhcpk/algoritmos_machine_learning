function [c,h] = BestSVM(CelParametros)
    
    N = size(CelParametros,1);
    P = size(CelParametros,2);
    best = 0;
    c=0;
    h=0;
        
    for i=1:N
       
        for j=1:P
           
            aux = CelParametros(i,j);
            if(best<=aux)
                best = aux;
                c = i;
                h = j;
            end    
        end    
        
    end    