function plot_vtweezeralign(fname, interval)
if ~exist('interval', 'var')
    interval = 0;
end
while 1
    tstart = now() * 86400;
    m = load(fname);
    all_pos = m.all_pos;
    all_names = m.all_names;
    
    % Turn hold back on after we finish the first plot.
    hold off;
    first_plot = 1;
    % Current plotting direction
    direction = 0;
    % Data for the current line.
    pos = [];
    surv = [];
    surv_err = [];
    
    for i = 1:length(all_pos)
        name = all_names{i};
        data = DataScanSeq(name);
        [~, SurvProb, SurvProbErr] = data.getSurvival(2);
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
            errorbar(pos(1:end - 1), surv(1:end - 1), surv_err(1:end - 1), ...
                '.-', 'CapSize', 2, 'Linewidth', 1, ...
                'Marker', '.', 'MarkerSize', 14);
            % The two last points are in the new direction,
            % keep them for the next line.
            % Note that the point at the end will be used for both lines,
            % which make it easier to keep track of how the line moves.
            pos = pos(end - 1:end);
            surv = surv(end - 1:end);
            surv_err = surv_err(end - 1:end);
            if first_plot
                % Turn hold on after the first line so that we'll clear
                % whatever was on the screen before.
                first_plot = 0;
                hold on;
            end
        end
        direction = cur_dir;
    end
    
    if ~isempty(pos)
        % Make sure all points are plotted.
        % Note that the last point in pos is never plotted in the loop above
        % so we need to do this as long as the data is not empty.
        errorbar(pos, surv, surv_err, ...
            '.-', 'CapSize', 2, 'Linewidth', 1, ...
            'Marker', '.', 'MarkerSize', 14);
    end
    hold off;
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
