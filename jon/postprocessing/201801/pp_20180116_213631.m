% Cs Ax2 and Na 'x' Scan
%% load
d = replot2([20180116, 213631]);
ParamsNa = [linspace(18.04, 18.26, 18), linspace(18.98, 19.24, 14), ...
        linspace(19.48, 19.74, 18)] * 1e6;
ParamsCs = linspace(-180, 250, 50) * 1e3; % Ax2,3 Full

%% Cs
i=1; %which scan?
m=2; %which survival?

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
SurvProb = SurvProb(m,:);
SurvProbErr = SurvProbErr(m,:);
Params = ParamsCs(Params);

figure(4); clf; set(gcf,'color','w');
errorbar( Params/1e3, SurvProb, SurvProbErr , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
title('Cs Ax2');
xlabel('Frequency (kHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);

%% Na
i=1; %which scan?
m=1; %which survival?

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
SurvProb = SurvProb(m,:);
SurvProbErr = SurvProbErr(m,:);
Params = ParamsNa(Params);

figure(5); clf; set(gcf,'color','w');
errorbar( Params/1e6, SurvProb, SurvProbErr , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
title('Na X');
xlabel('Frequency (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);