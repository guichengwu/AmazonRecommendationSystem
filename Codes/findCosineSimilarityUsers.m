function [topUserSimilarity, topSimilarUserIndex] = findCosineSimilarityUsers(spMatrix, specificUserID, specificItemID, neighborSize)
[userNum, itemNum] = size(spMatrix);
specificUserItems = find(spMatrix(specificUserID, :));
userSimilarity = zeros(userNum, 1);

for i = 1:userNum
    targetUser = find(spMatrix(:, specificItemID));
    if i == specificUserID || ~any(targetUser == i)  % skip the specific user or skip the user who never buy the specific item
        userSimilarity(i) = -inf; % make it is impossible to choose
        continue;
    end
    
    userItems = find(spMatrix(i,:));
    intersectItems = intersect(specificUserItems, userItems);
    
    if isempty(intersectItems)
        userSimilarity(i) = 0;
        continue;
    end
    specificValue = spMatrix(specificUserID, intersectItems);
    userValue = spMatrix(i, intersectItems);
    numerator = specificValue*userValue';
    denominator = norm(specificValue)*norm(userValue);
    
    userSimilarity(i) = numerator / denominator;
    
    if isnan(userSimilarity(i))
        userSimilarity(i) = -inf('single');
    end
end

[sortedUserSimilarity, userIndex] = sort(userSimilarity, 'descend');

topUserSimilarity = sortedUserSimilarity(1:neighborSize);
topSimilarUserIndex = userIndex(1:neighborSize);

end