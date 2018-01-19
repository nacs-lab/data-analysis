% Cs Ax2 Scan
d = replot2([20180115, 222408]);


i=1; %which scan?
m=2; %which survival?

SurvProb = d(i).Analysis.SurvivalProbability;
SurvProbErr = d(i).Analysis.SurvivalProbabilityErr;
Params = d(i).Analysis.UniqueParameters;
SurvProb = SurvProb(m,:);
SurvProbErr = SurvProbErr(m,:);

figure(4); clf; set(gcf,'color','w');
errorbar( Params/1e3, SurvProb, SurvProbErr , '.-', 'CapSize', 2,...
    'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
title('Cs Ax2');
xlabel('Frequency (kHz)');
ylabel('Survival');
grid on;
%set(gca,'fontsize', 14);
ylim([0 1]);

%% fit to Gaussian
ft = 'a*exp(-(x-b)^2/w^2) + os';
fitcenter = -140;
fitwidth = 100; 1e6;
startPoints = [1 fitcenter  0 50];  %a, b, os, w

fitrange = fitcenter + fitwidth*[-1/2 1/2];
xfit = Params/1e3;
exclude = xfit < min(fitrange) | xfit > max(fitrange);
fit_obj = fit(xfit', SurvProb', ft, ...
      'Start', startPoints, 'Exclude', exclude)
xplot = linspace( max(fitrange(1), min(xfit)), min(fitrange(2), max(xfit)), 200);
hold on; plot(xplot, fit_obj(xplot), '-k'); hold off;

%% fit to Gaussian
ft = 'a*exp(-(x-b)^2/w^2) + os';
fitcenter = 25;
fitwidth = 100; 1e6;
startPoints = [1 fitcenter  0 50];  %a, b, os, w

fitrange = fitcenter + fitwidth*[-1/2 1/2];
xfit = Params/1e3;
exclude = xfit < min(fitrange) | xfit > max(fitrange);
fit_obj = fit(xfit', SurvProb', ft, ...
      'Start', startPoints, 'Exclude', exclude)
xplot = linspace( max(fitrange(1), min(xfit)), min(fitrange(2), max(xfit)), 200);
hold on; plot(xplot, fit_obj(xplot), '-k'); hold off;


%% fit text on plot

xlimits = xlim;
    s1 = ['fit to ', formula(fit_obj)];
    [avg, err] = get_mean_error_from_fit(fit_obj);  % I don't know what this is
    s2 = sprintf(['\n', num2str(avg)]);
    s3 = sprintf(['\n', num2str(err)]);
    text(xlimits(1)+(xlimits(2)-xlimits(1))/10, 0.9 - (i-1)*0.17, [s1, s2, s3])
    legend off;

%     box on; grid on;
%     xlabel({param_name_unit}, 'interpreter','none');
%     ylabel('Survival probability');
%     ylim([0,1]);