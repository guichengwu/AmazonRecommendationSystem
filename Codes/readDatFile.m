function [userProductData, spMatrix] = readDatFile(fileName)
%file = '/Users/guichengwu/Desktop/ecs271_termProject/data/movie data set/ratings.dat';
[users, films, ratings, timeStamp] = textread(fileName, '%u::%u::%u::%s');
%[users, films, ratings, timeStamp] = textread(fileName, '%f|%f|%f|%s');
userProductData = [users, films, ratings];

spMatrix = spconvert(userProductData);

end