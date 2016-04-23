%line graph
%movie lens
% neighborSize = [1, 5, 10, 15, 20, 25, 30];
% itemBasedCorrectRate = [0.2784, 0.3281, 0.3448, 0.3381, 0.3048, 0.2782, 0.2743];
% userBasedCorrectRate = [0.3834,0.4671, 0.5189, 0.4677, 0.4984, 0.5422,0.4437];
% figure;
% plot(neighborSize, itemBasedCorrectRate,'-o', neighborSize, userBasedCorrectRate, '-s');
% title('\fontsize{16} Correct rate: item-item vs user-user');
% legend('Item-Item based', 'User-User based', 'location', 'northwest');
% xlabel('Neighborhood size','FontSize',12,'FontWeight','bold');
% ylabel('Correct rate', 'FontSize', 12, 'FontWeight', 'bold');
% 
% %MAE bar graph
% figure;
% MAE = [1.184,0.753; 0.912,0.603; 0.891,0.519; 0.859,0.615; 0.966,0.544; 0.990,0.542; 1.061,0.619];
% bar(neighborSize, MAE, 'LineWidth', 2);
% title('\fontsize{16} MAE: item-item vs user- user');
% legend('Item-Item based', 'User-User based', 'location', 'northeast');
% xlabel('Neighborhood size','FontSize',12,'FontWeight','bold');
% ylabel('MAE', 'FontSize', 12, 'FontWeight', 'bold');
% 
% %RMSE bar graph
% figure;
% RMSE = [2.446,1.064; 1.473,0.749; 1.442,0.592; 1.287,0.781; 1.597,0.631; 1.612,0.668; 1.878,0.755];
% bar(neighborSize, RMSE, 'LineWidth', 2);
% title('\fontsize{16} RMSE: item-item vs user- user');
% legend('Item-Item based', 'User-User based', 'location', 'northeast');
% xlabel('Neighborhood size','FontSize',12,'FontWeight','bold');
% ylabel('RMSE', 'FontSize', 12, 'FontWeight', 'bold');

foldSize = [5, 10, 15, 20, 25, 30];
baselineCorrectRate = [0.4271   0.4207   0.4283    0.4210      0.4153      0.4267];
baselineddddddddMAE = [0.6761   0.6980    0.6744    0.6883     0.6949     0.6806];
baselinedddddddRMSE = [0.9033   0.9606    0.8984     0.9295    0.9329     0.9167];

figure;
plot(foldSize, baselineCorrectRate,'-o');
ylim([0 1]);
title('\fontsize{16} Sensitivity of fold size: baseline predictor');
legend('baseline predictor', 'location', 'northwest');
xlabel('fold size','FontSize',12,'FontWeight','bold');
ylabel('Correct rate', 'FontSize', 12, 'FontWeight', 'bold');

figure;
bar(foldSize, baselineMAE, 'LineWidth', 2);
ylim([0 1.2]);
title('\fontsize{16} Sensitivity of fold size: baseline predictor');
legend('baseline predictor', 'location', 'northeast');
xlabel('fold size','FontSize',12,'FontWeight','bold');
ylabel('MAE', 'FontSize', 12, 'FontWeight', 'bold');
figure;
bar(foldSize, baselineRMSE, 'LineWidth', 2);
ylim([0 1.2]);
title('\fontsize{16} Sensitivity of fold size: baseline predictor');
legend('baseline predictor', 'location', 'northeast');
xlabel('fold size','FontSize',12,'FontWeight','bold');
ylabel('RMSE', 'FontSize', 12, 'FontWeight', 'bold');


neighborSize = [1, 5, 10, 15, 20, 25, 30];
userBasedCorrectRate = [0.3834,0.4671,  0.5189, 0.4677, 0.4984, 0.5422, 0.4437];
userBasedMAEeeeeeeee = [0.7530; 0.6030; 0.5190; 0.6150; 0.5440; 0.5420; 0.6190];
userBasedRMSEeeeeeee = [1.0640; 0.7490; 0.5920; 0.7810; 0.6310; 0.6680; 0.7550];


itemBasedCorrectRate = [0.2784, 0.3281, 0.3448, 0.3381, 0.3048, 0.2782, 0.2743];
itemBasedMAEeeeeeeee = [1.1840; 0.9120; 0.8910; 0.8590; 0.9660; 0.9900; 1.0610];
itemBasedRMSEeeeeeee = [2.4460; 1.4730; 1.4420; 1.2870; 1.5970; 1.6120; 1.8780];


MAE = [1.184,0.753; 0.912,0.603; 0.891,0.519; 0.859,0.615; 0.966,0.544; 0.990,0.542; 1.061,0.619];
RMSE = [2.446,1.064; 1.473,0.749; 1.442,0.592; 1.287,0.781; 1.597,0.631; 1.612,0.668; 1.878,0.755];