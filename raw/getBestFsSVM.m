function [fsAcc,fsSen,fsSpec,fsPrec,fsAuc,maxFscore,fsLdec,fsLtest,fsTP,fsFP,fsBest_X,fsBest_Y,maxAuc,aucLdec,aucLtest,aucTP,aucFP,aucBest_X,aucBest_Y]=...
    getBestFsSVM(matAcc,matSen,matSpec,matPrec,matAuc,matFscore,matLdec,matLtest,matTP,matFP)


    % -------------------- AUC -----------------------------
    [maxAuc,maxAucIndex]=max(matAuc(:)); 
    [aucBest_X,aucBest_Y]=ind2sub(size(matAuc),maxAucIndex); 
    aucLdec=matLdec{aucBest_X,aucBest_Y};
    aucLtest=matLtest{aucBest_X,aucBest_Y};
    aucTP=matTP{aucBest_X,aucBest_Y};
    aucFP=matFP{aucBest_X,aucBest_Y};
    
    
    % -------------------- Fscore -----------------------------
    maxFscore=max(matFscore(:)); 
    seqIndex=find(matFscore==maxFscore); 
    [x,y]=ind2sub(size(matFscore),seqIndex); 

    
    maxFscore=[];
    fsAcc=[];
    fsSen=[];
    fsSpec=[];
    fsPrec=[];   
    fsAuc=[];
    fsLdec={};
    fsLtest={};
    fsTP={};
    fsFP={};
    
    fsBest_X=[];   
    fsBest_Y=[];   
    for i=1:length(x)  
        
        
        fsBest_X=[fsBest_X,x(i)];
        fsBest_Y=[fsBest_Y,y(i)];
        
        maxFscore=[maxFscore,matFscore(x(i),y(i))];
        fsAcc=[fsAcc,matAcc(x(i),y(i))];        
        fsSen=[fsSen,matSen(x(i),y(i))];
        fsSpec=[fsSpec,matSpec(x(i),y(i))];
        fsPrec=[fsPrec,matPrec(x(i),y(i))];        
        fsAuc=[fsAuc,matAuc(x(i),y(i))];
        
        fsLdec=[fsLdec,matLdec{x(i),y(i)}];
        fsLtest=[fsLtest,matLtest{x(i),y(i)}];
        fsTP=[fsTP,matTP{x(i),y(i)}];
        fsFP=[fsFP,matFP{x(i),y(i)}];
    end
    
    [~,maxMapIndex]=max(fsAcc(:)); 
    maxFscore=maxFscore(maxMapIndex);
    fsAcc=fsAcc(maxMapIndex);
    fsSen=fsSen(maxMapIndex);
    fsSpec=fsSpec(maxMapIndex);
    fsPrec=fsPrec(maxMapIndex);   
    fsAuc=fsAuc(maxMapIndex);
    
    fsLdec=fsLdec{maxMapIndex};
    fsLtest=fsLtest{maxMapIndex};
    fsTP=fsTP{maxMapIndex};
    fsFP=fsFP{maxMapIndex};
    
    fsBest_X=fsBest_X(maxMapIndex);
    fsBest_Y=fsBest_Y(maxMapIndex);

end









