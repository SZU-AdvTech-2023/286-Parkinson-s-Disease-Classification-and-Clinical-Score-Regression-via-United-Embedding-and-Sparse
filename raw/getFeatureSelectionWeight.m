function [W] = getFeatureSelectionWeight(X,gamma,d,c,k,kk,p)   


num = size(X,2);
dim = size(X,1);

X0 = X';
mX0 = mean(X0);
X1 = X0 - ones(num,1)*mX0;
scal = 1./sqrt(sum(X1.*X1)+eps);
scalMat = sparse(diag(scal));
X = X1*scalMat;
X = X';

%初始化相似矩阵A
distX = L2_distance_1(X,X);
[distX1, idx] = sort(distX,2);
A = zeros(num);
rr = zeros(num,1);
for i = 1:num
    di = distX1(i,2:k+2);
    rr(i) = 0.5*(k*di(k+1)-sum(di(1:k)));
    id = idx(i,2:k+2);
    A(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);%归一化
end
%初始化r
r = mean(rr);
%初始化保持最大连通量数为分类数项前的系数
lambda = r;

%初始化特征相似性矩阵
distP=L2_distance_1(X',X'); %计算特征与特征相似性的欧氏距离
[distP1,idp]=sort(distP,2);
G=zeros(dim);
gg=zeros(dim,1);
for i=1:dim
    dpi=distP1(i,2:kk+2);
    gg(i)=0.5*(kk*dpi(kk+1)-sum(dpi(1:kk)));
    ip=idp(i,2:kk+2);
    G(i,ip)=(dpi(kk+1)-dpi)/(kk*dpi(kk+1)-sum(dpi(1:kk))+eps);
end
%初始化g
g=mean(gg);

%求相似性矩阵的拉普拉斯矩阵
A0 = (A+A')/2;
D0 = diag(sum(A0));
L0 = D0 - A0;
%求特征相似性矩阵对应的拉普拉斯矩阵 
G0=(G+G')/2;
D_G0=diag(sum(G0));
L_G0=D_G0-G0;
%初始化计算连通分类项
[F, ~, evs]=eig1(L0, c, 0);

[W] = InterationW_impro_FS(L_G0,L0,X,gamma,dim,d,p); 
NITER = 100;
for iter = 1:NITER
    %更新相似矩阵A
    distf = L2_distance_1(F',F');
    distx = L2_distance_1(W'*X,W'*X);
    if iter>5
        [~, idx] = sort(distx,2);
    end;
    A = zeros(num);
    for i=1:num
        idxa0 = idx(i,2:k+1);
        dfi = distf(i,idxa0);
        dxi = distx(i,idxa0);
        ad = -(dxi+lambda*dfi)/(2*r);
        A(i,idxa0) = EProjSimplex_new(ad);
    end;
    
    %更新特征相似性矩阵 
    distp=L2_distance_1(W',W');
    if iter>5
        [~,idp]=sort(distp,2);
    end
    G=zeros(dim);
    for i=1:dim
        idpg0=idp(i,2:kk+1);
        dppi=distp(i,idpg0);
        ap=-dppi/(2*g);
        G(i,idpg0)=EProjSimplex_new(ap);
    end
    %求相似性矩阵的拉普拉斯矩阵
    A = (A+A')/2;
    D = diag(sum(A));
    L = D-A;
    %求特征相似性矩阵对应的拉普拉斯矩阵  
    G=(G+G')/2;
    D_G=diag(sum(G));
    L_G=D_G-G;
    
    [W] = InterationW_impro_FS(L_G,L,X,gamma,dim,d,p);  
    F_old = F;
    [F, ~, ev]=eig1(L, c, 0);
    evs(:,iter+1) = ev;
    
    fn1 = sum(ev(1:c));
    fn2 = sum(ev(1:c+1));
    if fn1 > 0.000000001
        lambda = 2*lambda;
    elseif fn2 < 0.00000000001
        lambda = lambda/2;  F = F_old;
    elseif iter>1
        break;
    end;
end;

sqW = (W.^2);
sumW = sum(sqW,2);
[~,id] = sort(sumW,'descend');


