%plot_data(Scan, Images, fname)
file = [20180216, 013913];

fname = DateTimeStampFilename(file(1), file(2));
d = load(fname);

Scan = d.Scan;
%plot data
%[Analysis, MeanLoads, ParamList] = plot_data(d.Scan, d.Scan.Images, fname);

%% Separate multiple scans
scanseq = d.Scan.ScanSeq;
p = scanseq.p;

% Separate the file
idxFirst = 0;  idxLast = 0;
for i = 1:length(p)
    % Index of first and last point
    idxFirst = idxLast + 1; 
    idxLast = idxFirst + scanseq.scanLength(i) - 1;
    
    % Initialize Scan to be same as d.Scan
    Scan = d.Scan;

    % Filter only Idx's in IndxRange
    idxLogic = idxFirst <= d.ParamList & d.ParamList <= idxLast;
    Scan.Images = d.Scan.Images(:, :, repelem(idxLogic, d.Scan.NumImages) );

    idxLogic2 = idxFirst <= d.Scan.Params & d.Scan.Params <= idxLast;
    Scan.Params = d.Scan.Params( idxLogic2 );
    Scan.NumPerGroup = length( Scan.Params );
    %do paramlist as well

    % Update idx to scanned units
    Scan.ParamName = p(i).ParamName;
    Scan.ParamUnits = p(i).ParamUnits;
    Scan.PlotScale = p(i).PlotScale;
    scanIdx = scanseq.scanIdx{i}; %indices for scanned variables
    scannedField = scanseq.fields{scanIdx(1)}; %choose first scanned index if multiple ones. 
    Params = p.(scannedField);
    Scan.Params = Params( Scan.Params - (idxFirst - 1) );
    
    o(i).Scan = Scan;
    %o(i).Analysis = Analysis;
    o(i).ParamList = ParamList;
end


%% Unload d.Scan
% seq refers to single run of sequence
% grp refers to a grouping of param_list
NumImagesPerSeq = Scan.NumImages;
NumSites = Scan.NumSites;
BoxSize = Scan.BoxSize;
LoadingLogicals = Scan.LoadingLogicals;
SurvivalLoadingLogicals = Scan.SurvivalLoadingLogicals;
SurvivalLogicals = Scan.SurvivalLogicals;
Cutoffs = Scan.Cutoffs;
SingleAtomSpecies = Scan.SingleAtomSpecies;
Params = Scan.Params; %Scanned params in group, length ~ NumPerGroup
PlotScale = Scan.PlotScale;
SingleAtomSites = Scan.SingleAtomSites;
FrameSize = Scan.FrameSize;
ParamUnits = Scan.ParamUnits;
ParamName = Scan.ParamName;
if isempty(ParamUnits)
    param_name_unit = ParamName;
else
    if isstring(ParamName) && isstring(ParamUnits)
        param_name_unit = ParamName + "[" + ParamUnits + "]";
    else
        param_name_unit = [ParamName, ' [', ParamUnits, ']'];
    end
end
FitType = Scan.FitType;
Images = Scan.Images; %Images is now saved in Scan

% Calculate total sequences
NumImagesTotal = size(Images,3);
NumSeq = NumImagesTotal / NumImagesPerSeq;
% Total number of groups scanned
NumSeqPerGrp = length(Scan.Params);
NumGrp = NumImagesTotal / (NumImagesPerSeq * NumSeqPerGrp) ;

NumLoading = length(Scan.LoadingLogicals); % Number of loading plots
NumSurvival = length(Scan.SurvivalLoadingLogicals); % Number of survival plots


%If using ScanSeq for scan, convert axis from idx to scanned variable.
 if isfield(Scan, 'ScanSeq')
     scanseq = Scan.ScanSeq;
    if length(scanseq.p) == 1  %only for single scans
        %if multiple variables scanned, use first scanned variablefor axes.
        idx = scanseq.scanIdx{1}(1);
        scannedfield = scanseq.fields{idx};
        scannedparams = scanseq.p(1).(scannedfield);
        %unique_params = scannedparams(unique_params);
        Params = scannedparams(Params);
    end
end

ParamList = repmat(Params, 1, NumGrp);
UniqueParams = unique(ParamList);
NumParams = length(UniqueParams);
NumSeqPerParam = NumSeq / NumParams;



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIND SINGLE ATOMS AND LOGICALS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Find single atoms
[SingleAtomLogical, SingleAtomSignal, AvImages] ...
    = find_single_atoms_sites(Images, SingleAtomSites, Cutoffs, ...
    NumImagesPerSeq, NumSites, BoxSize, FrameSize);

