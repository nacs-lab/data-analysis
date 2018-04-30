%% 20180421_002556
file = [20180421, 002556]; % after spectra
data = DataScanSeq(file);

%%
titles = {'DDS = 0.3, 3.9mW ', 'DDS = 0.25, 2.1mW', 'DDS = 0.2, 0.9mW', 'DDS = 0.18, 0.6mW', 'DDS = 0.15, 0.3mW'};
bFit = 1;
gammalistCs = [];
gammalistNa = [];
gammalistNaErr = [];
gammalistCsErr = [];
figure(4); clf; set(gcf,'color','w');
for i = 1:5
    subplot(2, 3, i);
    
    %i = 1; % which scan
     %1 for Na, 2 for Cs
    scanFieldIdx = 1; %1 for Na, 2 for Cs
    scale = 1;
    
    % Plot
    survival = 1;
    [x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
    errorbar( 2*x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
    if bFit
        ylim([0 1]);  %exp(-(x-b)^2/w^2)
       [ft, avg, err] = fitData(2*x/scale, y, 'a*1/(1+(x-b)^2/(gamma/2)^2) + c', ...  
            'Start', [0.3, 298.5, 0.3, 0.5], 'FitCenter', [298.5, 10], 'Plot', 1, 'TextRow', 1);
        gammalistNa(i) = avg(4);
        gammalistNaErr(i) = err(4);
    end
    
    hold on;
    survival = 2;
    [x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
    errorbar( 2*x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
    hold off;
    if bFit
        ylim([0 1]);
        [ft, avg, err] = fitData(2*x/scale, y, 'a*1/(1+(x-b)^2/(gamma/2)^2) + c', ...
            'Start', [0.3, 298.5, 0.3, 0.5], 'FitCenter', [298.5, 10], 'Plot', 1, 'TextRow', 2);
         gammalistCs(i) = avg(4);
        gammalistCsErr(i) = err(4);
    end

    
    title( titles{i} );
    %xlabel('TNaRaman1 (us)');
    xlabel('Two-photon detuning (MHz)');
    ylabel('Survival');
    grid on;
    ylim([0 1]);
      
    % Fit

end

% File label
xlabel([num2str(file(1)), '_', num2str(file(2))] , 'interpreter', 'none')


%% FWHM vs power
pow = [3.9, 2.1, 0.9, 0.6, 0.3]; %mW
figure; 
errorbar(pow, gammalistNa, gammalistNaErr,  'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14)
hold on;
errorbar(pow, gammalistCs, gammalistCsErr,  'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14)
hold off;
ylim([0, 5]);

fitData(pow, gammalistNa, 'a*x', 'Plot', 1);
fitData(pow, gammalistCs, 'a*x', 'Plot', 1, 'TextRow', 2);
xlabel('Down power (mW)');
ylabel('EIT FWHM (MHz)');
title('EIT linewidth vs down power with ~3mW up, 30ms');
