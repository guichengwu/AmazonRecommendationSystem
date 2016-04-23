tic;
clear;
fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/userProduct_baby.csv';
%fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/movie data set 1million/ratings.dat';
[userProductData, spMatrix] = BuildSPMatrix(fileName);
%[userProductData, spMatrix] = readDatFile(fileName);
[rows, columns]  = size(userProductData);
userNum = size(spMatrix, 1);
itemNum = size(spMatrix, 2);
fold = 5000;
userFold = round(userNum / fold);
randUserID = randsample(userNum, userFold);

similarityType = 'pearson';
%similarityType = 'cosine';
neighborSize = 30;
[eachUserAverageRate] = calUserAverageRate(userProductData, spMatrix);
correctNum = 0;
totalValidNum = 0;
totalErrorMAE = 0;
totalErrorRMSE = 0;
for i = 1:userFold
    specificUserID = randUserID(i);

    for j =1:itemNum
        if (spMatrix(specificUserID, j) ~= 0)
            if strcmp(similarityType,'pearson')
                [topUserSimilarity, topSimilarUserIndex] = findPearsonSimilarityUsers(...
              spMatrix, eachUserAverageRate, specificUserID, j, neighborSize);
            end
            
            if strcmp(similarityType, 'cosine')
               [topUserSimilarity, topSimilarUserIndex] = findCosineSimilarityUsers(...
              spMatrix, specificUserID, j, neighborSize);
            end      
                
            %predict Value
            tempSum = 0;
            for k = 1:neighborSize
                temp = topUserSimilarity(k) * (spMatrix(topSimilarUserIndex(k),j) ...
                    - eachUserAverageRate(topSimilarUserIndex(k)));
                tempSum = tempSum + temp;
            end
            predictRate = eachUserAverageRate(specificUserID) + tempSum / sum(topUserSimilarity);
            
            if (isnan(predictRate))
                predictRate = eachUserAverageRate(specificUserID);
            end
            % round the predict Rate
            predictRate = round(predictRate);
            %if the predicted value is larger than 5, set it to 5
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
fprintf('User Based cross validation. \n');
fprintf('pearson similarity \n');
fprintf('%f fold. \n', fold);
fprintf('%f neighborSize. \n', neighborSize);
fprintf('valid user number: %f . \n', userFold);
fprintf('total valid number: %f .\n', totalValidNum);
fprintf('total correct Number: %f .\n', correctNum);
fprintf('correctRate is: %f .\n',correctRate);
fprintf('avergae error MAE: %f .\n', aveErrorMAE);
fprintf('average error RMSE: %f .\n', aveErrorRMSE);

toc;