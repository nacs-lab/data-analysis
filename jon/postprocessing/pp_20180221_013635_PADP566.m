%  20180221_013635

%% Load VPAScan data
folder = 'N:\NaCsLab\Data';
clearfig = 1; berror = 1;
f = load([folder '\20180221\' 'VPAScan_20180221_013635.mat']); % Description
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

%% Plot no PA and PA without DP
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
    %title({['survival: ' logical_cond_2str(d.Scan.SurvivalLogicals{i},d.Scan.SingleAtomSpecies)], ...
    %            ['loading: ' logical_cond_2str(d.Scan.SurvivalLoadingLogicals{i},d.Scan.SingleAtomSpecies)]})
    %xlabel([d.Scan.ParamName, ' [', d.Scan.ParamUnits, ']'])
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

m=2;
for i = 1:ncol
    
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
    hold off;
    
end



%% Plot PA with DP
% input:   f2Photon,  fPA, and survival's y, yerr

figure(4);
set(gcf,'color','w');
clf;
ncol = data(1).Scan.NumSurvival;
m=12;

for m = 3 : length(f2Photon)
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
        %title({['survival: ' logical_cond_2str(d.Scan.SurvivalLogicals{i},d.Scan.SingleAtomSpecies)], ...
        %            ['loading: ' logical_cond_2str(d.Scan.SurvivalLoadingLogicals{i},d.Scan.SingleAtomSpecies)]})
        %xlabel([d.Scan.ParamName, ' [', d.Scan.ParamUnits, ']'])
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
 
 for i = 1:ncol
     
     xplot = f2Photon(3:end)';
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
