

% 输入训练数据、训练标签、测试数据、训练标签、SVM参数cmd
% 以结构体的形式：返回分类准确度、召回率等指标

function svmData = getSVMData(trainData,trainFlag,testData,testFlag,cmd)


L_SVM_MMR = svmtrain(trainFlag, trainData, cmd);


[~, Lacc, Ldec] = svmpredict(testFlag, testData, L_SVM_MMR);

[FP,TP,~,lauc] = perfcurve(testFlag,Ldec,1);

[SVMacc,SVMsen,SVMspec,SVMfscore,SVMprec,~,~] = accSenSpe(Ldec,testFlag);


svmData.SVMacc=Lacc(1,1);  
svmData.auc= lauc;          
svmData.Ldec=Ldec;          
svmData.Ltest=testFlag;     
svmData.tp=TP;
svmData.fp=FP;

svmData.acc=SVMacc;         
svmData.sen=SVMsen;         
svmData.spec=SVMspec;       
svmData.fscore=SVMfscore;	
svmData.prec=SVMprec;       


end

