%% 20180421_100215

%% Load VPAScan data
folder = 'N:\NaCsLab\Data';
f = load([folder '\20180421\' 'VPAScan_20180421_100215.mat']); % Description

filelist = f.filelist;
%VPATempList = f.VPATempList;
%VPAslope = f.VPAslopeWM; %WM
%VPAoffset = f.VPAoffsetWM; %WM
%fWavemeter = f.fWavemeter; %wavemeter frequencies
length(filelist)

%%% Load file data
clear data;
data = [];
wb = waitbar(0, ['Loading files 0/' num2str(length(filelist))]);
for m = 1 : length(filelist)

    try
        data = [data, DataScanSeq(filelist{m})];
    catch err
        fWavemeter(i) = [];
        VPATempList(i) = [];
    end
    waitbar(m/length(filelist), wb, ['Loading files ' num2str(m) '/' num2str(length(filelist))]);
end
close(wb);
%save('20180421_100215_local.mat', 'f', 'data', 'filelist', 'folder');

%% Get data
load('20180421_100215_local.mat');

%Change survival logics
for m = 1:length(data)
%     data(m) = data(m).modifyScan('SurvivalLoadingLogicals', {[1, 2], [1, 2], [1, 2]}, ...
%         'SurvivalLogicals', {[3], [4], [-3, -4]});
    data(m) = data(m).modifyScan('SurvivalLoadingLogicals', {[1, 2]}, ...
        'SurvivalLogicals', {[-3, -4]});
end


clearfig = 1; berror = 1;
clear x y yerr;
for i = 1 : data(1).Scan.NumSurvival
    for m = 1 : length(data)
        %i = 1; % which scan
        %scanFieldIdx = 1; %1 for Na, 2 for Cs
        [x(i,m,:), y(i,m,:), yerr(i,m,:)] = data(m).getSurvival(i);
    end
end
size(y);

% % Get the VPATemp axis (should be the same as VPATempList)
% VPATempList2 = [];
% for i = 1 : length(data)
%     VPATempList2 = [VPATempList2, data(i).ScanSeq.p.('VPATemp')];
% end
% Convert PA voltage to PA frequency using wavemeter calibration
%fPA = VPATempList*VPAslope + VPAoffset;
%fPA = fWavemeter; % use Wavemeter frequencies

%fPA = f.freqList;  %longer than data because didn't finish
% frqeuencies also in data(1).ScanSeq.p.fWavemeter
fPA = [];
for i = 1:length(data)
    fPA(i) =  data(i).ScanSeq.p.fWavemeter;
end

% Convert x, the DP frequency, to Two-photon frequency
%f2Photon = 2*squeeze(x(1,1,:));

% For plot titles
d = data(1); 

%
%TMergeWait = squeeze(x(1,1,:));
%TMergeWait = TMergeWait*1e3;

%% Plot PA 
% input:  fPA, and survival's y, yerr

figure(4);
set(gcf,'color','w');
clf;
ncol = data(1).Scan.NumSurvival;

for m = [1]
%TMergeWait(m)
for i = 1:ncol
      
    % format x(survival, which scan, DP frequency)
%     xplot = squeeze(x(i,m,:));
%     yplot = squeeze(y(i,m,:));
%     yerrplot = squeeze(yerr(i,m,:));
    
    xplot = fPA;
    yplot = squeeze(y(i,:,m));
    yerrplot = squeeze(yerr(i,:,m));
    
    % sort
    [xplot, idx] = sort(xplot);
    yplot = yplot(idx);
    yerrplot = yerrplot(idx); 
    
    subplot(1, ncol, i);
    berror = 1;
    xshift = 0; 0.298;
    hold on;
    if berror
        errorbar(xplot + xshift, yplot, yerrplot ,'.', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
    else
        plot(xplot + xshift,  yplot,'.-');
        ylim([0, 1]);
    end
    hold on;
    
    % fit data
    
    %         fitData(xplot + xshift,  yplot, 'a - b*exp(-(x-x0)^2/w^2)', ...
    %            'Start', [0.80, 0.3, 0.02, 698.632], 'Plot', 1);
    %fitData(xplot + xshift,  yplot, 'a - b*1/(1 + (x-x0)^2/w^2)', ...
    %    'Start', [0.80, 0.3, 0.03, 698.632], 'Plot', 1);
    fitData(xplot + xshift,  yplot, 'a + b*1/(1 + (x-x1)^2/(w1/2)^2) + c*1/(1 + (x-x2)^2/(w2/2)^2) ', ...
        'Start', [0.1, 0.4, 0.4, 0.05, 0.05, 698.59, 698.65], 'Plot', 1);
    
    % labels
    %title({['survival: ' logical_cond_2str(d.Scan.SurvivalLogicals{i},d.Scan.SingleAtomSpecies)], ...
    %            ['loading: ' logical_cond_2str(d.Scan.SurvivalLoadingLogicals{i},d.Scan.SingleAtomSpecies)]})
    %xlabel([d.Scan.ParamName, ' [', d.Scan.ParamUnits, ']'])
    %if i < ncol
        xlabel('288XXX (GHz)');
    %else
        xlabel({'288XXX (GHz)', [filelist{1}]},'interpreter', 'none');
    %end
    ylabel('Survival probability')
    box on
    %grid on
    hold off;
      
end
end


%%   Save
saveas(gcf,'20180421_100215_PAFigure.pdf')