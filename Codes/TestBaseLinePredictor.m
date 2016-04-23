tic;
userIndex = 122;
itemIndex = 1000;
%fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/test_sparse.csv';
fileName = '/Users/guichengwu/Desktop/ecs271_termProject/data/movie data set 1million/ratings.dat';
predictRate = BaselinePredictor(fileName, userIndex, itemIndex);
predictRate
toc;