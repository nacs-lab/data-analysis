%% 20180421_002556
file = [20180422, 222209]; % 4 mW, 698.63  after spectra
data = DataScanSeq(file);

save('20180422_222209_local.mat','data', 'file');

%% Load local data 
load('20180422_222209_local.mat');


%% Redo logicals
%data = data.modifyScan('SurvivalLoadingLogicals', {[1, 2], [1, 2], [1, -2], [-1, 2]}, ...
%    'SurvivalLogicals', {[3], [4], [3], [4]});

data = data.modifyScan('SurvivalLoadingLogicals', {[1, 2]}, ...
    'SurvivalLogicals', {[-3, -4]});
 %addParameter(p, 'SurvivalLoadingLogicals', S.SurvivalLoadingLogicals, true);
 %           addParameter(p, 'SurvivalLogicals', S.SurvivalLogicals, true);
%Cutoffs

% 
% %Scan.Cutoffs = {NaCutoffs, CsCutoffs, NaCutoffs, CsCutoffs};
% %Scan.LoadingLogicals = {[1], [2]}; % [1, 2] for 1&&2
%     Scan.SurvivalLoadingLogicals = {[1, 2], [1, 2], [1, -2], [-1, 2]};
%     Scan.SurvivalLogicals = {[3], [4], [3], [4]};
% 


%% Plot data

%titles = {'DDS = 0.3, 3.9mW ', 'DDS = 0.25, 2.1mW', 'DDS = 0.2, 0.9mW', 'DDS = 0.18, 0.6mW', 'DDS = 0.15, 0.3mW'};
bFit = 1;
figure(4); clf; set(gcf,'color','w');

for i = 1:1
    %subplot(1, 2, i);
    
    %i = 1; % which scan
     %1 for Na, 2 for Cs
    scanFieldIdx = 1; %1 for Na, 2 for Cs
    scale = 0.5;
    
    % Plot
    survival = 1;
    [x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
    errorbar(x/scale, y, yerr, '.', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
    if bFit
        %ylim([0 1]);  %exp(-(x-b)^2/w^2)
        %xlim([0,5]);
      
      fitData(x/scale,  y, 'a + b*1/(1 + (x-x0)^2/w^2)', ...
        'Start', [0.20, 0.3, 0.05, 298.13], 'Plot', 1);
%         gammalistNa(i) = avg(4);
%         gammalistNaErr(i) = err(4);
    end
    
%     hold on;
%     survival = 2;
%     [x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
%     errorbar(x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
%     hold off;
%     if bFit
%         ylim([0 1]);
%         xlim([0,5]);
%         [ft, avg, err] = fitData(x/scale, y, 'a*exp(-x/b)+c', ...  
%             'Start', [1, 3, 0.1],  'FitRange', [-1, 5], 'Plot', 1, 'TextRow', 2);%          gammalistCs(i) = avg(4);
% %         gammalistCsErr(i) = err(4);
%     end

    
    %title( titles{i} );
    %title('Raman resonance');
    xlabel('Raman detuning (MHz)');
    ylabel('Survival');
    %grid on;
    %ylim([0 1]);
    %xlim([0,5]);  
    % Fit

end

% File label
%xlabel([num2str(file(1)), '_', num2str(file(2))] , 'interpreter', 'none')


%%
saveas(gcf,'20180422_222209_RamanFigure.pdf')

% set(gcf,'Units','inches');
% screenposition = get(gcf,'Position');
% set(gcf,...
%     'PaperPosition',[0 0 screenposition(3:4)],...
%     'PaperSize',[screenposition(3:4)]);
% print -dpdf -painters epsFig
% %The first two lines measure the size of your figure (in inches). The next line configures t