% Create loading and survival logicals. These are of dimensions (Number survival plots, number sites, number of
% sequences).
LoadingLogical = find_logical(LoadingLogicals, SingleAtomLogical, NumSites, NumSeq);
SurvivalLoadingLogical = find_logical(SurvivalLoadingLogicals, SingleAtomLogical, NumSites, NumSeq);
SurvivalLogical = find_logical(SurvivalLogicals, SingleAtomLogical, NumSites, NumSeq);
% 
% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % SINGLE ATOM IMAGES AND HISTOGRAMS %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%
% fig1 = figure(1); clf(fig1);
% num_row = NumSites+2;
% num_col = NumImagesPerSeq;
% for n = 1:NumImagesPerSeq
% 
%     subplot(num_row, num_col, [n,n+num_col]);
%     imagesc(AvImages(:,:,n));
%     colormap gray; shading flat; pbaspect([1,1,1]);   %axis equal;
% 
%     title(['Image #',num2str(n),' ',SingleAtomSpecies{n}])
% 
%     sites = SingleAtomSites{n};
%     if ~isempty(sites)
%         cutoff = Cutoffs{n};
%         for i = 1:NumSites
% 
%             % plot ROI for atom detection
%             site = sites(i,:);
%             rad = ceil((BoxSize-1)/2);
%             x = site(1)+round(FrameSize/2)-0.5-rad;
%             y = site(2)+round(FrameSize/2)-0.5-rad;
% 
%             subplot(num_row, num_col, [n,n+num_col]); %(n-1)*num_col+1);
%             hold on;
%             rectangle('Position',[x, y, 2*rad+1, 2*rad+1],'EdgeColor','r');
%             t = text(x-1, y-1, num2str(i));
%             t.Color = 'red';
%             hold off;
% 
%             % plot histogram of electron counts
%             subplot(num_row, num_col, (i+1)*num_col+n); hold on;
%             h_counts = histogram(SingleAtomSignal(n,i,:),40);
%             ymax = max(h_counts.Values(10:end)); % approx single atom hump
%             ylim([0, 2*ymax]);
%             plot([cutoff(i),cutoff(i)],ylim,'-r');
%             title(['site #',num2str(i)]);
%             if n == NumImagesPerSeq-1 && i == NumSites
%                 xlabel({'Electrons (Counts)',fname},'interpreter','none')
%             else
%                 xlabel('Electrons (Counts)')
%             end
%             ylabel('Frequency')
%             box on
%         end
%     end
% end
% 
% 
% 
% %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % LOADING RATE AS A FUNCTION OF TIME %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%
% fig2 = figure(2); clf(fig2);
% subplot(2,1,1);
% grp_loading(NumLoading, NumSites, NumGrp) = 0;
% legend_string21{NumLoading*NumSites} = '';
% for i = 1:NumLoading
%     for j = 1:NumGrp
%         grp_ind = ((j-1)*NumSeqPerGrp+1):j*NumSeqPerGrp;
%         grp_loading(i,:,j) = sum(LoadingLogical(i, :, grp_ind), 3) / NumSeqPerGrp;
%     end
%     for n = 1:NumSites
%         hold on
%         plot(NumSeqPerGrp*[1:NumGrp], squeeze(grp_loading(i,n,:)), '.-')
%         hold off
%         legend_string21{NumSites*(i-1)+n} = ['loading ' mat2str(LoadingLogicals{i}) ' (site ' int2str(n) ')'];
%     end
% end
% lgnd21=legend(legend_string21,'Location','eastoutside');
% set(lgnd21,'color','none');
% 
% box on
% if max(max(max(grp_loading))) == 0
%     ylim([0,1])
% else
%     ylim([0,1.3 * max(max(max(grp_loading)))+0.01])
% end
% set(gca,'ygrid','on')
% xlabel('Sequence number')
% ylabel(['Average (/',int2str(NumSeqPerGrp), ') loading'])
% 
% %% %%%%%%%%%%%%%%%%%%%%%%%%%
% % MEAN LOADS PER PARAMETER %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%
% figure(2);
% subplot(2,1,2); hold on;
% %yyaxis left
% param_loads(NumLoading, NumSites, NumParams) = 0;
% param_loads_all(NumLoading, NumParams) = 0;
% if NumSites > 1
%     legend_string22{NumLoading*(NumSites+1)} = '';
% else
%     legend_string22{NumLoading} = '';
% end
% line_specs = {'rs','bs','ms','cs','gs','ys'};
% for i = 1:NumLoading
% 
%     for j = 1:NumSites
%         [param_loads(i,j,:), param_loads_err] = find_param_loads(LoadingLogical(i, j, :), ParamList, NumSeqPerParam);
% 
%         if NumSites > 1
%             errorbar(UniqueParams/PlotScale, squeeze(param_loads(i,j,:)), param_loads_err, 'rs')
%             legend_string22{(i-1)*(NumSites+1)+j} = ['image ' mat2str(LoadingLogicals{i}) '(site ' int2str(j) ')'];
%         end
%     end
%     [param_loads_all(i,:), param_loads_err_all] = ...
%         find_param_loads(reshape(permute(LoadingLogical(i,:,:), [1,3,2]), 1, numel(LoadingLogical(i,:,:))), repmat(ParamList, [1, NumSites]), NumSeqPerParam);
% 
%     errorbar(UniqueParams/PlotScale, squeeze(param_loads_all(i,:)), abs(param_loads_err_all), 's')
%     % I added abs(param_loads_err_all) because imaginary for some weird
%     % reason.  Fix later.
% 
%     if NumSites > 1
%         legend_string22{i*(NumSites+1)} = ['image ' mat2str(LoadingLogicals{i})];
%     else
%         legend_string22{i} = ['image ' mat2str(LoadingLogicals{i})];
%     end
% end
% lgnd22=legend(legend_string22,'Location','eastoutside');
% set(lgnd22,'color','none');
% mean_loads = mean(param_loads_all(2,:));  %1 for Na, 2 for Cs
% box on
% xlabel({param_name_unit, fname},'interpreter','none')
% ylabel('Loading rate')
% set(gca,'ygrid','on')
% if length(UniqueParams) > 1
%     xlim([UniqueParams(1)- 0.1*(UniqueParams(end)-UniqueParams(1)),UniqueParams(end)+ 0.1*(UniqueParams(end)-UniqueParams(1))]/PlotScale)  ;
% end
% ylim([0, NumSeq/NumParams]); % yl(2)]); %set y min to 0.
% 
% yyaxis right
% ylim([0, 1])
% 
% % % label each loading rate
% % for i = 1:num_loading
% %     for j = 1:num_params
% %         text(unique_params(j)/plot_scale, param_loads_all(i,j), ...
% %             ['-' int2str(100*param_loads_all(i,j)/(num_sites*num_seq_per_param)) '%'])
% %     end
% % end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SURVIVAL RATES VS PARAMETERS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% survival_logical and survival_loading_logical are of dimensions 
% (Number survival plots, number sites, number of sequences).
% find_survival() takes logical of dim 1 x number sequences,  so we run it
% for survival plot and each site.  find_survival also takes the parameters
% to average the logical for each individual parameter.  It outputs the
% average and error for each parameter.  Then we plot unique_params vs this
% output.

