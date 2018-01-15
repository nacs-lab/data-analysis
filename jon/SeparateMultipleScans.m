function output = SeparateMultipleScans(file, o, savedata)
% Separates multiple scans.  - JDH  
    %file = [date, time].
    %o(i).Params = [...];
    %o(i).ParamUnits = 'MHz';
    %o(i).PlotScale = 1; 
    %savedata = switch for saving data as .m files with +i seconds from
    %original
    
% Initialize variables
if ~exist('savedata')
    savedata = 0;
end

% Load unseparated file
%file = [20180115, 164803];
fname = DateTimeStampFilename(file(1), file(2));
d = load(fname);
%plot data
[Analysis, MeanLoads, ParamList] = plot_data(d.Scan, d.Scan.Images, fname);

% If any fields are empty, set to first one
fields = fieldnames(o);
for i = 1:length(o)
    for m = 1:length(fields)
        if isempty( getfield(o(i), fields{m}) )
            o(i) = setfield( o(i), fields{m}, getfield(o(1), fields{m}) );
        end
    end
end

% Separate the file
idxFirst = 0;  idxLast = 0;
for i = 1:length(o)
    % index of first and last point
    idxFirst = idxLast + 1; 
    idxLast = idxFirst + length(o(i).Params) - 1;
    
    % Initialize Scan to be same as d.Scan
    Scan = d.Scan;

    % Filter only Idx's in IndxRange
    idxLogic = idxFirst <= d.ParamList & d.ParamList <= idxLast;
    Scan.Images = d.Scan.Images(:, :, repelem(idxLogic, d.Scan.NumImages) );

    idxLogic = idxFirst <= d.Scan.Params & d.Scan.Params <= idxLast;
    Scan.Params = d.Scan.Params( idxLogic );
    Scan.NumPerGroup = length( Scan.Params );

    % Update idx to scanned units
    Scan.ParamName = o(i).ParamName;
    Scan.ParamUnits = o(i).ParamUnits;
    Scan.PlotScale = o(i).PlotScale;
    Scan.Params = o(i).Params( Scan.Params - (idxFirst - 1) );

    %Create new fname for filtered data which is 1 sec later
    fname = DateTimeStampFilename(file(1), file(2) + i);

    %redo analysis on filtered data
    [Analysis, MeanLoads, ParamList] = plot_data(Scan, Scan.Images, fname);

    %Save to o struct
    o(i).Scan = Scan;
    o(i).Analysis = Analysis;
    o(i).ParamList = ParamList;
    
    %save data as new .mat file
    memmap = d.memmap;
    ErrorCode = d.ErrorCode;
    if savedata
        save(fname, 'memmap', 'ErrorCode', 'Scan', 'ParamList', 'Analysis');
    end
end

%output
output = o; 