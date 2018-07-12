%% Load data
date = '20180706'; time = '000629';
data = DataScanSeq([date '_' time]);

%% Plot data
PlotLogics = { {[1,1],[2,1]}, {[1,2],[2,2]} };

fitvar = {'FitType',' a*exp(-x/c)','Start', [1, 10]};
%fitvar = {}; {'FitType','a + b*exp(-(x-c)^2/d^2)','Start', [0, 0.8, 0.3, .2]};
FitLogics= { {fitvar, fitvar}, {fitvar, fitvar} };

data.plotSurvival('PlotLogics', PlotLogics, ...
    'FitLogics', FitLogics);
