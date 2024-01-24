function workFunction( ...
    groupSelect, ...
    mergeDataSelect, ...
    regScoreSelect, ...
    kFold, ...
    subFold, ...
    svmParc, ...
    svmParg, ...
    parsLambda1, ...
    parsLambda2, ...
    parsLambda3, ...
    parsLambda4, ...
    parsIte, ...
    meanSelect, ...
    isYscoresCentering...
    )



% =================below is data handle procedure===========================
load PPMI_238_62NC_142PD_34SWEDD_mat_add_age_sex;
dataT1_CSF_DTI=PPMI_238_62NC_142PD_34SWEDD_mat_add_age_sex(:,2:end);
dataT1_CSF_DTI=cell2mat(dataT1_CSF_DTI);

T1_G_116=dataT1_CSF_DTI(:,1:116);   
T1_W_116=dataT1_CSF_DTI(:,117:232); 
T1_C_116=dataT1_CSF_DTI(:,233:348); 
FA_116=dataT1_CSF_DTI(:,349:464);   
MD_116=dataT1_CSF_DTI(:,465:580);   
L1_116=dataT1_CSF_DTI(:,581:696);   
L2_116=dataT1_CSF_DTI(:,697:812);   
L3_116=dataT1_CSF_DTI(:,813:928);   
V1_116=dataT1_CSF_DTI(:,929:1044);  
V2_116=dataT1_CSF_DTI(:,1045:1160); 
V3_116=dataT1_CSF_DTI(:,1161:1276); 
DSSM=dataT1_CSF_DTI(:,1277:1280);   
label=dataT1_CSF_DTI(:,1281);       
age=dataT1_CSF_DTI(:,1282);
sex=dataT1_CSF_DTI(:,1283);

isNC=(label==1);           
isPD=(label==-1);
isSWEDD=(label==2);
    

IndexStirng=['Index_',groupSelect{3},'_vs_',groupSelect{4}];
load (IndexStirng); 

D=[T1_G_116,T1_W_116,T1_C_116,FA_116,MD_116,L1_116,L2_116,L3_116,V1_116,V2_116,V3_116,DSSM,label,age,sex];	
COMPOSE1=D(eval(groupSelect{1}),:);                 
COMPOSE2=D(eval(groupSelect{2}),:);                  

data=[COMPOSE1;COMPOSE2];

data_T1_G_116=data(:,1:116);   
data_T1_W_116=data(:,117:232); 
data_T1_C_116=data(:,233:348); 
data_FA_116=data(:,349:464);   
data_MD_116=data(:,465:580);   
data_L1_116=data(:,581:696);   
data_L2_116=data(:,697:812);  
data_L3_116=data(:,813:928);   
data_V1_116=data(:,929:1044); 
data_V2_116=data(:,1045:1160); 
data_V3_116=data(:,1161:1276); 

depScores=data(:,1277);
sleepScores=data(:,1278);
smellScores=data(:,1279);
MoCAScores=data(:,1280);
data_label=data(:,1281);
data_age=data(:,1282);
data_sex=data(:,1283);



flagCOMPOSE1=ones(size(COMPOSE1,1),1);      
flagCOMPOSE2=-1*ones(size(COMPOSE2,1),1);	
mergeflag=[flagCOMPOSE1;flagCOMPOSE2];      

 
data_YScore=[];
for i=1:length(regScoreSelect)
    % depScores sleepScores smellScores MoCAScores
    if(isequal(regScoreSelect{i},'depScores'))
        data_YScore=[data_YScore,eval(regScoreSelect{i})];    
    elseif(isequal(regScoreSelect{i},'sleepScores'))
        data_YScore=[data_YScore,eval(regScoreSelect{i})]; 
    elseif(isequal(regScoreSelect{i},'smellScores'))
        data_YScore=[data_YScore,eval(regScoreSelect{i})]; 
    elseif(isequal(regScoreSelect{i},'MoCAScores'))
        data_YScore=[data_YScore,eval(regScoreSelect{i})]; 
    end
end

data_YScore=[data_YScore,mergeflag];
 

X1=data_T1_G_116;   
X1=convert2Sparse(X1); 

X2=data_T1_W_116;  
X2=convert2Sparse(X2); 

M=data_T1_C_116;  
M=convert2Sparse(M); 

Y=data_FA_116;
Y=convert2Sparse(Y); 

Z=data_MD_116;
Z=convert2Sparse(Z); 

L1=data_L1_116;
L1=convert2Sparse(L1); 

L2=data_L2_116;
L2=convert2Sparse(L2); 

L3=data_L3_116;
L3=convert2Sparse(L3); 

V1=data_V1_116;
V1=convert2Sparse(V1); 

V2=data_V2_116;
V2=convert2Sparse(V2); 

V3=data_V3_116;
V3=convert2Sparse(V3); 

A=[data_age,data_sex,depScores,sleepScores,smellScores,MoCAScores];
A=convert2Sparse(A);



L=data_YScore;
if(isYscoresCentering==1)  
    L=convert2Sparse(L); 
end

mergeData=[];
for mLen=1:length(mergeDataSelect)   
    mergeData=[mergeData,eval(mergeDataSelect{mLen})];
end

mergeYScore=L;           


pars.k1 = subFold; 
parc = svmParc; 
parg = svmParg;
pars.lambda1 = parsLambda1;
pars.lambda2 = parsLambda2;
pars.lambda3 = parsLambda3;
pars.lambda4 = parsLambda4;
pars.Ite=parsIte;


posSampleNum=length(flagCOMPOSE1);
 
Is_zero_feature=all(mergeData==0); 
mergeData(:,Is_zero_feature)=[];

