function [topItemVal, topItemIndex] = findCosineSimilarityItems(spMatrix, specificUserID, specificItemID, neighborSize)
[userNum, itemNum] = size(spMatrix);
targetItems = find(spMatrix(specificUserID, :));
targetLength = length(targetItems);

% if (targetLength < neighborSize) 
%     fprintf('please make neighbor size smaller');
% end

similarity = zeros(itemNum, 1);
specificVector = spMatrix(:,specificItemID);
specificSum = sumsqr(specificVector);
for i = 1:length(targetItems)
    targetItemIndex = targetItems(i);
    
    %skip sepcific item
    if (targetItemIndex == specificItemID)
        continue;
    end
    
    itemVector = spMatrix(:,targetItemIndex);
    
    similarity(targetItemIndex) = (specificVector'*itemVector) / (specificSum*sumsqr(itemVector));
    if isnan(similarity(targetItemIndex))
        similarity(i) = -inf('single');
    end
end

[sortedItemSimilarity, itemIndex] = sort(similarity, 'descend');
topItemVal = sortedItemSimilarity(1:neighborSize);
topItemIndex = itemIndex(1:neighborSize);

end
