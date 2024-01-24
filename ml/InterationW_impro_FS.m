function [W] = InterationW_impro_FS(L_G,L,X,gamma,dim,m,p)

INTER_W = 100;
Q = eye(dim);
xlx= X*L*X';
xlx = (xlx+xlx')/2;

for i = 1:INTER_W
    tempXLXQ = (xlx+L_G+gamma*Q);  
    [vec,val] = eig(tempXLXQ);
    [~,di] = sort(diag(val));
    W = vec(:,di(1:m));

    tempQ = 0.5*p * (sqrt(sum(W.^2,2)+eps)).^(p-2);
    Q = diag(tempQ);

    w0(i) = trace(W'*L_G*W);  
    w1(i) = trace(W'*X*L*X'*W); 
    w2(i) = gamma*sum(sqrt(sum(W.^2,2)).^p);
    WResult(i) = w0(i)+w1(i)+w2(i); 

    if i > 1 && abs(WResult(i-1)-WResult(i)) < 0.000001
        break;
    end;
    
end;
% plot(WResult); 
end