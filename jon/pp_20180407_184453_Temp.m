%%%%  Plotting Raman Scans, both atoms, three axes %%%%%%%%%%%%%%%%%%%%%%%%
% Load DataScanSeq object from file
file = [20180416, 225838]; % after spectra
file = [20180420, 005841]; % after spectra

data = DataScanSeq(file);
titles = {'Na Z', 'Na X', 'Na Y', 'Cs Ax1', 'Cs Ax2', 'Cs Ax3'};
bFit = 1;

%% Plot Na
% Define start points
%             a    b      c    w  (MHz)
StartNaL = {[0.36, 18.516, 0, 0.012], [0.36, 18.154, 0, 0.012], [0.36, 18.142, 0, 0.012]};
StartNaR = {[0.36, 18.687, 0, 0.012], [0.36, 19.128, 0, 0.012], [0.36, 19.137, 0, 0.012]};

FitCenterNaL = {[StartNaL{1}(2), 0.1], [StartNaL{2}(2), 0.1], [StartNaL{3}(2), 0.1]};
FitCenterNaR = {[StartNaR{1}(2), 0.1], [StartNaR{2}(2), 0.1], [StartNaR{3}(2), 0.1]};

figure(4); clf; set(gcf,'color','w');
for i = 1 : 3
    subplot(2, 3, i);
    
    %i = 1; % which scan
    survival = 1; %1 for Na, 2 for Cs
    scanFieldIdx = 1; %1 for Na, 2 for Cs
    scale = 1e6;
    
    % Plot
    [x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
    errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
    title( titles{i} );
    %xlabel('TNaRaman1 (us)');
    xlabel('NaRaman1Det (MHz)');
    ylabel('Survival');
    grid on;
    ylim([0 1]);
      
    % Fit
    if bFit
        ftL = fitData(x/scale, y, 'a*exp(-(x-b)^2/w^2) + c', ...
            'Start', StartNaL{i}, 'FitCenter', FitCenterNaL{i}, 'Plot', 1);
        ftR = fitData(x/scale, y, 'a*exp(-(x-b)^2/w^2) + c', ...
            'Start', StartNaR{i}, 'FitCenter', FitCenterNaR{i}, 'Plot', 1, 'TextRow', 2);
    end
end

% File label
xlabel([num2str(file(1)), '_', num2str(file(2))] , 'interpreter', 'none')

%% Plot Cs
% Define start points
%             a    b  c  w  (kHz)
StartCsL = {[0.6, 21, 0, 4], [0.6, -120, 0, 13], [0.6, -120, 0, 13]};
StartCsR = {[0.6, 68, 0, 5], [0.6, 140, 0, 10], [0.6, 152, 0, 10]};

FitCenterCsL = {[StartCsL{1}(2), 20], [StartCsL{2}(2), 50], [ StartCsL{3}(2), 50]};
FitCenterCsR = {[StartCsR{1}(2), 20], [StartCsR{2}(2), 50], [ StartCsR{3}(2), 50]};

figure(4); 
for i = 1 : 3
    subplot(2, 3, i + 3);
    
    %i = 1; % which scan
    survival = 2; %1 for Na, 2 for Cs
    scanFieldIdx = 2; %1 for Na, 2 for Cs
    scale = 1e3;
    
    % Plot 
    [x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
    errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
    title( titles{i + 3} );
    %xlabel('TCsRaman1 (us)');
    xlabel('NaRaman1Det (kHz)');
    ylabel('Survival');
    grid on;
    ylim([0 1]);
    
    % Fit
    if bFit
        try
            ftL = fitData(x/scale, y, 'a*exp(-(x-b)^2/w^2) + c', ...
                'Start', StartCsL{i}, 'FitCenter', FitCenterCsL{i}, 'Plot', 1);
        catch err
        end
        try
            ftR = fitData(x/scale, y, 'a*exp(-(x-b)^2/w^2) + c', ...
                'Start', StartCsR{i}, 'FitCenter', FitCenterCsR{i}, 'Plot', 1, 'TextRow', 2);
        catch err
        end
    end
end

