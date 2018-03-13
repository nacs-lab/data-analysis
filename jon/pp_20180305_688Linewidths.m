%pp_20180305_688Linewidths
%VPAScan_20180305_102300
%% Load VPAScan data
folder = 'N:\NaCsLab\Data';
clearfig = 1; berror = 1;
%f = load([folder '\20180305\' 'VPAScan_20180305_102300.mat']); % Description
%f = load([folder '\20180305\' 'VPAScan_20180305_144450.mat']); % Description
%f = load([folder '\20180305\' 'VPAScan_20180305_155757.mat']); % Description
%f = load([folder '\20180305\' 'VPAScan_20180305_170453.mat']); % Description
%f = load([folder '\20180305\' 'VPAScan_20180305_181334.mat']); % Description
f = load([folder '\20180305\' 'VPAScan_20180305_191310.mat']); % Description
filelist = f.filelist;
VPATempList = f.VPATempList;
VPAslope = f.VPAslopeWM; %WM
VPAoffset = f.VPAoffsetWM; %WM
fWavemeter = f.fWavemeter; %wavemeter frequencies
length(filelist)

%%% Load file data
clear data;
for m = 1 : length(filelist)
    data(m) = DataScanSeq(filelist{m});
end


%%% Get data
clearfig = 1; berror = 1;
clear x y yerr;
for i = 1 : data(1).Scan.NumSurvival
    survival = i;
    for m = 1 : length(data)
        %i = 1; % which scan
        %scanFieldIdx = 1; %1 for Na, 2 for Cs
        [x(i,m,:), y(i,m,:), yerr(i,m,:)] = data(m).getSurvival(survival);
    end
end
size(y);

% Get the VPATemp axis (should be the same as VPATempList)
VPATempList2 = [];
for i = 1 : length(data)
    VPATempList2 = [VPATempList2, data(i).ScanSeq.p.('VPATemp')];
end
% Convert PA voltage to PA frequency using wavemeter calibration
%fPA = VPATempList*VPAslope + VPAoffset;
fPA = fWavemeter; % use Wavemeter frequencies

% Convert x, the DP frequency, to Two-photon frequency
%f2Photon = 2*squeeze(x(1,1,:));

% For plot titles
d = data(1); 


%% Plot 
%  fPA, and survival's y, yerr

figure(4);
set(gcf,'color','w');
clf;
ncol = data(1).Scan.NumSurvival;
m=1;

for i = 1:ncol
      
    % format x(survival, which scan, DP frequency)
%     xplot = squeeze(x(i,m,:));
%     yplot = squeeze(y(i,m,:));
%     yerrplot = squeeze(yerr(i,m,:));
    
    xplot = fPA;
    yplot = squeeze(y(i,:,m));
    yerrplot = squeeze(yerr(i,:,m));
    
    
    subplot(1, ncol, i);
    berror = 1;
    hold on;
    if berror
        errorbar(xplot, yplot, yerrplot ,'.');
    else
        plot(xplot,  yplot,'.-');
    end
    % Fit
%    ft = fitData(xplot, yplot, 'a*(gamma/2)^2/((x-b)^2+(gamma/2)^2) + c', 'Start', [-0.02, 688.685, 0.75, 0.03] , 'Plot', 1); 
    %gamma is FWHM
    ft = fitData(xplot, yplot, 'a*(gamma/2)^2/((x-b)^2+(gamma/2)^2) + c', 'Start', [-0.02, 688.685, 0.75, 0.09] , 'Plot', 1); 

    
    %title({['survival: ' logical_cond_2str(d.Scan.SurvivalLogicals{i},d.Scan.SingleAtomSpecies)], ...
    %            ['loading: ' logical_cond_2str(d.Scan.SurvivalLoadingLogicals{i},d.Scan.SingleAtomSpecies)]})
    %xlabel([d.Scan.ParamName, ' [', d.Scan.ParamUnits, ']'])
    if i < ncol
        xlabel('351XXX (GHz)');
    else
        xlabel({'351XXX (GHz)', [filelist{1}]},'interpreter', 'none');
    end
    ylabel('Survival probability')
    box on
    %grid on
    hold off;
      
end

%% Power broadening fit
power = [956, 478, 239, 179, 120];
gammaNa = [38, 20, 16, 20, 18];
gammaNaErr = [6, 5, 2, 9, 7];
power2 = [956, 478, 239, 120];
gammaCs = [45, 23, 19, 22 ];
gammaCsErr = [7, 6, 2, 8];


figure(5); clf;
set(gcf,'color','w');
hold on; 
errorbar(power, gammaNa, gammaNaErr, '.-', 'MarkerSize', 20);
errorbar(power2, gammaCs, gammaCsErr, '.-', 'MarkerSize', 20);
hold off; 
xlabel('Power (uW)');
ylabel('Gamma (MHz), FWHM of Lorentzian');
box on;
grid on;
title('Power broadening for 688.67 GHz PA peak');