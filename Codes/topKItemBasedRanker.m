function [topItemIndices] = topKItemBasedRanker(userID, K)
tic;
clear;
fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/movie data set 1million/ratings.dat';
[userProductData, spMatrix] = readDatFile(fileName);
%load movielens.mat;

if ~exist('K', 'var')
  K = 10;
end


[userNum, itemNum] = size(spMatrix);

nonZeroIndices = find(spMatrix(userID, :));
userAverageRate = mean(spMatrix(userID, nonZeroIndices));


predictRates = zeros(itemNum, 1);
neighborSize = 5;
for j =1:itemNum
   if (spMatrix(userID, j) == 0)
     [topItemVal, topItemIndex] = findCosineSimilarityItems(spMatrix, userID, j, neighborSize);
     tempSum = 0;
     for n = 1:neighborSize 
         tempSum = tempSum + spMatrix(userID, topItemIndex(n))*topItemVal(n);
     end
     predictRates(j) = tempSum / sum(topItemVal);
     
     if isnan(predictRates(j))
         predictRates(j) = userAverageRate;
     end
     
     
     if predictRates(j) > 5
         predictRates(j) = 5;
     end
   else
       %The item has been seen by the user.
       predictRates(j) = 0;
   end 
   
   [sortedPredictRate, itemIndices] = sort(predictRates, 'descend');
   
   topItemIndices = itemIndices(1:K);
end

toc;
