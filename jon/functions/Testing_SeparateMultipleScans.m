%% Testing new function
Params1 = [linspace(18.04, 18.26, 18), linspace(18.98, 19.24, 14), ...
           linspace(19.48, 19.74, 14)] * 1e6;
Params2 = [linspace(18.04, 18.26, 18), linspace(18.98, 19.24, 14), ...
           linspace(19.48, 19.74, 14)] * 1e6;
Params3 = linspace(18.46, 18.80, 69) * 1e6;

clear o;
o(1).Params = Params1;
o(1).ParamName = 'NaRaman1Det';
o(1).ParamUnits = 'MHz';
o(1).PlotScale = 1e6;

o(2).Params = Params2;
o(3).Params = Params3;


file = [20180115, 164803];
savedata = 0;
d = SeparateMultipleScans(file, o, savedata);



%% Plot data using d output and plot_data()
i=1;
plot_data(d(i).Scan, d(i).Scan.Images, []);


%% Plot data using survival
i=1; %which scan?
m=1; %which survival?

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;

figure(4);
errorbar( Params/1e6, SurvProb(m,:), SurvProbErr(m,:) , '.-');
title('X Spectrum');
xlabel('Frequency (MHz)');
ylabel('Survival');

%% Plot data by loading saved function
% file = [20180115, 164803];
% i = 1;
% replot2([20180115, 164803 + i]) 

