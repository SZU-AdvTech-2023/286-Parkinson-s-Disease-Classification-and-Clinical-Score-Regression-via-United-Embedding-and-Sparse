function [Xtrain,Ltrain,Xtest,Ltest,Atrain,Atest,Btrain,Btest,Ctrain,Ctest,Dtrain,Dtest,Ytrain] = ...
    subKFold(...
    Xpar1,Xpar2,...
    posY,negY,...
    posScoresA,negScoresA,...
    posScoresB,negScoresB,...
    posScoresC,negScoresC,...
    posScoresD,negScoresD,...
    labelPar1,labelPar2,...
    indPar1,indPar2,...
    i)


test1 = (indPar1==i);     
train1 = ~test1;       

Xtest1 = Xpar1(test1,:);
Ltest1 = labelPar1(test1,:);
posAtest = posScoresA(test1,:);
posBtest = posScoresB(test1,:);
posCtest = posScoresC(test1,:);
posDtest = posScoresD(test1,:);

Xtrain1 = Xpar1(train1,:);     
Ltrain1 = labelPar1(train1,:);	
posYtrain = posY(train1,:);     
posAtrain = posScoresA(train1,:);
posBtrain = posScoresB(train1,:);
posCtrain = posScoresC(train1,:);
posDtrain = posScoresD(train1,:);

test2 = (indPar2 ==i);    
train2 = ~test2;

Xtest2 = Xpar2(test2,:);
Ltest2 = labelPar2(test2,:);
negAtest = negScoresA(test2,:);
negBtest = negScoresB(test2,:);
negCtest = negScoresC(test2,:);
negDtest = negScoresD(test2,:);

Xtrain2 = Xpar2(train2,:);    
Ltrain2 = labelPar2(train2,:);
negYtrain = negY(train2,:);     
negAtrain = negScoresA(train2,:);
negBtrain = negScoresB(train2,:);
negCtrain = negScoresC(train2,:);
negDtrain = negScoresD(train2,:);


Xtrain = [Xtrain1;Xtrain2];     
Ltrain = [Ltrain1;Ltrain2];     
Ytrain = [posYtrain;negYtrain]; 
Atrain = [posAtrain;negAtrain]; 
Btrain = [posBtrain;negBtrain]; 
Ctrain = [posCtrain;negCtrain]; 
Dtrain = [posDtrain;negDtrain];

Xtest = [Xtest1;Xtest2];        
Ltest = [Ltest1;Ltest2];        
Atest = [posAtest;negAtest];    
Btest = [posBtest;negBtest];    
Ctest = [posCtest;negCtest];    
Dtest = [posDtest;negDtest];    



