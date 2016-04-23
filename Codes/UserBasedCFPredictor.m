function [predictRate] = UserBasedCFPredictor(fileName, ...
    specificUserID, specificItemID, neighborSize, similarityType)

if ~exist('similarityType', 'var') 
    similarityType = 'pearson';
end

%[userProductData, spMatrix] = BuildSPMatrix(fileName);
[userProductData, spMatrix] = readDatFile(fileName);
[rows, columns]  = size(userProductData);
[userNum, itemNum] = size(spMatrix);
%init predict value
predictRate = 0;

if specificUserID > userNum || specificItemID > itemNum
    fprintf('The userID or itemID is out of bound! \n');
    return;
end

if spMatrix(specificUserID, specificItemID) ~= 0
    fprintf('we already have the rate value.\n');
    predictRate = spMatrix(specificUserID, specificItemID);
    return;
end

[eachUserAverageRate] = calUserAverageRate(userProductData, spMatrix);

if strcmp(similarityType,'pearson')
  [topUserSimilarity, topSimilarUserIndex] = findPearsonSimilarityUsers(...
    spMatrix, eachUserAverageRate, specificUserID, specificItemID, neighborSize);
end

if strcmp(similarityType,'cosine')
  [topUserSimilarity, topSimilarUserIndex] = findCosineSimilarityUsers(...
      spMatrix, specificUserID, specificItemID, neighborSize);
end
% if there are not enough neighorhoods, tell the user to make the neighbor
% size smaller
if any(topUserSimilarity == -inf)
    fprintf('the neighborhood size is too large, plase adjust it. \n');
    return;
end

%predict Value
tempSum = 0;
for i = 1:neighborSize
    temp = topUserSimilarity(i) * (spMatrix(topSimilarUserIndex(i),specificItemID) ...
        - eachUserAverageRate(topSimilarUserIndex(i)));
    tempSum = tempSum + temp;
end

predictRate = eachUserAverageRate(specificUserID) + tempSum / sum(topUserSimilarity);

% round the predict Rate
predictRate = round(predictRate);
%if the predicted value is larger than 5, set it to 5
if predictRate > 5
    predictRate = 5;
end

end


