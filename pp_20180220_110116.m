%%%%%%%  Plotting VPA scan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting VPA scan when each file only has single point
%% Load data into DataScanSeq array

folder = 'N:\NaCsLab\Data';

p = load([folder '\20180220\' 'VPAScan_20180220_110116.mat']); % Description
filelist = p.filelist;
VPATempList = p.VPATempList;
VPAslope = p.VPAslopeWM; %put m here
VPAoffset = p.VPAoffsetWM; % put os here

%combine_data2({filelist{1}, filelist{end}}, [VPAslope, VPAoffset], clearfig, berror);

clear data;
for m = 1 : length(filelist)
    data(m) = DataScanSeq(filelist{m});
end


%% Plot data
clearfig = 1; berror = 1;
clear x y yerr;
for i = 1 : data(1).Scan.NumSurvival
    survival = i;
    for m = 1 : length(data)
        %i = 1; % which scan
        %scanFieldIdx = 1; %1 for Na, 2 for Cs
        [x(i,m,:), y(i,m,:), yerr(i,m,:)] = data(m).getSurvival(survival, 1, 1);
    end
end

x = x*VPAslope + VPAoffset;
%n = 1; %which survival
%plot(x2(n,:), y(n,:) )

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
    %berror = 1;
    if berror
        errorbar(x(i,:), y(i,:), yerr(i,:),'.');
    else
        plot(x(i,:),  y(i,:) ,'.-');
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