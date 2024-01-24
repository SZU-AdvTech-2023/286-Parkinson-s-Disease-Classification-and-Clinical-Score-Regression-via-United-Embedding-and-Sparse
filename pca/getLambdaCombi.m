function combis = getLambdaCombi(pars)
    len4=length(pars.lambda4);
    len3=length(pars.lambda3);  
    len2=length(pars.lambda2);
    len1=length(pars.lambda1);
    TOTAL=len1*len2*len3*len4;

    combis = zeros(TOTAL, 4);
    ind = 1;
    for l4=1:len4
        lamb4=pars.lambda4(l4); 
        for l3 = 1:len3 % pars.lambda3 = 1
            lamb3=pars.lambda3(l3); 
            for l2 = 1:len2 % pars.lambda2 = 1
                lamb2=pars.lambda2(l2); 
                for l1 = 1:len1 % pars.lambda1 = 1  
                    lamb1=pars.lambda1(l1);
                    combis(ind, :) = [lamb1, lamb2, lamb3, lamb4];
                    ind = ind + 1;
                end
            end
        end
    end

    
end