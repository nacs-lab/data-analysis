%%   [20180116,232721],  (79513c9)
%  3 axes, 2 atoms RSC after no merging.   

%% Separate files
ParamsNa1 = [linspace(18.04, 18.26, 18), linspace(18.98, 19.24, 14), ...
    linspace(19.48, 19.74, 18)];  %X
ParamsNa2 = [linspace(18.04, 18.26, 18), linspace(18.98, 19.24, 14), ...
    linspace(19.48, 19.74, 18)]; %Y
ParamsNa3 = linspace(18.46, 18.80, 50); %Z
ParamsCs1 = linspace(0, 80, 50); %Ax1
ParamsCs2 = [linspace(-180, -80, 18), linspace(-25, 50, 14), ...
    linspace(100, 200, 18) ]; % Ax2
ParamsCs3 = [linspace(-180, -80, 18), linspace(-25, 50, 14), ...
    linspace(100, 200, 18) ]; % Ax3

Params = 1:length(ParamsNa1); %they should all be same length
clear o;
o(1).Params = Params;
o(1).ParamName = 'Raman1Det';
o(1).ParamUnits = '1';
o(1).PlotScale = 1;

o(2).Params = Params;
o(3).Params = Params;


file = [20180116, 232721];
savedata = 0;
d = SeparateMultipleScans(file, o, savedata);


%% Na X
i=1; %which scan?
m=1; %which survival?  1 = Na, 2 = Cs. 

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsNa1(Params);
SurvProb = SurvProb(m,:);
SurvProbErr = SurvProbErr(m,:);


figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb, SurvProbErr , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
title('Na X');
xlabel('Frequency (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);

%% Na Y
i=2; %which scan?
m=1; %which survival?  1 = Na, 2 = Cs. 

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsNa2(Params);
SurvProb = SurvProb(m,:);
SurvProbErr = SurvProbErr(m,:);


figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb, SurvProbErr , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
title('Na Y');
xlabel('Frequency (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);

%% Na Z
i=3; %which scan?
m=1; %which survival?  1 = Na, 2 = Cs. 

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsNa3(Params);
SurvProb = SurvProb(m,:);
SurvProbErr = SurvProbErr(m,:);


figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb, SurvProbErr , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
title('Na Z');
xlabel('Frequency (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);

%% Cs Ax1
i=1; %which scan?
m=2; %which survival?  1 = Na, 2 = Cs. 

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsCs1(Params);
SurvProb = SurvProb(m,:);
SurvProbErr = SurvProbErr(m,:);


figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb, SurvProbErr , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
title('Cs Ax1');
xlabel('Frequency (kHz)');
ylabel('Survival');
grid on;
ylim([0 1]);

%% Cs Ax2
i=2; %which scan?
m=2; %which survival?  1 = Na, 2 = Cs. 

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsCs2(Params);
SurvProb = SurvProb(m,:);
SurvProbErr = SurvProbErr(m,:);


figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb, SurvProbErr , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
title('Cs Ax2');
xlabel('Frequency (kHz)');
ylabel('Survival');
grid on;
ylim([0 1]);


%% Cs Ax3
i=3; %which scan?
m=2; %which survival?  1 = Na, 2 = Cs. 

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsCs3(Params);
SurvProb = SurvProb(m,:);
SurvProbErr = SurvProbErr(m,:);


figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb, SurvProbErr , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
title('Cs Ax3');
xlabel('Frequency (kHz)');
ylabel('Survival');
grid on;
ylim([0 1]);