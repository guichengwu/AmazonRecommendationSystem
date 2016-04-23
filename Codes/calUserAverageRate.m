function [eachUserAverageRate] = calUserAverageRate(userProductData, spMatrix)
[rows, columns]  = size(userProductData);
[userNum, itemNum] = size(spMatrix);
%calculate each user's average rate
eachUserRateSum = zeros(userNum, 1);
eachUserRateCount = zeros(userNum, 1);
for i =1:rows
    userIndex = userProductData(i,1);
    if (userProductData(i, 3) == 0)
        continue;
    end
    eachUserRateSum(userIndex) = eachUserRateSum(userIndex) + userProductData(i, 3);
    eachUserRateCount(userIndex) = eachUserRateCount(userIndex) + 1;
end

eachUserAverageRate = eachUserRateSum ./ eachUserRateCount;

end