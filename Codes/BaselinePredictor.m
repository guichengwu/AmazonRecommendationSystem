function [predictRate] = BaselinePredictor(fileName, userIndex, itemIndex)

%[userProductData, spMatrix] = BuildSPMatrix(fileName);
[userProductData, spMatrix] = readDatFile(fileName);
[rows, columns]  = size(userProductData);
% Calculate the overall average rate
overallAverageRate = sum(userProductData(:, 3)) / rows;

[spMatrixRows, spMatrixColumns] = size(spMatrix);

%calculate bu
bu = zeros(spMatrixRows, 1);
for i=1:spMatrixRows
    nonZeroIndex = find(spMatrix(i, :));
    eachBu = mean(spMatrix(i, nonZeroIndex) - overallAverageRate);
    bu(i) = eachBu;
end

%calculate bi 
bi = zeros(spMatrixColumns, 1);
for j=1:spMatrixColumns
    nonZeroIndex = find(spMatrix(:, j));
    eachbi = mean(spMatrix(nonZeroIndex, j) - bu(nonZeroIndex) - overallAverageRate);
    bi(j) = eachbi;
end

if (userIndex <= spMatrixRows) && (itemIndex <= spMatrixColumns)
      predictRate = overallAverageRate + bu(userIndex) + bi(itemIndex);
else
    predictRate = 0;
end

predictRate = round(predictRate);

end




