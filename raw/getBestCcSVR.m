function [maxCc,ccRmse,ccDec,ccTest,ccBest_X,ccBest_Y,minRmse]=...
    getBestCcSVR(matCc,matRmse,matDec,matTest)



    minRmse=min(matRmse(:));

    maxCc=max(matCc(:)); 
    seqIndex=find(matCc==maxCc); 
    [x,y]=ind2sub(size(matCc),seqIndex); 

    
    maxCc=[];
    ccRmse=[];
    ccDec=[];
    ccTest=[];
    ccBest_X=[];   
    ccBest_Y=[];   
    
    for i=1:length(x)  
        
        ccBest_X=[ccBest_X,x(i)];
        ccBest_Y=[ccBest_Y,y(i)];

        maxCc=[maxCc,matCc(x(i),y(i))];
        ccRmse=[ccRmse,matRmse(x(i),y(i))];
        ccDec=[ccDec,matDec(x(i),y(i))];
        ccTest=[ccTest,matTest(x(i),y(i))];
    end
    
    [~,maxMapIndex]=min(ccRmse(:)); 
    maxCc=maxCc(maxMapIndex);
    ccRmse=ccRmse(maxMapIndex);
    ccDec=ccDec{maxMapIndex};
    ccTest=ccTest{maxMapIndex};

    ccBest_X=ccBest_X(maxMapIndex);
    ccBest_Y=ccBest_Y(maxMapIndex);
end









