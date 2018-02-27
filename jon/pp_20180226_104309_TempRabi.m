%%%%  Plotting Raman Scans, both atoms, three axes %%%%%%%%%%%%%%%%%%%%%%%%
% Load DataScanSeq object from file
file = [20180226, 104309];
data = DataScanSeq(file);
titles = {'Na Z', 'Na X', 'Na Y', 'Cs Ax1', 'Cs Ax2', 'Cs Ax3'};

%% Plot Na
figure(4); clf; set(gcf,'color','w');
for i = 1 : 3
    subplot(2, 3, i);
    
    %i = 1; % which scan
    survival = 1; %1 for Na, 2 for Cs
    scanFieldIdx = 1; %1 for Na, 2 for Cs
    scale = 1e-6;
    
    [x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
    errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
    title( titles{i} );
    xlabel('TNaRaman1 (us)');
    ylabel('Survival');
    grid on;
    ylim([0 1]);
    
end

% File label
xlabel([num2str(file(1)), '_', num2str(file(2))] , 'interpreter', 'none')

%% Plot Cs
figure(4); 
for i = 1 : 3
    subplot(2, 3, i + 3);
    
    %i = 1; % which scan
    survival = 2; %1 for Na, 2 for Cs
    scanFieldIdx = 2; %1 for Na, 2 for Cs
    scale = 1e-6;
    
    [x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
    errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
    title( titles{i + 3} );
    xlabel('TCsRaman1 (us)');
    ylabel('Survival');
    grid on;
    ylim([0 1]);
    
end

