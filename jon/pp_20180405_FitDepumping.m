file = [20180406, 155205];
data = DataScanSeq(file);
[x,y,yerr] = data.getSurvival(2);
scale = 1;

figure;
errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
titles = {'Depumping misaligned'}
title( titles{1} );
xlabel('TCsOP2 (ms)');
ylabel('Survival');
grid on;
ylim([0 1]);
ft = fitData(x/scale, y, 'a - b*exp(-x/c)', ...
    'Start', [1, 1, .1], 'Plot', 1, 'FitRange', [0, 20]);
