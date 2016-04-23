tic;
%fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/userProduct_baby.csv';
fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/movie data set 1million/ratings.dat';
specificUserID =122;
specificItemID = 1000;
neighborSize = 10;
%similarityType = 'pearson';
similarityType = 'cosine';

[predictRate] = ItemBasedCFPredictor(fileName, ...
    specificUserID, specificItemID, neighborSize, similarityType);

fprintf(' item based predict rate is %f.\n', predictRate);
toc;