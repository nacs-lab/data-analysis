function output = SeparateMultipleScans2(file, savedata)
% Separates multiple scans.  - JDH  


% Load unseparated file
%file = [20180115, 164803];
fname = DateTimeStampFilename(file(1), file(2));
d = load(fname);

% Plot data
[Analysis, MeanLoads, ParamList] = plot_data(d.Scan, d.Scan.Images, fname);

% Unload
scanseq = d.Scan.ScanSeq;
p = scanseq.p;

% % Initialize variables and set defaults
% if ~exist('savedata')
%     savedata = 0;
% end
% if ~isfield(o,'PlotScale')
%     o(1).PlotScale = 1;
% end
% if ~isfield(o,'ParamUnits')
%     o(1).ParamUnits = '';
% end
% if ~isfield(o,'ParamName')
%     o(1).ParamName = '';
% end

% % If any fields are empty, set to first one
% fields = fieldnames(o);
% for i = 1:length(o)
%     for m = 1:length(fields)
%         if isempty( getfield(o(i), fields{m}) )
%             o(i) = setfield( o(i), fields{m}, getfield(o(1), fields{m}) );
%         end
%     end
% end

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

    idxLogic = idxFirst <= d.Scan.Params & d.Scan.Params <= idxLast;
    Scan.Params = d.Scan.Params( idxLogic );
    Scan.NumPerGroup = length( Scan.Params );

    % Update idx to scanned units
    Scan.ParamName = p(i).ParamName;
    Scan.ParamUnits = p(i).ParamUnits;
    Scan.PlotScale = p(i).PlotScale;
    scanIdx = scanseq.scanIdx{i}; %indices for scanned variables
    scannedField = scanseq.fields{scanIdx(1)}; %choose first scanned index if multiple ones. 
    Params = p.(scannedField);
    Scan.Params = Params( Scan.Params - (idxFirst - 1) );

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