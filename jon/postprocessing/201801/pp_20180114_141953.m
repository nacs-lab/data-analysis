%% Data analysis for [20180114, 141953]  (97b551b)

Params1 = linspace(0, 200, 41) * 1e-6;
Params2 = linspace(4, 160, 40) * 1e-6;
Params3 = linspace(6, 240, 40) * 1e-6;

clear o;
o(1).Params = Params1;
o(1).ParamName = 'TNaRaman1 ';
o(1).ParamUnits = 'us';
o(1).PlotScale = 1e-6;

o(2).Params = Params2;
o(3).Params = Params3;


file = [20180114, 141953];
savedata = 0;
d = SeparateMultipleScans(file, o, savedata);


%% Plot data using d output and plot_data()
i=1;
plot_data(d(i).Scan, d(i).Scan.Images, []);


%% X axis 
i=1; %which scan?
m=1; %which survival?

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;

figure(4); set(gcf,'color','w');
errorbar( Params/o(i).PlotScale, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
title('X');
xlabel('Time (us)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
