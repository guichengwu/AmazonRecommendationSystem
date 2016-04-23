tic;
clear;
%fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/userProduct_baby.csv';
fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/movie data set 1million/ratings.dat';
[userProductData, spMatrix] = readDatFile(fileName);
%[userProductData, spMatrix] = BuildSPMatrix(fileName);
userNum = size(spMatrix, 1);
itemNum = size(spMatrix, 2);
[rows, columns]  = size(userProductData);
fold = 30;
userFold = round(userNum / fold);
randUserID = randsample(userNum, userFold);


overallAverageRate = sum(userProductData(:, 3)) / rows;
[eachUserAverageRate] = calUserAverageRate(userProductData, spMatrix);
%calculate bu
bu = zeros(userNum, 1);
for i=1:userNum
    nonZeroIndex = find(spMatrix(i, :));
    eachBu = mean(spMatrix(i, nonZeroIndex) - overallAverageRate);
    bu(i) = eachBu;
end

%calculate bi
bi = zeros(itemNum, 1);
for j=1:itemNum
    nonZeroIndex = find(spMatrix(:, j));
    eachbi = mean(spMatrix(nonZeroIndex, j) - bu(nonZeroIndex) - overallAverageRate);
    bi(j) = eachbi;
end

correctNum = 0;
totalValidNum = 0;
totalErrorMAE = 0;
totalErrorRMSE = 0;

for i = 1:userFold
    specificUserID = randUserID(i);
    for j = 1:itemNum
        if (spMatrix(specificUserID, j) ~= 0)
            predictRate = overallAverageRate + bu(specificUserID) + bi(j);
            
            if (isnan(predictRate))
                predictRate = eachUserAverageRate(specificUserID);
            end
            
            if (predictRate > 5)
                predictRate = 5;
            end
            
            predictRate = round(predictRate);
            
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

fprintf('Baseline predictor cross Validation \n');
fprintf('%d fold .\n', fold);
fprintf('valid user number: %f . \n', userFold);
fprintf('total valid number: %f .\n', totalValidNum);
fprintf('total correct Number: %f .\n', correctNum);
fprintf('correctRate is: %f .\n',correctRate);
fprintf('avergae error MAE: %f .\n', aveErrorMAE);
fprintf('average error RMSE: %f .\n', aveErrorRMSE);

toc;
