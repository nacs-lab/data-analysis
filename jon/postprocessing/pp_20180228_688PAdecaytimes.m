% 688 on-resonance PA decay times for different powers
% Files:   
% 20180228_120244, powers 1050, 478, 235, 118*4, on res
% 20180228_130950, same power but detuned -400 MHz)
% 20180228_142413, on-res, powers 235, 235/2, 235/4 uW.
% 20180228_151022,  same but detuned -500 MHz

%% High power measurements
file = [20180228, 120244];  % on-res
%file = [20180228, 130950]; %off -res
data = DataScanSeq(file);

figure(4); clf; set(gcf,'color','w');
titles = {'Na 2-body 1050uW', 'Cs 2-body 1050uW', 'Na 2-body 478uW', 'Cs 2-body 478uW', ...
  'Na 2-body 235uW', 'Cs 2-body 235 uW','Na 2-body 472uW ', 'Cs 2-body 472uW'};

for i = 1:4
    for survival = 1:2
        subplot(4, 2, 2*(i-1) + survival);
        scale = 1;
        
        [x,y,yerr] = data.getSurvival(survival, i);
        errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
        title( titles{2*(i-1) + survival} );
        xlabel('PA time (ms)');
        ylabel('Survival');
        grid on;
        ylim([0 1]);
        
        ft = fitData(x/scale, y, 'a*exp(-(x/t)) + c', 'Start', [1, 0, 100], ...
            'Plot', 1, 'FitRange', [0, 60]);
        
    end
end


%% Low power measurements
%file = [20180228, 142413]; % on-res
file = [20180228, 151022];% off-res
data = DataScanSeq(file);

figure(4); clf; set(gcf,'color','w');
titles = {'Na 2-body 235uW', 'Cs 2-body 235uW', 'Na 2-body 118uW', 'Cs 2-body 118uW', ...
    'Na 2-body 59uW', 'Cs 2-body 59 uW'};

for i = 1:3
    for survival = 1:2
        subplot(3, 2, 2*(i-1) + survival);
        scale = 1;
        
        [x,y,yerr] = data.getSurvival(survival, i);
        errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
        title( titles{2*(i-1) + survival} );
        xlabel('PA time (ms)');
        ylabel('Survival');
        grid on;
        ylim([0 1]);
        
        ft = fitData(x/scale, y, 'a*exp(-(x/t)) + c', 'Start', [1, 0, 100], ...
            'Plot', 1, 'FitRange', [0, 60]);
        
    end
end


%% Summary measurements
power = [1050, 478, 235, 472, 235, 118, 59];
NaDecayRate = [0.73, 1.882, 3.193, 1.400, 3.56, 6.17, 13.96];
NaDecayRateErr = [0.1, 0.39, 1.2, 0.24, 0.7, 1.7, 4];
CsDecayRate = [0.853, 1.555, 2.484, 1.2192, 3.82, 5.90, 12.89];
CsDecayRateErr = [0.11, 0.35, 0.97, 0.16, 0.78, 1.4, 3.2];

NaDecayRateBkgd = [7.55, 14.8, 26.59, 22.92, 23.5, 29.1, 28.59];
CsDecayRateBkgd = [6.69, 25.83, 15.14, 30.83, 27.39, 25.14, 20.2];

figure(4); clf; set(gcf,'color','w');
hold on; 
x = power; 

% y = 1./NaDecayRate;
% yerr =  abs(NaDecayRateErr./(NaDecayRate.^2));
% errorbar( x, y, yerr, '.', 'MarkerSize', 15);
% ft = fitData(x, y, 'a*x + b', 'Start', [0.001, 0]);
% xlimit = xlim;
% xfit = linspace(xlimit(1), xlimit(2), 100);
% plot(xfit, ft(xfit), '-k');
 
y = 1./CsDecayRate;
yerr = abs(CsDecayRateErr./(CsDecayRate.^2));
errorbar( power, y, yerr, '.', 'MarkerSize', 15);
ft = fitData(x, y, 'a*x + b', 'Start', [0.001, 0]);
xlimit = xlim;
xfit = linspace(xlimit(1), xlimit(2), 100);
plot(xfit, ft(xfit), '-k');

hold off; 

xlabel('PA Power (uW)');
ylabel('Decay rate K (1/ms)');
box on;
title('PA decay rate vs PA power');
%legend('Na','Na fit') %
legend('Cs', 'Cs fit') %
