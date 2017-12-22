%% Load data
%Don't need to run above once files are made.  Just run below.

%load site data
file = [20171214, 193954];  % 15.5 mW
p = replot2(file);
%close all;

%unload everything needed to plot Jessie style
Scan = p.Scan;
Analysis = p.Analysis;
num_images_per_seq = Scan.NumImages;
p_survival = Analysis.SurvivalSiteProbability;
p_survival_err = Analysis.SurvivalSiteProbabilityErr;
params = Scan.Params;
images = Scan.Images;
param_units = Scan.ParamUnits;
param_name = Scan.ParamName;
param_name_unit = [param_name, ' [', param_units, ']'];
plot_scale = Scan.PlotScale;
num_images_total = size(images,3);
num_seq_per_grp = length(params);
num_grp = num_images_total / (num_images_per_seq * num_seq_per_grp) ;
param_list = repmat(params, 1, num_grp);
unique_params = unique(param_list);

%% Fit each site
%plot
figure(3); %clf;
for i = 1:length(p_survival)
    %i=2; %which site

    %line_specs = {'bs','rs','cs','gs','ys','rs'};
    %errorbar(unique_params/plot_scale, squeeze(p_survival{i}), p_survival_err{i}, line_specs{mod(i-1,6)+1});



    ft = 'a*exp(-(x-b)^2/w^2) + os';
    fitcenter = 10;
    fitwidth = 100; 1e6;
    startPoints = [1 fitcenter  0 50];  %a, b, os, w


    fitrange = fitcenter + fitwidth*[-1/2 1/2];
    xfit = unique_params'/plot_scale;
    exclude = xfit < min(fitrange) | xfit > max(fitrange);
    fit_obj = fit(xfit, p_survival{i}', ft, ...
        'Start', startPoints, 'Exclude', exclude)
    hold on; plot(fit_obj,'-k'); hold off;
    xlimits = xlim;
    s1 = ['fit to ', formula(fit_obj)];
    [avg, err] = get_mean_error_from_fit(fit_obj);  % I don't know what this is
    s2 = sprintf(['\n', num2str(avg)]);
    s3 = sprintf(['\n', num2str(err)]);
    text(xlimits(1)+(xlimits(2)-xlimits(1))/10, 0.9 - (i-1)*0.17, [s1, s2, s3])
    legend off;

    box on; grid on;
    xlabel({param_name_unit}, 'interpreter','none');
    ylabel('Survival probability');
    ylim([0,1]);

end

