%% 20180115, 23340,  (2d76923)
Params1 = linspace(0.1, 800, 51) * 1e-6; %Ax1
Params2 = linspace(0.1, 400, 51) * 1e-6; %Ax2
Params3 = linspace(0.1, 400, 51) * 1e-6; %Ax3


clear o;
o(1).Params = Params1;
o(1).ParamName = 'TCsRaman1';
o(1).ParamUnits = 'us';
o(1).PlotScale = 1e-6;

o(2).Params = Params2;
o(3).Params = Params3;


file = [20180115, 233409];
savedata = 0;
d = SeparateMultipleScans(file, o, savedata);


%% Plot data using d output and plot_data()
% i=1;
% plot_data(d(i).Scan, d(i).Scan.Images, []);


%% Plot data using survival
i = 3; %which scan?
m = 2; %which survival?

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
SurvProb = SurvProb(m,:);
SurvProbErr = SurvProbErr(m,:);

figure(4); clf; set(gcf,'color','w');
errorbar( Params/1e-6, SurvProb, SurvProbErr , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
title('Cs Ax3');
xlabel('TCsRaman1');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);


%% Plot data by loading saved function
% file = [20180115, 164803];
% i = 1;
% replot2([20180115, 164803 + i]) 

 
%% fit to Gaussian
% ft = 'a*exp(-(x-b)^2/w^2) + os';
% fitcenter = 15;
% fitwidth = 20; 1e6;
% startPoints = [1 fitcenter  0 50];  %a, b, os, w
% 
% fitrange = fitcenter + fitwidth*[-1/2 1/2];
% xfit = Params/1e3;
% exclude = xfit < min(fitrange) | xfit > max(fitrange);
% fit_obj = fit(xfit', SurvProb', ft, ...
%       'Start', startPoints, 'Exclude', exclude)
% xplot = linspace( max(fitrange(1), min(xfit)), min(fitrange(2), max(xfit)), 200);
% hold on; plot(xplot, fit_obj(xplot), '-k'); hold off;
