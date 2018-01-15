%Separate Multi-scan data into individual .mat files
%Scan RS spectra for 2 different tweezer powers.
%Saves files  004811, 004812
%JDH

%% Load file
file = [20171212, 004811];
fname = DateTimeStampFilename(file(1), file(2));
d = load(fname);
%plot data
[Analysis, MeanLoads, ParamList] = plot_data(d.Scan, d.Scan.Images, fname);

d.Images =[];  %get rid of legacy d.Images

%% Separating multiple scans

%select indices ranges for the new structures
Params{1} = linspace(-180, 210, 91);
Params{2} = linspace(-180, 210, 91);
%Params3 = linspace(-180, 210, 91)*1e3;  %don't use because didn't scan
%enough points
ParamName = 'CsRaman1Det';
ParamUnits = 'kHz';
PlotScale = 1;


%define index ranges to separate into files
IdxRange = {[1, length(Params{1})], [length(Params{1})+1, length(Params{1})+length(Params{2})]};

clear IdxLogic p fname_new ParamList Scan
for i=1:length(IdxRange)

    %Initialize Scan to be same as d.Scan
    Scan = d.Scan;

    %Filter only Idx's in IndxRange
    IdxLogic = IdxRange{i}(1) <= d.ParamList & d.ParamList <= IdxRange{i}(2);
    %ParamList = d.ParamList( IdxLogic );  %defined in plot_data below
    Scan.Images = d.Scan.Images(:, :, repelem(IdxLogic, d.Scan.NumImages) );

    IdxLogic2 = IdxRange{i}(1) <= d.Scan.Params & d.Scan.Params <= IdxRange{i}(2);
    Scan.Params = d.Scan.Params( IdxLogic2 );
    Scan.NumPerGroup = length( Scan.Params );

    %Update Idx to scanned units
    Scan.ParamName = ParamName;
    Scan.ParamUnits = ParamUnits;
    Scan.PlotScale = PlotScale;
    Scan.Params = Params{i}( Scan.Params - (IdxRange{i}(1) - 1) );

    %Create new fname for filtered data which is 1 sec later
    fname = DateTimeStampFilename(file(1), file(2) + i);

    %redo analysis on filtered data
    [Analysis, MeanLoads, ParamList] = plot_data(Scan, Scan.Images, fname);

    %save data as new .mat file
    memmap = d.memmap;
    ErrorCode = d.ErrorCode;
    save(fname, 'memmap', 'ErrorCode', 'Scan', 'ParamList', 'Analysis');

end


%% Load data
%Don't need to run above once files are made.  Just run below.

%load site data
%file = [20171212, 004812];  % 15.5 mW
file = [20171212, 004813]; % 20 mW
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


%% Fit each site 2
%plot
figure(3); %clf;
for i = 1:length(p_survival)
    %i=2; %which site

    %line_specs = {'bs','rs','cs','gs','ys','rs'};
    %errorbar(unique_params/plot_scale, squeeze(p_survival{i}), p_survival_err{i}, line_specs{mod(i-1,6)+1});



    ft = 'a*exp(-(x-b)^2/w^2) + os';
    fitcenter = -140;
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


%% Fit each site  1
%plot
figure(3); %clf;
i=1; %which site
line_specs = {'bs','ms','cs','gs','ys','rs'};

errorbar(unique_params/plot_scale, squeeze(p_survival{i}), p_survival_err{i}, line_specs{mod(i-1,6)+1});
box on; grid on;
xlabel({param_name_unit},'interpreter','none');
ylabel('Survival probability')
ylim([0,1]);

ft = 'a*exp(-(x-b)^2/w^2) + os';
fitcenter = 20;
fitwidth = 100;
startPoints = [1 fitcenter  0 50];  %a, b, os, w


fitrange = fitcenter + fitwidth*[-1/2 1/2];
xfit = unique_params'/plot_scale;
exclude = xfit < min(fitrange) | xfit > max(fitrange);
fit_obj = fit(xfit, p_survival{i}', ft, ...
    'Start', startPoints, 'Exclude', exclude)
hold on; plot(fit_obj,'-r'); hold off;
xlimits = xlim;
s1 = ['fit to ', formula(fit_obj)];
[avg, err] = get_mean_error_from_fit(fit_obj);  % I don't know what this is
s2 = sprintf(['\n', num2str(avg)]);
s3 = sprintf(['\n', num2str(err)]);
text(xlimits(1)+(xlimits(2)-xlimits(1))/10,0.9,[s1, s2, s3])
legend off;