Xpar1=mergeData(1:posSampleNum,:);     
Xpar2=mergeData(posSampleNum+1:end,:);	

Ypar1=mergeYScore(1:posSampleNum,:);        
Ypar2=mergeYScore(posSampleNum+1:end,:);	

scoresApar1=depScores(1:posSampleNum,:);
scoresApar2=depScores(posSampleNum+1:end,:);
scoresBpar1=sleepScores(1:posSampleNum,:);
scoresBpar2=sleepScores(posSampleNum+1:end,:);
scoresCpar1=smellScores(1:posSampleNum,:);
scoresCpar2=smellScores(posSampleNum+1:end,:);
scoresDpar1=MoCAScores(1:posSampleNum,:);
scoresDpar2=MoCAScores(posSampleNum+1:end,:);

labelPar1=flagCOMPOSE1;        
labelPar2=flagCOMPOSE2;           

len4=length(pars.lambda4);
len3=length(pars.lambda3);  
len2=length(pars.lambda2);
len1=length(pars.lambda1);
TOTAL=len1*len2*len3*len4;  

SelectFeaIdx=cell(kFold,pars.k1);   
W=cell(kFold,pars.k1);              
Ite=pars.Ite;                       

Res1=initialRes; 
Res2=initialRes; 

meanDegree=meanSelect; 


% ======================below is feature selection procedure========================
combis = getLambdaCombi(pars);
fid = fopen('log6.txt', 'a+');
initialCombiNo = 1;
bestCombiNo = 1;
for combiNo = initialCombiNo:size(combis, 1)
    combi = combis(combiNo, :);
    lamb1 = combi(1);
    lamb2 = combi(2);
    lamb3 = combi(3);
    lamb4 = combi(4);

    for kk = 1:kFold 
        indPar1=ind1(:,kk);
        indPar2=ind2(:,kk);
        for ii = 1:pars.k1
            [trainData,trainFlag,testData,testFlag,Atrain,Atest,Btrain,Btest,Ctrain,Ctest,Dtrain,Dtest,Ytrain] = subKFold(...
                            Xpar1,Xpar2,...             
                            Ypar1,Ypar2,...             
                            scoresApar1,scoresApar2,...	
                            scoresBpar1,scoresBpar2,...	
                            scoresCpar1,scoresCpar2,... 
                            scoresDpar1,scoresDpar2,... 
                            labelPar1,labelPar2,...     
                            indPar1,indPar2,...         
                            ii);


            %W{kk,ii} = getFeatureSelectionWeight(trainData',lamb1,lamb2,2,lamb3,lamb3,lamb4);  

            %normW = sqrt(sum(W{kk,ii}.*W{kk,ii},2)); 
            %normW( normW <= meanDegree * mean(normW) )=0; 
            %SelectFeaIdx{kk,ii} = find(normW~=0); 
            %newTrainData = trainData(:,SelectFeaIdx{kk,ii}); 
            %newTestData = testData(:,SelectFeaIdx{kk,ii});
            %W{kk,ii}= Recover_weight(W{kk,ii},Is_zero_feature);
            
            newTrainData = trainData;
            newTestData = testData;

            [fsAcc(kk,ii),fsSen(kk,ii),fsSpec(kk,ii),fsPrec(kk,ii),maxFscore(kk,ii),fsAuc1(kk,ii),...
                            maxAcc1(kk,ii),minArmse1(kk,ii),maxBcc1(kk,ii),minBrmse1(kk,ii),maxCcc1(kk,ii),minCrmse1(kk,ii),maxDcc1(kk,ii),minDrmse1(kk,ii),...
                            Rs1{kk,ii},Ra1{kk,ii},Rb1{kk,ii},Rc1{kk,ii},Rd1{kk,ii}]=SVM_SVR(...
                            newTrainData,trainFlag,Atrain,Btrain,Ctrain,Dtrain,...
                            newTestData,testFlag,Atest,Btest,Ctest,Dtest,parc,parg);
        end
    end
    
    Res1=updateRes(Res1,fsAcc,fsSen,fsSpec,fsPrec,maxFscore,fsAuc1,...
                    maxAcc1,minArmse1,maxBcc1,minBrmse1,maxCcc1,minCrmse1,maxDcc1,minDrmse1,...
                    Rs1,Ra1,Rb1,Rc1,Rd1,lamb1,lamb2,lamb3,lamb4,SelectFeaIdx,W);
    
    
    if isequal(Res1.svmFscore_Lamb, [lamb1, lamb2, lamb3, lamb4])
        bestCombiNo = combiNo;
    end

    fprintf(fid, '\n');
    fprintf(fid, '================================\n');
    fprintf(fid, 'bestMetric: Acc: %f. Sen: %f. Auc: %f. Spec: %f. fScore: %f\n', Res1.svmAcc, Res1.svmSen, Res1.svmAuc, Res1.svmSpec, Res1.svmFscore);
    fprintf(fid, 'currentMetric: Acc: %f. Sen: %f. Auc: %f. Spec: %f. fScore: %f\n', mean(fsAcc(:)), mean(fsSen(:)), mean(fsAuc1(:)), mean(fsSpec(:)), mean(maxFscore(:)));
    fprintf(fid, 'currentCombiNo: %d bestCombiNo: %d\n', combiNo, bestCombiNo );
    fprintf(fid, 'acc_std: %f. fscore_std: %f\n', Res1.svmAcc_Std, Res1.svmFscore_Std);
    fprintf(fid, 'bestCombi: %f %f %f %f\n', Res1.svmFscore_Lamb);
    fprintf(fid, 'currentCombi: %f %f %f %f\n', lamb1, lamb2, lamb3, lamb4);
    fprintf(fid, '================================\n');
    

    

end
fclose(fid);
end