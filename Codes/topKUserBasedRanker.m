tic;

%load movielens.mat;
fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/movie data set 1million/ratings.dat';
[userProductData, spMatrix] = readDatFile(fileName);
userID = 199;
K = 10;
[userNum, itemNum] = size(spMatrix);

[eachUserAverageRate] = calUserAverageRate(userProductData, spMatrix);

predictRates = zeros(itemNum, 1);
neighborSize = 5;

for j = 1:itemNum
    if (spMatrix(userID, j) ~= 0)
        predictRates(j) = 0;
    end
      [topUserSimilarity, topSimilarUserIndex] = findPearsonSimilarityUsers(...
        spMatrix, eachUserAverageRate, userID, j, neighborSize);    
%     [topUserSimilarity, topSimilarUserIndex] = findCosineSimilarityUsers(...
%       spMatrix, userID, j, neighborSize);
     %predict Value
     tempSum = 0;
     for n = 1:neighborSize
      temp = topUserSimilarity(n) * (spMatrix(topSimilarUserIndex(n),j) ...
        - eachUserAverageRate(topSimilarUserIndex(n)));
      tempSum = tempSum + temp;
     end
     predictRates(j) = eachUserAverageRate(userID) + tempSum / sum(topUserSimilarity);
     
     if (isnan(predictRates(j))) 
         predictRates(j) = eachUserAverageRate(userID);
     end
     
     if (predictRates(j) > 5)
         predictRates(j) = 5;
     end
end

[sortedPredictRate, itemIndices] = sort(predictRates, 'descend');   
topUserBasedItemIndices = itemIndices(1:K);

toc;
