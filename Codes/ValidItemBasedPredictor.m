tic;
clear;
%fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/userProduct_baby.csv';
%fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/movie data set 100k/u.data';
fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/movie data set 1million/ratings.dat';
[userProductData, spMatrix] = readDatFile(fileName);
%[userProductData, spMatrix] = BuildSPMatrix(fileName);
[eachUserAverageRate] = calUserAverageRate(userProductData, spMatrix);
[eachItemAverageRate] = calItemAverageRate(userProductData, spMatrix);

[rows, columns]  = size(userProductData);
userNum = size(spMatrix, 1);
itemNum = size(spMatrix, 2);
fold = 2000;
userFold = round(userNum / fold);
randUserID = randsample(userNum, userFold);

%similarityType = 'cosine';
similarityType = 'pearson';

neighborSize = 5;

correctNum = 0;
totalValidNum = 0;
totalErrorMAE = 0;
totalErrorRMSE = 0;
for i = 1:userFold
    specificUserID = randUserID(i);
    
    for j =1:itemNum
        if (spMatrix(specificUserID, j) ~= 0)
           if strcmp(similarityType, 'cosine')
               [topItemVal, topItemIndex] = findCosineSimilarityItems(...
                   spMatrix, specificUserID, j, neighborSize);
           end
           
           if strcmp(similarityType, 'pearson')
               [topItemVal, topItemIndex] = findPearsonSimilarityItems(...
                   spMatrix, eachItemAverageRate, specificUserID, j, neighborSize);
           end
           
           tempSum = 0;
           for k = 1:neighborSize
               tempSum = tempSum + spMatrix(specificUserID, topItemIndex(k))*topItemVal(k);
           end
           
           predictRate = tempSum / sum(topItemVal);
           
           if (isnan(predictRate))
              predictRate = eachUserAverageRate(specificUserID);
           end
           
           predictRate = round(predictRate);
           if predictRate > 5
              predictRate = 5;
           end
           trueRate = spMatrix(specificUserID, j);
           
           totalValidNum = totalValidNum + 1;
            
           dif = abs(predictRate - trueRate);
            
           if (dif == 0)
             correctNum = correctNum + 1;
           end                 
           totalErrorMAE = totalErrorMAE + dif;
           totalErrorRMSE = totalErrorRMSE + dif^2;
        end
    end
end

correctRate = correctNum / totalValidNum;
aveErrorMAE = totalErrorMAE / totalValidNum;
aveErrorRMSE = totalErrorRMSE / totalValidNum;

fprintf('Item based cross Validation \n');
fprintf('Pearson similarity. \n');
fprintf('%d fold .\n', fold);
fprintf('%d neighborSize. \n', neighborSize);
fprintf('valid user number: %f . \n', userFold);
fprintf('total valid number: %f .\n', totalValidNum);
fprintf('total correct Number: %f .\n', correctNum);
fprintf('correctRate is: %f .\n',correctRate);
fprintf('avergae error MAE: %f .\n', aveErrorMAE);
fprintf('average error RMSE: %f .\n', aveErrorRMSE);

toc;
