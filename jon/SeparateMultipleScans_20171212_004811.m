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
    
    IdxLogic = IdxRange{i}(1) <= d.Scan.Params & d.Scan.Params <= IdxRange{i}(2);
    Scan.Params = d.Scan.Params( IdxLogic ); 
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


%% Plot the data

replot2([20171212, 004812])
