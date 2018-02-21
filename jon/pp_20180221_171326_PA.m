%%%%%%%  Plotting VPA scan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting VPA scan when each file only has single point
%VPAScan_20180221_171326

%% Load VPAScan data
folder = 'N:\NaCsLab\Data';
clearfig = 1; berror = 1;
f = load([folder '\20180221\' 'VPAScan_20180221_171326.mat']); % Description
filelist = f.filelist;
VPATempList = f.VPATempList;
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
        [x(i,m,:), y(i,m,:), yerr(i,m,:)] = data(m).getSurvival(survival);
    end
end
size(y);

% Get the VPATemp axis (should be the same as VPATempList)
VPATempList2 = [];
for i = 1 : length(data)
    VPATempList2 = [VPATempList2, data(i).ScanSeq.p.('VPATemp')];
end

% Convert x, the DP frequency, to Two-photon frequency
%VPA = squeeze(x(1,:));

% Convert PA voltage to PA frequency using wavemeter calibration
if isfield(f, 'VPAslopeWM')
    fPA = VPATempList2*f.VPAslopeWM + f.VPAoffsetWM;
else
    fPA = VPATempList2*f.VPAslope + f.VPAoffset;
end


%% Plot PA data
figure(4);
if clearfig
    clf;
end
set(gcf,'color','w');
ncol = data(1).Scan.NumSurvival;
for i = 1:ncol
    subplot(1, ncol, i);
    
    %Plot
    hold on;
    berror = 1;
    if berror
        errorbar(fPA, y(i,:), yerr(i,:),'.-');
    else
        plot(fPA,  y(i,:) ,'.-');
    end
    Scan = data(1).Scan;
    title({['survival: ' logical_cond_2str(Scan.SurvivalLogicals{i},Scan.SingleAtomSpecies)], ...
                ['loading: ' logical_cond_2str(Scan.SurvivalLoadingLogicals{i},Scan.SingleAtomSpecies)]})
    xlabel( [Scan.ParamName + " [" + Scan.ParamUnits + "]"] )
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