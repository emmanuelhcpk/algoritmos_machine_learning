function t =  Partion(Y,flag)
               
        t = Y;
        
        if flag == 1
            t(Y == 1) = 1;
            t(Y == 2) = -1;    
            t(Y == 3) = -1;            
        end    
        
        if flag == 2
            t(Y == 1) = -1;
            t(Y == 2) = 1;    
            t(Y == 3) = -1;            
        end            
        
        if flag == 3
            t(Y == 1) = -1;
            t(Y == 2) = -1;    
            t(Y == 3) = 1;            
        end    
        
        
