classdef DataScanSeq < handle

properties
    %d;
    file;
    fname;
    Scan; % Scan properties and image data.
    ScanSeq;  % ScanSeq object used to do scan.
    Analysis;
end

%%%%% Methods %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
methods
    function self = DataScanSeq(file)
        % Initialization using the file dates
        self.file = file;
        self.fname = DateTimeStampFilename(file(1), file(2));
        % Load the file/files
        d = load(self.fname);
        Scan = d.Scan;
        Scan.ParamList = d.ParamList;  % Move ParamList to Scan

        % Move ScanSeq object in DataScanSeq properties
        self.ScanSeq = Scan.ScanSeq;
        Scan.ScanSeq = [];

        % Separate and save scan
        self.Scan = Scan;
        self = SeparateScans(self);
        self.Scan = DataScanSeq.DefineScanParameters(self.Scan);
        
        % Survival analysis
        self = createAnalysis(self);
        
    end
    function self = SeparateScans(self)
        % Separate concatenated scan arrays into individual scans.
        %clear o scanseq p
        p = self.ScanSeq.p;
        Scan = self.Scan;
        %self.Scan = [];
        ParamList = Scan.ParamList;
        ScanSeq = self.ScanSeq;

        % Separate the file
        idxFirst = 0;  idxLast = 0;
        for i = 1:length(p)
            % Index of first and last point
            idxFirst = idxLast + 1;
            idxLast = idxFirst + ScanSeq.scanLength(i) - 1;

            % Initialize Scan to be same as d.Scan
            ScanTemp = Scan;

            % Filter only Idx's in IndxRange
            idxParamList = idxFirst <= ParamList & ParamList <= idxLast; %ParamList is (1 x number seqs)
            ScanTemp.ParamList = ParamList(idxParamList); %ParamList was stored in d.ParamList. Now Scan.ParamList.
            ScanTemp.Images = Scan.Images(:, :, repelem(idxParamList, Scan.NumImages) ); %Images is (1 x 4*number seqs)
            ScanTemp.UniqueParams = unique(ScanTemp.ParamList); % 1 x number of parameters
            ScanTemp.NumParams = length(ScanTemp.UniqueParams); % Number of parameters
            
            idxParams = idxFirst <= Scan.Params & Scan.Params <= idxLast; %Scan.Params is (1 x num per group)
            ScanTemp.Params = Scan.Params( idxParams );
            ScanTemp.NumPerGroup = length( ScanTemp.Params );

            % Update idx to scanned units (not yet)
            ScanTemp.ParamName = p(i).ParamName;
            ScanTemp.ParamUnits = p(i).ParamUnits;
            ScanTemp.PlotScale = p(i).PlotScale;

            % Save
            %ScanTemp = DataScanSeq.DefineScanParameters(ScanTemp);
            ScanList(i) = ScanTemp;
        end
        self.Scan = ScanList;
    end
    function self = createAnalysis(self)
        % Create Analysis property with survival data for each scan.
        Scan = self.Scan;
        %Analysis(length(Scan)) = struct(); %got error
        for i = 1 : length(Scan)
            S = Scan(i);
            % Find single atoms
            [SingleAtomLogical, SingleAtomSignal, AvImages] = find_single_atoms_sites( ...
                S.Images, S.SingleAtomSites, S.Cutoffs, S.NumImagesPerSeq, S.NumSites, S.BoxSize, S.FrameSize);

            A.SingleAtomLogical = SingleAtomLogical;
            A.SingleAtomSignal = SingleAtomSignal;
            A.AvImages = AvImages;
            
            % Create loading and survival logicals. 
            %These are of dimensions (Number survival plots, number sites, number of sequences).
            LoadingLogical = find_logical(S.LoadingLogicals, SingleAtomLogical, S.NumSites, S.NumSeq);
            SurvivalLoadingLogical = find_logical(S.SurvivalLoadingLogicals, SingleAtomLogical, S.NumSites, S.NumSeq);
            SurvivalLogical = find_logical(S.SurvivalLogicals, SingleAtomLogical, S.NumSites, S.NumSeq);
            
            A.LoadingLogical = LoadingLogical;
            A.SurvivalLoadingLogical = SurvivalLoadingLogical;
            A.SurvivalLogical = SurvivalLogical;

            % Calculate survival data
            %p_survival{S.NumSites} = 0;
            %p_survival_err{S.NumSites} = 0;
            ProbSurvival = zeros(S.NumSurvival, S.NumSites, S.NumParams);
            ProbSurvivalErr = ProbSurvival;
            
            for n = 1 : S.NumSurvival
                for m = 1 : S.NumSites
                    [ProbSurvival(n,m,:), ProbSurvivalErr(n,m,:)] = find_survival(SurvivalLogical(n,m,:), ...
                        SurvivalLoadingLogical(n,m,:), S.ParamList, S.UniqueParams, S.NumParams);
                end
            end
            A.ProbSurvival = ProbSurvival;
            A.ProbSurvivalErr = ProbSurvivalErr;
                        
            % Save into Analysis
            Analysis(i) = A; 
        end
        self.Analysis = Analysis;
    end
    function self = redoAnalysis(self)
        % Here I can change the cutoff, atom sites, box size, and the
        % LoadingLogicals, SurvivalLogicals, and SurvivalLoadingLogicals.
        % NEED TO USE INPUTPARSER CLASS
        self = createAnalysis(self);
    end
    
    function [x,y] = PlotSurvival(self, i, scanFieldIdx, survival)
        % Plot survival. ProbSurvival is dimensions (NumSurvival, NumSites, NumParams)
        %i = 1; % which scan
        
        Analysis = self.Analysis(i);
        ProbSurvival = Analysis.ProbSurvival;
        ProbSurvivalErr = Analysis.ProbSurvivalErr;
        
        %x-axis
        ScanSeq = self.ScanSeq;
        scanIdx = ScanSeq.scanIdx{i};
        scannedFields = ScanSeq.fields(scanIdx);
        %scanFieldIdx = 1; % which scanned variable to use as x-axis
        scannedField = scannedFields{scanFieldIdx}; 
        p = ScanSeq.p(i);
        x = p.(scannedField);
        x = x' / p.PlotScale;
        
        site = 1; % which site
        %survival = 1; % white survival 
        y = squeeze( ProbSurvival(survival, site, :) );
        yerr = squeeze( ProbSurvival(survival, site, :) );
        % Plot        
        %figure(4); clf;
      
        %plot(x, y);
        
    end
end

%%%% Static Methods %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
methods (Static)
    function Scan2 = DefineScanParameters(Scan)
        % Define Scan parameters
        for i = 1: length(Scan)
            S = Scan(i);

            % Calculate total sequences
            S.NumImagesPerSeq = S.NumImages;
            S.NumImagesTotal = size(S.Images,3);
            S.NumSeq = S.NumImagesTotal / S.NumImagesPerSeq;

            % Total number of groups scanned
            S.NumSeqPerGrp = length(S.Params);
            S.NumGrp = S.NumImagesTotal / (S.NumImagesPerSeq * S.NumSeqPerGrp) ;

            S.NumLoading = length(S.LoadingLogicals); % Number of loading plots
            S.NumSurvival = length(S.SurvivalLoadingLogicals); % Number of survival plots

            % Save
            Scan2(i) = S;
        end
    end
end
end
