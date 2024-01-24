

% 输入训练数据、训练标签、测试数据、训练标签、SVM参数cmd
% 以结构体的形式：返回分类准确度、召回率等指标

function svrData = getSVRData(trainData,trainScoresA,testData,testScoresA,cmd)

    svrData.Adec=eps;             
    svrData.RMSE=eps;	
    svrData.ccOrg=eps;
    svrData.Atest=testScoresA;
    svrData.ccSqrt = eps;

end