fig3 = figure(3); clf(fig3);
if NumSurvival > 0
    p_survival_all(NumSurvival, NumParams) = 0;
    p_survival_err_all(NumSurvival, NumParams) = 0;
    p_survival{NumSites} = 0;
    p_survival_err{NumSites} = 0;

    ncol = NumSurvival;
    if NumSites > 1
        nrow = 1;
    else
        nrow = 1;
    end
    for n = 1 : NumSurvival

        % combine different sites
        [p_survival_all(n,:), p_survival_err_all(n,:)] = ...
            find_survival(reshape(permute(SurvivalLogical(n,:,:), [1,3,2]), 1, numel(SurvivalLogical(n,:,:))),...
                reshape(permute(SurvivalLoadingLogical(n,:,:), [1,3,2]), 1, numel(SurvivalLoadingLogical(n,:,:))),...
                repmat(ParamList, 1, Scan.NumSites), UniqueParams, NumParams);

%         subplot(nrow,ncol,n);
%         errorbar(unique_params/plot_scale, p_survival_all(n,:), p_survival_err_all(n,:), '-bs');
%         if length(unique_params) > 1
%             xlim([unique_params(1)- 0.1*(unique_params(end)-unique_params(1)),unique_params(end)+ 0.1*(unique_params(end)-unique_params(1))]/plot_scale)  ;
%         end
%

        if NumSites > 0
            %subplot(nrow, ncol, (nrow-1)*ncol+n); hold on;
            %title({['survival: image ' logical_cond_2str(SurvivalLogicals{n}, SingleAtomSpecies)], ...
            %    ['loading: image ' logical_cond_2str(SurvivalLoadingLogicals{n}, SingleAtomSpecies)]})
            %line_specs = {'rs-','bs-','ms-','cs-','gs-','ys-'};
            %legend_string3n1{num_sites+1} = '';
            %legend_string3n1{NumSites} = ''; %if not plotting average
            for i = 1:NumSites
                [p_survival{i}, p_survival_err{i}] = find_survival(SurvivalLogical(n,i,:), ...
                    SurvivalLoadingLogical(n,i,:), ParamList, UniqueParams, NumParams);
                % Plot
                %errorbar(UniqueParams/PlotScale, squeeze(p_survival{i}), ...
                %    p_survival_err{i}, line_specs{mod(i-1,6)+1});
                %legend_string3n1{i} = ['site #',num2str(i)];
            end
           
