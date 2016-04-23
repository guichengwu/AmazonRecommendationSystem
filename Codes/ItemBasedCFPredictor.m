function [predictRate] = ItemBasedCFPredictor(fileName, ...
    specificUserID, specificItemID, neighborSize, similarityType)
if ~exist('similarityType', 'var') 
    similarityType = 'cosine';
end
[userProductData, spMatrix] = readDatFile(fileName);
[userNum, itemNum] = size(spMatrix);
predictRate = 0;

if specificUserID > userNum || specificItemID > itemNum
    fprintf('The userID or itemID is out of bound! \n');
    return;
end

if strcmp(similarityType, 'cosine')
    [topItemVal, topItemIndex] = findCosineSimilarityItems(spMatrix, specificUserID, specificItemID, neighborSize);
end

tempSum = 0;
for i=1:neighborSize
    tempSum = tempSum + spMatrix(specificUserID, topItemIndex(i))*topItemVal(i);
end

predictRate = tempSum / sum(topItemVal);

%round predict Rate
predictRate = round(predictRate);

end