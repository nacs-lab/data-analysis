%%%%  Plotting Raman Scans, both atoms, three axes %%%%%%%%%%%%%%%%%%%%%%%%
% Load DataScanSeq object from file
file = [20180515, 221719]; % after spectra
file = [20180515, 231050];
file = [20180515, 235314];
file = [20180516, 020615]; %overnigth temp scan
file = [20180517, 014314];
file = [20180517, 090506];
file = [20180517, 124914];
file = [20180517, 145611];
file = [20180517, 170433];

data = DataScanSeq(file);
titles = {'Na Z', 'Na X', 'Na Y', 'Cs Ax1', 'Cs Ax2', 'Cs Ax3'};
bFit = 0;

%% Plot Na
% Define start points
%             a    b      c    w  (MHz)
StartNaL = {[0.36, -75, 0, 12], [0.36, -431, 0, 12], [0.36, -451, 0, 12]};
StartNaR = {[0.36, 73, 0, 12], [0.36, 438, 0, 12], [0.36, 464, 0, 12]};

FitCenterNaL = {[StartNaL{1}(2), 100], [StartNaL{2}(2), 100], [StartNaL{3}(2), 100]};
FitCenterNaR = {[StartNaR{1}(2), 100], [StartNaR{2}(2), 100], [StartNaR{3}(2), 100]};

figure(4); clf; set(gcf,'color','w');
for i = 1 : 3
    subplot(2, 3, i);
    
    %i = 1; % which scan
    survival = 1; %1 for Na, 2 for Cs
    scanFieldIdx = 1; %1 for Na, 2 for Cs
    scale = 1e3;
    
    % Plot
    [x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
    %x = x - 18.6e6;
    errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
    title( titles{i} );
    %xlabel('TNaRaman1 (us)');
    xlabel('NaRaman1Det (kHz)');
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
StartCsL = {[0.6, 19, 0, 4], [0.6, -119, 0, 13], [0.6, -119, 0, 13]};
StartCsR = {[0.6, 70, 0, 5], [0.6, 140, 0, 10], [0.6, 152, 0, 10]};

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

