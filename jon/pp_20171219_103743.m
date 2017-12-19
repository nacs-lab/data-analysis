%Separate Multi-scan data into individual .mat files
% Commit d492b53,
% Scanning coprop for three different trap locations, 2 trap powers, adn 2 Raman
% powers.
%JDH

%% Load unseparated file
file = [20171219, 103743];
fname = DateTimeStampFilename(file(1), file(2));
d = load(fname);
%plot data
[Analysis, MeanLoads, ParamList] = plot_data(d.Scan, d.Scan.Images, fname);

d.Images =[];  %get rid of legacy d.Images

%% Separating multiple scans

Params = [ linspace(15, 35, 21), linspace(120, 160, 41) ];
offset1 = length(Params);
offset2 = offset1 + length(Params);
offset3 = offset2 + length(Params);
% offset4 = offset3 + length(Params);
% offset5 = offset4 + length(Params);
% offset6 = offset5 + length(Params);
% offset7 = offset6 + length(Params);
% offset8 = offset7 + length(Params);
% offset9 = offset8 + length(Params);

%select indices ranges for the new structures
%Params{1} = linspace(-180, 210, 91);
%Params{2} = linspace(-180, 210, 91);
%Params3 = linspace(-180, 210, 91)*1e3;  %don't use because didn't scan
%enough points
ParamName = 'CsTrapFreq';
ParamUnits = 'kHz';
PlotScale = 1;


%define index ranges to separate into files
IdxRange = {[1, offset1], [offset1+1, offset2], [offset2+1, offset3]};
%     [offset3+1, offset4], [offset4+1, offset5], [offset5+1, offset6] ...
%     [offset6+1, offset7], [offset7+1, offset8], [offset8+1, offset9]};

clear IdxLogic p fname_new ParamList Scan
for i=1:length(IdxRange)
    
    %Initialize Scan to be same as d.Scan
    Scan = d.Scan;
    
    %Filter only Idx's in IndxRange
    IdxLogic = IdxRange{i}(1) <= d.ParamList & d.ParamList <= IdxRange{i}(2);
    %ParamList = d.ParamList( IdxLogic );  %defined in plot_data below
    Scan.Images = d.Scan.Images(:, :, repelem(IdxLogic, d.Scan.NumImages) );
    
    IdxLogic = IdxRange{i}(1) <= d.Scan.Params & d.Scan.Params <= IdxRange{i}(2);
    Scan.Params = d.Scan.Params( IdxLogic ); 
    Scan.NumPerGroup = length( Scan.Params );
    
    %Update Idx to scanned units
    Scan.ParamName = ParamName;
    Scan.ParamUnits = ParamUnits;
    Scan.PlotScale = PlotScale;
    Scan.Params = Params( Scan.Params - (IdxRange{i}(1) - 1) ); 
        
    %Create new fname for filtered data which is 1 sec later
    fname = DateTimeStampFilename(file(1), file(2) + i);
    
    %redo analysis on filtered data
    [Analysis, MeanLoads, ParamList] = plot_data(Scan, Scan.Images, fname);

    %save data as new .mat file
    memmap = d.memmap;
    ErrorCode = d.ErrorCode;
    save(fname, 'memmap', 'ErrorCode', 'Scan', 'ParamList', 'Analysis'); 

end


%% Load data and fit 
%Don't need to run above once files are made.  Just run below. 
    
%load site data
file = [20171219, 103744]; %44,45,46
p = replot2(file);
%p = replot2(file, 'SingleAtomSites',  {[3, 3; 6, 3], [3, 3; 6, 3]});
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
%figure(3); %clf;
%for i = 1:1  %length(p_survival)
    i=2; %which site
    
    %line_specs = {'bs','rs','cs','gs','ys','rs'};
    %errorbar(unique_params/plot_scale, squeeze(p_survival{i}), p_survival_err{i}, line_specs{mod(i-1,6)+1});
  
    ft = 'os -a*exp(-(x-b)^2/w^2) ';
    %ft = 'a*rabiLine(2*pi*(x-x0)*1e3, 15*1e-6, Omega*1e3)';
    fitcenter = 25; %center in kHz
    fitwidth = 1e6;
    %startPoints = [1 fitcenter  0 50];  %a, b, os, w  %Gaussian
    startPoints = [ 200, 1, fitcenter]; %Omega (2piKHz), a, t(us), x0(kHz)
    
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
    
%end

