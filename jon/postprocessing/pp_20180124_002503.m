%%   [20180124_002503], (f9b12c65) 
%  3 axes, 2 atoms RSC WIHOUT mergine. .
%This data has 2 survival.    

%% Separate files
pts = 16;
ParamsNa1 = [linspace(18.11, 18.20, pts), linspace(19.05, 19.20, pts)]; % X
ParamsNa2 = [linspace(18.10, 18.20, pts), linspace(19.04, 19.20, pts)]; % Y
ParamsNa3 = [linspace(18.49, 18.545, pts), linspace(18.66, 18.71, pts)]; % Z
ParamsCs1 = [linspace(5, 25, pts), linspace(50, 75, pts)]; % Ax1
ParamsCs2 = [linspace(-180, -80, pts), linspace(100, 200, pts) ]; % Ax2
ParamsCs3 = [linspace(-180, -80, pts), linspace(100, 200, pts) ]; % Ax3


Params = 1:length(ParamsNa1); %they should all be same length
clear o;
o(1).Params = Params;
o(1).ParamName = 'Raman1Det';
o(1).ParamUnits = '1';
o(1).PlotScale = 1;

o(2).Params = Params;
o(3).Params = Params;
o(4).Params = Params;
o(5).Params = Params;
o(6).Params = Params;

file = [20180124, 002503];
savedata = 0;
d = SeparateMultipleScans(file, o, savedata);
close all;

%%  Combine two-body/single-body data
bCombine = 0;
if bCombine
    for i = 1:length(d)
        
        %     d(i).Scan.SurvivalLoadingLogicals = {[1, 2], [1, 2], [1, -2], [-1,2]};
        %     d(i).Scan.SurvivalLogicals = {[3], [4], [3], [4]};
        d(i).Scan.SurvivalLoadingLogicals = {[1], [2]};
        d(i).Scan.SurvivalLogicals = {[3], [4]};
        [Analysis, MeanLoads, ParamList] = plot_data(d(i).Scan, d(i).Scan.Images, '');
        d(i).Analysis = Analysis;
        close all;
    end
end

%% Na X
figure(4); clf; set(gcf,'color','w');
subplot(2,3,1);
i=1 + 0*3; %which scan?
m=1; %which survival?  1,3 = Na, 2,4 = Cs. 

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsNa1(Params);
%SurvProb = SurvProb(m,:);
%SurvProbErr = SurvProbErr(m,:);
%SurvProb = (SurvProb(m,:) + SurvProb(m+2,:))/2; %average both
%SurvProbErr = SurvProbErr(m,:);


errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
% if ~bCombine
%     hold on;
%     errorbar( Params, SurvProb(m+2,:), SurvProbErr(m+2,:) , '.-', 'CapSize', 2,...
%         'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
%     hold off;
% end

i=i+3; %which scan?
m=1; %which survival?  1,3 = Na, 2,4 = Cs.
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsNa1(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off;

title('Na X');
xlabel('Frequency (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);

%% Na Y
subplot(2,3,2);
i=2 + 0*3; %which scan?
m=1; %which survival?  1,3 = Na, 2,4 = Cs. 

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsNa2(Params);
%SurvProb = SurvProb(m,:);
%SurvProbErr = SurvProbErr(m,:);
%SurvProb = (SurvProb(m,:) + SurvProb(m+2,:))/2; %average both
%SurvProbErr = SurvProbErr(m,:);


errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
% if ~bCombine
%     hold on;
%     errorbar( Params, SurvProb(m+2,:), SurvProbErr(m+2,:) , '.-', 'CapSize', 2,...
%         'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
%     hold off;
% end

i=i+3; %which scan?
m=1; %which survival?  1,3 = Na, 2,4 = Cs.
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsNa2(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off;

title('Na Y');
xlabel('Frequency (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);

%% Na Z
subplot(2,3,3);
i=3 + 0*3; %which scan?
m=1; %which survival?  1 = Na, 2 = Cs. 


SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsNa3(Params);
% SurvProb = SurvProb(m,:);
% SurvProbErr = SurvProbErr(m,:);


%figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
% if ~bCombine
%     hold on;
%     errorbar( Params, SurvProb(m+2,:), SurvProbErr(m+2,:) , '.-', 'CapSize', 2,...
%         'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
%     hold off;
% end

i=i+3; %which scan?
m=1; %which survival?  1,3 = Na, 2,4 = Cs.
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsNa3(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off;

title('Na Z');
xlabel('Frequency (MHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);

%% Cs Ax1
subplot(2,3,4);
i=1 + 0*3; %which scan?
m=2; %which survival?  1 = Na, 2 = Cs. 


SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsCs1(Params);
% SurvProb = SurvProb(m,:);
% SurvProbErr = SurvProbErr(m,:);


%figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
% if ~bCombine
%     hold on;
%     errorbar( Params, SurvProb(m+2,:), SurvProbErr(m+2,:) , '.-', 'CapSize', 2,...
%         'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
%     hold off;
% end
i=i+3; %which scan?
m=2; %which survival?  1,3 = Na, 2,4 = Cs.
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsCs1(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off;

title('Cs Ax1');
xlabel('Frequency (kHz)');
ylabel('Survival');
grid on;
ylim([0 1]);

%% Cs Ax2
subplot(2,3,5);
i=2 + 0*3; %which scan?
m=2; %which survival?  1 = Na, 2 = Cs. 


SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsCs2(Params);
% SurvProb = SurvProb(m,:);
% SurvProbErr = SurvProbErr(m,:);


%figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
% if ~bCombine
%     hold on;
%     errorbar( Params, SurvProb(m+2,:), SurvProbErr(m+2,:) , '.-', 'CapSize', 2,...
%         'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
%     hold off;
% end
i=i+3; %which scan?
m=2; %which survival?  1,3 = Na, 2,4 = Cs.
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsCs2(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off;

title('Cs Ax2');
xlabel('Frequency (kHz)');
ylabel('Survival');
grid on;
ylim([0 1]);


%% Cs Ax3
subplot(2,3,6);
i= 3 + 0*3; %which scan?
m=2; %which survival?  1 = Na, 2 = Cs. 

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsCs3(Params);
% SurvProb = SurvProb(m,:);
% SurvProbErr = SurvProbErr(m,:);


%figure(4); clf; set(gcf,'color','w');
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
% if ~bCombine
%     hold on;
%     errorbar( Params, SurvProb(m+2,:), SurvProbErr(m+2,:) , '.-', 'CapSize', 2,...
%         'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
%     hold off;
% end
i=i+3; %which scan?
m=2; %which survival?  1,3 = Na, 2,4 = Cs.
SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
Params = ParamsCs3(Params);
hold on;
errorbar( Params, SurvProb(m,:), SurvProbErr(m,:) , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
hold off;

title('Cs Ax3');
xlabel('Frequency (kHz)');
ylabel('Survival');
grid on;
ylim([0 1]);

%% Put file name
xlabel( d(1).Scan.IDString );