%             hold off;
% 
%             ylim([0 1])
%             if length(UniqueParams) > 1
%                 xlim([UniqueParams(1)- 0.1*(UniqueParams(end)-UniqueParams(1)), UniqueParams(end)+ 0.1*(UniqueParams(end)-UniqueParams(1))]/PlotScale)  ;
%             end
%             grid on; box on;
%             if n < NumSurvival
%                 xlabel({param_name_unit})
%             else
%                 xlabel({param_name_unit, fname}, 'interpreter', 'none')
%             end
%             ylabel('Survival probability')
%             legend(legend_string3n1)
        end

%         ft = 0;
%         if ischar(FitType) && ~strcmp(FitType, 'none')
%             ft = fittype(FitType);
%         elseif iscell(FitType) && (~ischar(FitType{n}) || (ischar(FitType{n}) && ~strcmp(FitType{n}, 'none')))
%             if ischar(FitType{n})
%                 ft = fittype(FitType{n});
%             else
%                 ft = FitType{n};
%             end
%         end
%         if ~isnumeric(ft)
%             try
%                 fit_obj = fit(UniqueParams'/PlotScale, p_survival_all(n,:)', ft)
%                 hold on; plot(fit_obj,'-r'); hold off;
%                 xlimits = xlim;
%                 s1 = ['fit to ', formula(fit_obj)];
%                 [avg, err] = get_mean_error_from_fit(fit_obj);
%                 s2 = sprintf(['\n', num2str(avg)]);
%                 s3 = sprintf(['\n', num2str(err)]);
%                 text(xlimits(1)+(xlimits(2)-xlimits(1))/10, 0.9, [s1, s2, s3])
%                 legend off
%             catch
%                 fprintf('could not fit model\n');
%             end
%         end

%         ylim([0 1])
%         if length(UniqueParams) > 1
%             xlim([UniqueParams(1)- 0.1*(UniqueParams(end)-UniqueParams(1)), UniqueParams(end)+ 0.1*(UniqueParams(end)-UniqueParams(1))]/PlotScale)  ;
%         end
%         grid on; box on;
%         if n < NumSurvival
%             xlabel({param_name_unit})
%         else
%             xlabel({param_name_unit, fname}, 'interpreter','none')
%         end
%         ylabel('Survival probability')
%         title({['survival: ' logical_cond_2str(SurvivalLogicals{n}, SingleAtomSpecies)], ...
%             ['loading: ' logical_cond_2str(SurvivalLoadingLogicals{n}, SingleAtomSpecies)]})
    end
end


%% %%%%%%%%%%%%%%%%%%%%%%%%
% ASSIGN ANALYSIS RESULTS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% analysis.LoadProbability = param_loads_all;
% analysis.LoadProbabilityErr = param_loads_err_all;
% if NumSurvival>0
%    analysis.SurvivalProbability = p_survival_all;
%    analysis.SurvivalProbabilityErr = p_survival_err_all;
%    analysis.SurvivalSiteProbability = p_survival;
%    analysis.SurvivalSiteProbabilityErr = p_survival_err;
% else
%     analysis.SurvivalProbability = [];
%     analysis.SurvivalProbabilityErr = [];
% end
% analysis.SingleAtomLogical = SingleAtomLogical;
% analysis.UniqueParameters = UniqueParams;


