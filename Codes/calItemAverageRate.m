function [eachItemAverageRate] = calItemAverageRate(userProductData, spMatrix)
[rows, columns]  = size(userProductData);
[userNum, itemNum] = size(spMatrix);

eachItemSum = zeros(itemNum, 1);
eachItemCount = zeros(itemNum, 1);

for i=1:rows
    itemIndex = userProductData(i, 2);
    if (userProductData(i, 3) == 0)
        continue;
    end
    eachItemSum(itemIndex) = eachItemSum(itemIndex) + userProductData(i, 3);
    eachItemCount(itemIndex) = eachItemCount(itemIndex) + 1;
end

eachItemAverageRate = eachItemSum ./ eachItemCount;
end
    