%file = [20180308, 162405];
%file = [20180308, 153803];
%file = [20180308, 173314]; %974.6nm
file = [20180308, 181255]; %974.6nm
data = DataScanSeq(file);


bFit = 1;

%% Scan 1
titles = {'Na 2-body', 'Cs 2-body', 'Na 1-body', 'Cs 1-body'};
figure(4); clf; set(gcf,'color','w');
for survival = 1 : 4
    subplot(2, 4, survival);
    
    %survival = 1; %1 for Na, 2 for Cs
    %scanFieldIdx = 1;
    scale = 1;
    scanidx = 1;
    
    % Plot
    [x,y,yerr] = data.getSurvival(survival, scanidx);
    errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
    % Fit
    ylim([0 1]);
    if bFit
        ft = fitData(x/scale, y, 'a*exp(-x/b)', 'Start', [1 100] , 'Plot', 1);
    end
    title( titles{survival} );
    xlabel('TMergeWait (ms)');
    ylabel('Survival');
    grid on;
   
      
   
end

% File label
xlabel([num2str(file(1)), '_', num2str(file(2))] , 'interpreter', 'none')

%% Scan 2
%figure(4); clf; set(gcf,'color','w');
titles = {'Na 2-body', 'Cs 2-body', 'Na 1-body', 'Cs 1-body'};
for survival = 1 : 4
    subplot(2, 4, survival+4);
    
    %survival = 1; %1 for Na, 2 for Cs
    %scanFieldIdx = 1;
    scale = 1;
    scanidx = 2;
    
    % Plot
    [x,y,yerr] = data.getSurvival(survival, scanidx);
    errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
    % Fit
    ylim([0 1]);
    if bFit
        ft = fitData(x/scale, y, 'a*exp(-x/b)', 'Start', [1 100] , 'Plot', 1);
    end
    title( titles{survival} );
    xlabel('TMergeWait (ms)');
    ylabel('Survival');
    grid on;
    ylim([0 1]);

end

% File label
xlabel([num2str(file(1)), '_', num2str(file(2))] , 'interpreter', 'none')
