%%   [20180118,165432],  (21840d5)
%  Grid scan of TMerge, and measuring L/R sideband for all three axes. 
% Scan uses GetValue function from YC. 

%% Separate files
ParamsNa1 = [18.16, 19.12];
ParamsNa2 = [18.14, 19.12];
ParamsNa3 = [18.51, 18.68];
ParamsCs1 = [-13.06, 62.04];
ParamsCs2 = [-127.1, 150]; %Alot of uncertainity fo cooling
ParamsCs3 = [-127.1, 150]; %Alot of uncertainity fo cooling

DeltafList = [0, 0.1, 0.2, 0.5, 1.0, 2.0];

Params = 1:length(DeltafList); %they should all be same length
clear o;
o(1).Params = DeltafList;
o(1).ParamName = 'Modulation bandwidth, Deltaf (MHz)';
o(1).ParamUnits = 'MHz';
o(1).PlotScale = 1;

o(2).Params = Params;
o(3).Params = Params;
o(4).Params = Params;
o(5).Params = Params;
o(6).Params = Params;

%file = [20180118, 165432]; % 500 kHz
%file = [20180118, 180659]; % 200 kHz
file = [20180118, 183854]; % 2 MHz

savedata = 0;
d = SeparateMultipleScans(file, o, savedata);
close all;

% Combine two-body/single-body data
for i = 1:length(d)
    bCombine = 1;
    if bCombine
        %     d(i).Scan.SurvivalLoadingLogicals = {[1, 2], [1, 2], [1, -2], [-1,2]};
        %     d(i).Scan.SurvivalLogicals = {[3], [4], [3], [4]};
        d(i).Scan.SurvivalLoadingLogicals = {[1], [2]};
        d(i).Scan.SurvivalLogicals = {[3], [4]};
        [Analysis, MeanLoads, ParamList] = plot_data(d(i).Scan, d(i).Scan.Images, '');
        d(i).Analysis = Analysis;
        close all;
    end
end

% Create figure
figure(4); clf; set(gcf,'color','w');


%% Na X left and right
subplot(2,3,1);
m=1; %which survival?  1,3 = Na, 2,4 = Cs. 

i=1; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
%Params = DeltafList(Params);

%figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);

i=i+1; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = DeltafList(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off; 
title('Na X');
xlabel('Modulation Depth (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);


%% Na Y left and right
subplot(2,3,2);
m=1; %which survival?  1,3 = Na, 2,4 = Cs. 

i=3; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = DeltafList(Params);

%figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);

i=i+1; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = DeltafList(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off; 
title('Na Y');
xlabel('Modulation Depth (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);


%% Na Z left and right
subplot(2,3,3);
m=1; %which survival?  1,3 = Na, 2,4 = Cs. 

i=5; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = DeltafList(Params);

%figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);

i=i+1; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = DeltafList(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off; 
title('Na Z');
xlabel('Modulation Depth (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);


%% Cs Ax1 X left and right
subplot(2,3,4);
m=2; %which survival?  1,3 = Na, 2,4 = Cs. 

i=1; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
%Params = DeltafList(Params);

%figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);

i=i+1; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = DeltafList(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off; 
title('Cs Ax1');
xlabel('Modulation Depth (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);


%% Cs Ax2 X left and right
subplot(2,3,5);
m=2; %which survival?  1,3 = Na, 2,4 = Cs. 

i=3; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = DeltafList(Params);

%figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);

i=i+1; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = DeltafList(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off; 
title('Cs Ax2');
xlabel('Modulation Depth (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);


%% Cs Ax3 X left and right
subplot(2,3,6);
m=2; %which survival?  1,3 = Na, 2,4 = Cs. 

i=5; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = DeltafList(Params);

%figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);

i=i+1; %which scan?
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = DeltafList(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off; 
title('Cs Ax3');
xlabel('Modulation Depth (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);
