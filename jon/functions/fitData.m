function ft = fitData(x, y, fittype, varargin)
% Fitting function with lots of options.
    % fittype = 'a*exp(-(x-b)^2/w^2) + os', or any other function with x
    % indepedent variable.
    % Start = [ aStart, bStart, osStart, wStart]
    % FitRange = [xmin, xmax] to include a fitting range.
    % FitCenter = [xcenter, xwidth] to include a fitting range.
    % Plot = 1 to plot the fitted line.

% Parse inputs to set default and options
p = inputParser;
addParameter(p, 'Start', []);
addParameter(p, 'FitRange', []);
addParameter(p, 'FitCenter', []);
addParameter(p, 'Plot', 0);
addParameter(p, 'TextRow', 1);
parse(p, varargin{:});
Start = p.Results.Start;
FitRange = p.Results.FitRange;
FitCenter = p.Results.FitCenter;
bPlot = p.Results.Plot;
TextRow = p.Results.TextRow;

% Make sure x and y are column vectors
szx = size(x);
if szx(2) > szx(1)
    x = x';
end
szy = size(y);
if szy(2) > szy(1)
    y = y';
end


% Select range to fit
if ~isempty(FitCenter)
    FitRange = FitCenter(1) + FitCenter(2)*[-1/2 1/2];
end
if ~isempty(FitRange)
    exclude = x < min(FitRange) | x > max(FitRange);
    if all(exclude)
        beep;
        disp('Warning! No points within fitting range. Not using fit range');
        exclude = [];
    end
else
    exclude = [];
end

% Do fit
if ~isempty(Start)
    ft = fit(x, y, fittype, 'Start', Start, 'Exclude', exclude)
elseif isempty(Start)
    ft = fit(x, y, fittype,'Exclude', exclude)
end
 

% Plot
if bPlot
    hold on;
    %xlimits = xlim;
    if isempty(FitRange)
        plot(ft,'-r');
    else
        xfit = linspace(max(FitRange(1), min(x)), min(FitRange(2), max(x)), 200);
        yfit = ft(xfit);
        xlimits = xlim;
        plot(xfit, yfit, '-r');
        xlim(xlimits);
    end
          
    %xlim(xlimits); %reset x limit
    hold off;
    legend off;
end

% Text
s1 = ['Fit to ', formula(ft)];
[avg, err] = get_mean_error_from_fit(ft);  % I don't know what this is
s2 = sprintf(['\n', num2str(avg, 6)]);
s3 = sprintf(['\n', num2str(err, 2)]);
disp(s1);
disp('Averages and standard deviations: ');
disp(s2);
disp(s3);
if bPlot
    xlimits = xlim;
    ylimits = ylim;
    text( xlimits(1)+(xlimits(2)-xlimits(1))/10, ...
        ylimits(2) - (TextRow - 0.5)*0.2*(ylimits(2)-ylimits(1)), [s1, s2, s3]);
end

end