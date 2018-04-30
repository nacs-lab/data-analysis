function plot_vtweezeralign(fname, interval)
if ~exist('interval', 'var')
    interval = 0;
end

while 1
    tstart = now() * 86400;
    m = load(fname);
    all_pos = m.all_pos;
    all_names = m.all_names;

    figure(1);
    % Turn hold back on after we finish the first plot.
    hold off;
    % Current plotting direction
    direction = 0;
    % Data for the current line.
    pos = [];
    surv = [];
    surv_err = [];
    fits = {};

    for i = 1:length(all_pos)
        name = all_names{i};
        while 1
            try
                data = DataScanSeq(name);
                [~, SurvProb, SurvProbErr] = data.getSurvival(2);
                break;
            catch
                pause(1);
            end
        end
        pos(end + 1) = all_pos(i);
        surv(end + 1) = SurvProb;
        surv_err(end + 1) = SurvProbErr;
        if length(pos) == 1
            % First ever point
            continue;
        elseif pos(end) > pos(end - 1)
            cur_dir = 1;
        else
            cur_dir = -1;
        end
        if direction ~= 0 && direction ~= cur_dir
            % Detect if we have already set a direction
            % from the last two points and if the current direction
            % is different from that.
            % Exclude the point that is in the wrong direction (current point)
            % from the plot.
            [fitparam, fiterr] = do_plot(pos(1:end - 1), surv(1:end - 1), surv_err(1:end - 1));
            fits(1:4, end + 1) = {pos(1), pos(end - 1), fitparam, fiterr};
            % The two last points are in the new direction,
            % keep them for the next line.
            % Note that the point at the end will be used for both lines,
            % which make it easier to keep track of how the line moves.
            pos = pos(end - 1:end);
            surv = surv(end - 1:end);
            surv_err = surv_err(end - 1:end);
        end
        direction = cur_dir;
    end

    if ~isempty(pos)
        % Make sure all points are plotted.
        % Note that the last point in pos is never plotted in the loop above
        % so we need to do this as long as the data is not empty.
        [fitparam, fiterr] = do_plot(pos, surv, surv_err);
        fits(1:4, end + 1) = {pos(1), pos(end), fitparam, fiterr};
    end
    hold off;

    figure(2);
    hold off;
    widths_od = [];
    widths_ev = [];
    widths_oderr = [];
    widths_everr = [];
    for i = 2:size(fits, 2) - 1
        fitparam = fits{3, i};
        fiterr = fits{4, i};
        if ~isempty(fitparam)
            if mod(i, 2) == 0
                widths_ev(end + 1) = fitparam(4);
                widths_everr(end + 1) = fiterr(4);
            else
                widths_od(end + 1) = fitparam(4);
                widths_oderr(end + 1) = fiterr(4);
            end
        end
    end
    errorbar(1:length(widths_od), widths_od, widths_oderr);
    hold on;
    errorbar(1:length(widths_ev), widths_ev, widths_everr);
    hold off;
    legend('Forward', 'Backward');

    figure(3);
    hold off;
    ratios = [];
    ratios_err = [];
    for i = 2:size(fits, 2) - 2
        fitparam1 = fits{3, i};
        fiterr1 = fits{4, i};
        fitparam2 = fits{3, i + 1};
        fiterr2 = fits{4, i + 1};
        endpos = fits{1, i + 1};
        if isempty(fitparam1) || isempty(fitparam2)
            continue;
        end
        len1 = abs(endpos - fitparam1(3));
        len2 = abs(endpos - fitparam2(3));
        len1_rerr = fiterr1(3) / len1;
        len2_rerr = fiterr2(3) / len2;
        if mod(i, 2) == 0
            ratio = len2 / len1;
        else
            ratio = len1 / len2;
        end
        ratio_rerr = sqrt(len1_rerr^2 + len2_rerr^2);
        ratio_err = ratio * ratio_rerr;
        ratios(end + 1) = ratio;
        ratios_err(end + 1) = ratio_err;
    end
    errorbar(1:length(ratios), ratios, ratios_err);

    drawnow();
    if interval == 0
        break;
    end
    while now() * 86400 < tstart + interval
        drawnow();
        pause(0.5);
    end
end
end

function [param, err] = do_plot(pos, surv, surv_err)
if length(pos) < 3
    errorbar(pos, surv, surv_err, ...
        '.-', 'CapSize', 2, 'Linewidth', 1, ...
        'Marker', '.', 'MarkerSize', 14);
    % Turn hold on after the first line so that we'll clear
    % whatever was on the screen before.
    hold on;
    param = [];
    err = [];
    return;
end

h = errorbar(pos, surv, surv_err, ...
    '.-', 'CapSize', 2, ...
    'Marker', '.', 'MarkerSize', 14);
% Turn hold on after the first line so that we'll clear
% whatever was on the screen before.
hold on;

a = max(surv);
[minv, mini] = min(surv);
b = a - minv;
m = (a + b) / 2;
mi_lo = mini;
mi_hi = mini;
while 1
    if mi_lo == 1
        mi_lo = pos(1);
        break;
    elseif surv(mi_lo) > m
        mi_lo = (pos(mi_lo) + pos(mi_lo + 1)) / 2;
        break;
    end
    mi_lo = mi_lo - 1;
end
while 1
    if mi_hi == length(pos)
        mi_hi = pos(end);
        break;
    elseif surv(mi_hi) > m
        mi_hi = (pos(mi_hi) + pos(mi_hi - 1)) / 2;
        break;
    end
    mi_hi = mi_hi + 1;
end
c = (mi_hi + mi_lo) / 2;
d = abs(mi_hi - mi_lo) / 2 / 1.17;

ft = fit(pos', surv', 'a - b * exp(-((x - c) / d)^2 / 2)', ...
    'Start', [a, b, c, d]);
xfit = linspace(pos(1), pos(end), 1000);
yfit = ft(xfit);
% plot(xfit, yfit, '-', 'Color', h.Color);
[param, err] = get_mean_error_from_fit(ft);

end
