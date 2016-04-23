%Build sparse matrix
function [userProductData, spMatrix] = BuildSPMatrix(fileName)
% The first column is UserID, the second column is the productID, the third
% column is the rate
%read user and product matrix
userProductData = csvread(fileName);
%userProductData = [userProductData(:,2), userProductData(:,1), userProductData(:,3)];
userProductData = sortrows(userProductData, 1);
% the rows are users, the columns are products
spMatrix = spconvert(userProductData);
end