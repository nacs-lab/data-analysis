%%%%  Plotting Raman Scans, both atoms, three axes %%%%%%%%%%%%%%%%%%%%%%%%
%{
%file = [20180517, 205642];
%file = [20180518, 112216];
%file = [20180518, 233837];
file = [20180519, 123208]; %Na and Cs
file = [20180519, 162054]; % took out horn
file = [20180519, 170745];
file = [20180519, 172053];
file = [20180520, 022354]; %higher order Na sidebands
file = [20180520, 094923];
file = [20180520, 115155];
file = [20180520, 130515];
file = [20180520, 192632];
file = [20180520, 224607];
file = [20180521, 005426];
file = [20180521, 202203];
file = [20180521, 223723];
file = [20180521, 234121];  %half
file = [20180522, 072308]; %full
file = [20180522, 080059]; %quarter time
file = [20180522, 085425];
file = [20180522, 092806];
file = [20180522, 234711];
%}
% Load DataScanSeq object from file
file = [20180523, 184245];
file = [20180525, 233744];
file = [20180526, 191400];
file = [20180526, 194222];
file = [20180528, 111503];
file = [20180529, 174601];
file = [20180529, 154236];
file = [20180530, 090402];
file = [20180530, 212340];
file = [20180530, 153559];
file = [20180531, 005203];
file = [20180531, 153239];

data = DataScanSeq(file);

%% Plots
titles = {'Na Z', 'Na X', 'Na Y', 'Cs Ax1', 'Cs Ax2', 'Cs Ax3'};
bFit = 1;
jlist = [0]; %0, 3 for with/without merge
scanlist = [1,2,3];

% Plot Na
% Define start points
%             a    b      c    w  (MHz)
StartNaL = {[0.36, -96, 0, 10], [0.36, -474, 0, 12], [0.36, -495, 0, 12]};
StartNaR = {[0.1, 70, 0, 10], [0.1, 480, 0, 10], [0.1, 480, 0, 10]};

FitCenterNaL = {[StartNaL{1}(2), 100], [StartNaL{2}(2), 100], [StartNaL{3}(2), 100]};
FitCenterNaR = {[StartNaR{1}(2), 100], [StartNaR{2}(2), 100], [StartNaR{3}(2), 100]};

figure(4); clf; set(gcf,'color','w');
for i = scanlist
    for j = jlist
        subplot(2, 3, i);
        
        %i = 1; % which scan
        survival = 1; %1 for Na, 2 for Cs
        scanFieldIdx = 1; %1 for Na, 2 for Cs
        scale = 1e3;
        
        % Plot
        [x,y,yerr] = data.getSurvival(survival, i + j, scanFieldIdx);
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
        hold on;
    end
end

% File label
xlabel([num2str(file(1)), '_', num2str(file(2))] , 'interpreter', 'none')

% %%%%%%%%%%%% Plot Cs %%%%%%%%%%%%%%%%%%%%
% Define start points
%             a    b  c  w  (kHz)
StartCsL = {[0.6, 28, 0, 4], [0.6, -136, 0, 13], [0.6, -135, 0, 13]};
StartCsR = {[0.6, 75, 0, 5], [0.6, 127, 0, 20], [0.6, 110, 0, 20]};

FitCenterCsL = {[StartCsL{1}(2), 20], [StartCsL{2}(2), 50], [ StartCsL{3}(2), 70]};
FitCenterCsR = {[StartCsR{1}(2), 20], [StartCsR{2}(2), 50], [ StartCsR{3}(2), 70]};

figure(4); 
for i = scanlist
    for j = jlist
        
        subplot(2, 3, i + 3);
        
        %i = 1; % which scan
        survival = 2; %1 for Na, 2 for Cs
        scanFieldIdx = 2; %1 for Na, 2 for Cs
        scale = 1e3;
        
        % Plot
        [x,y,yerr] = data.getSurvival(survival, i + j, scanFieldIdx);
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
        hold on;
    end
end

