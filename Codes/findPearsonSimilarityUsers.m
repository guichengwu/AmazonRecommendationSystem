function [topUserSimilarity, topSimilarUserIndex] = findPearsonSimilarityUsers(spMatrix, eachUserAverageRate, specificUserID, specificItemID, neighborSize)
[userNum, itemNum] = size(spMatrix);
specificUserItems = find(spMatrix(specificUserID, :));
userSimilarity = zeros(userNum, 1);

for i = 1:userNum
    targetUser = find(spMatrix(:, specificItemID));
    if i == specificUserID || ~any(targetUser == i)  % skip the specific user or skip the user who never buy the specific item
        userSimilarity(i) = -inf('single'); % make it is impossible to choose
        continue;
    end
    
    userItems = find(spMatrix(i,:));
    intersectItems = intersect(specificUserItems, userItems);
    %if there are no intersectItems, set similarity equal to 0
    if isempty(intersectItems)
        userSimilarity(i) = 0;
        continue;
    end
    
    offset1 = spMatrix(specificUserID, intersectItems) - eachUserAverageRate(specificUserID);
    offset2 = spMatrix(i, intersectItems) - eachUserAverageRate(i);
    numerator = sum(offset1.*offset2);
    denominator = norm(offset1) * norm(offset2);
    
    userSimilarity(i) = numerator / denominator;
    
    if isnan(userSimilarity(i))
        userSimilarity(i) = -inf('single');
    end
    
end

[sortedUserSimilarity, userIndex] = sort(userSimilarity, 'descend');

topUserSimilarity = sortedUserSimilarity(1:neighborSize);
topSimilarUserIndex = userIndex(1:neighborSize);

end