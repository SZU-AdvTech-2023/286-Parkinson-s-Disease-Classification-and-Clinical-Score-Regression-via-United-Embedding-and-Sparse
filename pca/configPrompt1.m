meanSelect=0.2;
svmParc=-10:1:10; 
svmParg=-5:1:5;


regScoreSelect={'depScores','sleepScores','smellScores','MoCAScores'}; 
csfSelect{4}={''};
regScoreSelect=[regScoreSelect,csfSelect{4}];


isYscoresCentering = 1;


kFold = 1;
subFold = 10;


% t1=[1 3 5 7]; parsLambda1 = 10.^t1;
% t2=[120 160 200 240];  parsLambda2 = t2; 
% t3=[2 4 6 8 10];  parsLambda3 = t3;
% t4=0.1:0.3:1.9;  parsLambda4 = t4;

% t1=[0 1 5 6]; parsLambda1 = 10.^t1;
% t2=[100 160 240]; parsLambda2 = t2;
% t3=[1 5 10]; parsLambda3 = t3;
% t4=[0.1 1 1.9]; parsLambda4 = t4;

parsLambda1 = 1000; 
parsLambda2 = 200;
parsLambda3 = 4;
parsLambda4 = 0.1;

parsIte=50;

groupSelect={'isNC','isPD','NC','PD'};
mergeDataSelect={'X1','L1','V1'};

workFunction( ...
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