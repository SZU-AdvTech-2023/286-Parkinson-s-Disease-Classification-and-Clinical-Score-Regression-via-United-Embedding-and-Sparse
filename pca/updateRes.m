function Res=updateRes(Res,Acc,Sen,Spec,Prec,Fscore,Auc,...
    maxAcc,minArmse,maxBcc,minBrmse,maxCcc,minCrmse,maxDcc,minDrmse,Rs,Ra,Rb,Rc,Rd,...
    l1,l2,l3,l4,SelectFeaIdx,W)


    %----------------------- SVM --------------------------
    meanOfAcc = mean(Acc(:));
    meanOfSen = mean(Sen(:));
    meanOfSpec = mean(Spec(:));
    meanOfPrec= mean(Prec(:)); 
    meanOfFscore = mean(Fscore(:));
    meanOfAuc = mean(Auc(:));
    
    stdOfAcc = std(Acc(:));
    stdOfSen = std(Sen(:));
    stdOfSpec = std(Spec(:));
    stdOfPrec = std(Prec(:));
    stdOfFscore = std(Fscore(:));
    stdOfAuc = std(Auc(:));
    
   
    if Res.svmFscore < meanOfFscore
        Res.svmAcc = meanOfAcc;
        Res.svmAcc_Std = stdOfAcc;    
        Res.svmSen = meanOfSen;
        Res.svmSen_Std = stdOfSen;     
        Res.svmSpec = meanOfSpec;
        Res.svmSpec_Std = stdOfSpec;   
        Res.svmPrec = meanOfPrec;
        Res.svmPrec_Std = stdOfPrec;   
        Res.svmFscore = meanOfFscore;
        Res.svmFscore_Std = stdOfFscore;
        Res.svmAuc = meanOfAuc;
        Res.svmAuc_Std = stdOfAuc;   
        Res.svm_Fea = SelectFeaIdx;
        Res.svm_W = W;               
        Res.svm_Rs=Rs;
        Res.svmFscore_Lamb=[l1,l2,l3,l4];   
    end
    
    
    %---------------------- scoreA ------------------------
    meanOfmaxAcc = mean(maxAcc(:));
    stdOfmaxAcc = std(maxAcc(:)); 
    meanOfminArmse = mean(minArmse(:));   
    stdOfminArmse = std(minArmse(:));
    if Res.maxAcc <= meanOfmaxAcc && meanOfmaxAcc <= 1                
        Res.maxAcc = meanOfmaxAcc;
        Res.maxAcc_Std = stdOfmaxAcc;
        Res.minArmse = meanOfminArmse;   
        Res.minArmse_Std = stdOfminArmse;
        Res.maxAcc_Ra=Ra;
        Res.maxAcc_Lamb=[l1,l2,l3,l4];
    end

    
    %---------------------- scoreB ------------------------
    meanOfmaxBcc = mean(maxBcc(:));
    stdOfmaxBcc = std(maxBcc(:));
    meanOfminBrmse = mean(minBrmse(:));   
    stdOfminBrmse = std(minBrmse(:));
    if Res.maxBcc <= meanOfmaxBcc && meanOfmaxBcc <= 1                
        Res.maxBcc = meanOfmaxBcc;
        Res.maxBcc_Std = stdOfmaxBcc;
        Res.minBrmse = meanOfminBrmse;
        Res.minBrmse_Std = stdOfminBrmse;
        Res.maxBcc_Rb=Rb;
        Res.maxBcc_Lamb=[l1,l2,l3,l4];
    end
    
    
    %---------------------- scoreC ------------------------
    meanOfmaxCcc = mean(maxCcc(:));
    stdOfmaxCcc = std(maxCcc(:));  
    meanOfminCrmse = mean(minCrmse(:));   
    stdOfminCrmse = std(minCrmse(:));
    if Res.maxCcc <= meanOfmaxCcc && meanOfmaxCcc <= 1           
        Res.maxCcc = meanOfmaxCcc;
        Res.maxCcc_Std = stdOfmaxCcc;
        Res.minCrmse = meanOfminCrmse;
        Res.minCrmse_Std = stdOfminCrmse;
        Res.maxCcc_Rc=Rc;
        Res.maxCcc_Lamb=[l1,l2,l3,l4];
    end
    
    
    %---------------------- scoreD ------------------------
    meanOfmaxDcc = mean(maxDcc(:));
    stdOfmaxDcc = std(maxDcc(:));  
    meanOfminDrmse = mean(minDrmse(:));
    stdOfminDrmse = std(minDrmse(:));
    if Res.maxDcc <= meanOfmaxDcc && meanOfmaxDcc <= 1              
        Res.maxDcc = meanOfmaxDcc;
        Res.maxDcc_Std = stdOfmaxDcc;
        Res.minDrmse = meanOfminDrmse;
        Res.minDrmse_Std = stdOfminDrmse;
        Res.maxDcc_Rd=Rd;
        Res.maxDcc_Lamb=[l1,l2,l3,l4];
    end
    
    
    
end



















