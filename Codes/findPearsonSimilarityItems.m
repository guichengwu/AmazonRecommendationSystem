function [topItemVal, topItemIndex] = findPearsonSimilarityItems(spMatrix, eachItemAverageRate, specificUserID, specificItemID, neighborSize)
[userNum, itemNum] = size(spMatrix);
itemSimilarity = zeros(itemNum, 1);
specificUsers = find(spMatrix(:, specificItemID));


targetItems = find(spMatrix(specificUserID, :));
for j=1:itemNum
    if j == specificItemID || ~any(targetItems == j)
        itemSimilarity(j) = -inf('single');
        continue;
    end
    
    users = find(spMatrix(:, j));
    intersectUsers = intersect(specificUsers, users);
    
    if isempty(intersectUsers)
        itemSimilarity(j) = 0;
    end
    
    offset1 = spMatrix(intersectUsers, specificItemID) - eachItemAverageRate(specificItemID);
    offset2 = spMatrix(intersectUsers, j) - eachItemAverageRate(j);
    numerator = sum(offset1.*offset2);
    denominator = norm(offset1) * norm(offset2);
    
    itemSimilarity(j) = numerator / denominator;
    
    if isnan(itemSimilarity(j))
        itemSimilarity(j) = -inf('single');
    end      
end

[sortItemSimilarity, itemIndex] = sort(itemSimilarity, 'descend');
topItemVal = sortItemSimilarity(1:neighborSize);
topItemIndex = itemIndex(1:neighborSize);
end