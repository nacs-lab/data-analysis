%%%%%%%  Plotting VPA and fDP 2D scan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting VPA scan when each file only has single point
%VPAScan_20180216_183118_wm
%VPAScan_20180217_013552
%VPAScan_20180217_142447

%% Load VPAScan data
folder = 'N:\NaCsLab\Data';
clearfig = 1; berror = 1;
f = load([folder '\20180217\' 'VPAScan_20180217_142447.mat']); % Description
filelist = f.filelist;
VPATempList = f.VPATempList;
VPAslope = f.VPAslopeWM; %put m here
VPAoffset = f.VPAoffsetWM; % put os here
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
size(y)

% Get the VPATemp axis (should be the same as VPATempList)
VPATempList2 = [];
for i = 1 : length(data)
    VPATempList2 = [VPATempList2, data(i).ScanSeq.p.('VPATemp')];
end
% Convert PA voltage to PA frequency using wavemeter calibration
fPA = VPATempList*VPAslope + VPAoffset;

% Convert x, the DP frequency, to Two-photon frequency
f2Photon = 2*squeeze(x(1,1,:));

%% Plot the different file vs  
% input:   f2Photon,  fPA, and survival's y, yerr

figure(4);
set(gcf,'color','w');
clf;
ncol = data(1).Scan.NumSurvival;
m=3;
for m = 1:length(filelist)
for i = 1 : ncol
    
    %format x(survival, which scan, DP frequency)
    xplot = 2*squeeze(x(i,m,:));
    yplot = squeeze(y(i,m,:));
    yerrplot = squeeze(yerr(i,m,:));
    
    %     xplot = fPA;
    %     yplot = squeeze(y(i,:,m));
    %     yerrplot = squeeze(yerr(i,:,m));
    
    subplot(1, ncol, i);
    hold on;
    berror = 0;
    if berror
        errorbar(xplot, yplot, yerrplot ,'.-');
    else
        plot(xplot,  yplot,'.-');
    end
    Scan = data(1).Scan;
    title({['survival: ' logical_cond_2str(Scan.SurvivalLogicals{i},Scan.SingleAtomSpecies)], ...
                ['loading: ' logical_cond_2str(Scan.SurvivalLoadingLogicals{i},Scan.SingleAtomSpecies)]})
    xlabel([Scan.ParamName, ' [', Scan.ParamUnits, ']'])
    if i < ncol
        xlabel('2-Photon Freq (MHz)');
    else
        xlabel({'2-Photon Freq (MHz)', [filelist{end}]},'interpreter', 'none');
    end
    ylabel('Survival probability')
    box on
    %grid on
    hold off;
end
end

%% Plot no PA 
% input:   f2Photon,  fPA, and survival's y, yerr

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
        errorbar(xplot, yplot, yerrplot ,'.-');
    else
        plot(xplot,  yplot,'.-');
    end
    Scan = data(1).Scan;
    title({['survival: ' logical_cond_2str(Scan.SurvivalLogicals{i},Scan.SingleAtomSpecies)], ...
                ['loading: ' logical_cond_2str(Scan.SurvivalLoadingLogicals{i},Scan.SingleAtomSpecies)]})
    xlabel([Scan.ParamName, ' [', Scan.ParamUnits, ']'])
    if i < ncol
        xlabel('351XXX (GHz)');
    else
        xlabel({'351XXX (GHz)', [filelist{end}]},'interpreter', 'none');
    end
    ylabel('Survival probability')
    box on
    %grid on
    hold off;
end

%% Plot PA with DP
% input:   f2Photon,  fPA, and survival's y, yerr

figure(4);
set(gcf,'color','w');
clf;
ncol = data(1).Scan.NumSurvival;
m=1;

for m = 1 : length(f2Photon)
    for i = 1:ncol
        
        % format x(survival, which scan, DP frequency)
        %     xplot = squeeze(x(i,m,:));
        %     yplot = squeeze(y(i,m,:));
        %     yerrplot = squeeze(yerr(i,m,:));
        
        xplot = fPA;
        yplot = squeeze(y(i,:,m));
        yerrplot = squeeze(yerr(i,:,m));
        
        subplot(1, ncol, i);
        berror = 0;
        hold on;
        if berror
            errorbar(xplot, yplot, yerrplot ,'.-');
        else
            plot(xplot,  yplot,'.-');
        end
        Scan = data(1).Scan;
        title({['survival: ' logical_cond_2str(Scan.SurvivalLogicals{i},Scan.SingleAtomSpecies)], ...
                    ['loading: ' logical_cond_2str(Scan.SurvivalLoadingLogicals{i},Scan.SingleAtomSpecies)]})
        xlabel([Scan.ParamName, ' [', Scan.ParamUnits, ']'])
        if i < ncol
            xlabel('351XXX (GHz)');
        else
            xlabel({'351XXX (GHz)', [filelist{end}]},'interpreter', 'none');
        end
        ylabel('Survival probability')
        box on
        %grid on
        hold off;
        
    end
end



%% Plot PA with DP
% input:   f2Photon,  fPA, and survival's y, yerr

figure(4);
set(gcf,'color','w');
clf;
ncol = data(1).Scan.NumSurvival;

mrange = 3 : length(f2Photon);
xplot = f2Photon(3:end)'; 

for i = 1:ncol
    
    yplot = squeeze(y(i,:,mrange));
    yerrplot = squeeze(yerr(i,:,mrange));
    
    subplot(1, ncol, i);
    
    berror = 0;
    hold on;
    imagesc(xplot, fPA, yplot);
    
    if i < ncol
        xlabel('2-Photon Freq (MHz)');
    else
        xlabel({'2-Photon Freq (MHz)', [filelist{end}]},'interpreter', 'none');
    end
    ylabel('351XXX (GHz)')
    %box on
    colorbar;
    %grid on
    hold off;
    
end
