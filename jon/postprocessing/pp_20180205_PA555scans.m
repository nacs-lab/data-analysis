%{
%% Script for PA scan
% Instructions
% Use "Set VPATemp calibration" below to mesaure VPAslope, VPoffset
% In StartScan:
    %  ... = StartScan(Params, NumPerParamAvg, AmpPAAOM, TMergeWait)
    %seq = @(x) NaCsSingleAtom(x, AmpPAAOM, TMergeWait);
    % Comment "Params = ..." and NumPerParamAvg in StartScan
    % Set Scan.ParamName = 'VPATemp', and scale.
% In NaCsSingleAtom:
    % s = NaCsSingleAtom(VPATemp, AmpPAAOM, TMergeWait)
    % Comment VPATemp, AmpPAAOM, TMergeWait
    % Make sure PA, PA OP, and bKeithley turned on.
% Make sure wavemeter logging.

%% Scan PA freq
FreqRange = [554.9, 555.9]; % Freq scan range (351XXX GHz)
stepV = 0.001; %V,  1mV ~ 30 MHz
NumPerParamAvg = 300; % Number Cs loads.
AmpPAAOM = 0.2;
TMergeWait = 10e-3;

VPAslope = 25.934; %put m here
VPAoffset = 465.207; % put os here
wmLogfile = '20180203.csv';

savefile = VPATempScanFunction(FreqRange, stepV, NumPerParamAvg, ...
    TMergeWait, AmpPAAOM, VPAslope, VPAoffset, wmLogfile);

%% Scan 2
FreqRange = [555, 555.3]; % Freq scan range (351XXX GHz)
stepV = 0.001; %V,  1mV ~ 30 MHz
NumPerParamAvg = 800; % Number Cs loads.
AmpPAAOM = 0.2;
TMergeWait = 10e-3;

VPAslope = 25.934; %put m here
VPAoffset = 465.207; % put os here
wmLogfile = '20180203.csv';

savefile = VPATempScanFunction(FreqRange, stepV, NumPerParamAvg, ...
    TMergeWait, AmpPAAOM, VPAslope, VPAoffset, wmLogfile);

%% Scan 3
FreqRange = [555, 555.3]; % Freq scan range (351XXX GHz)
stepV = 0.001; %V,  1mV ~ 30 MHz
NumPerParamAvg = 800; % Number Cs loads.
AmpPAAOM = 0.1;
TMergeWait = 10e-3;

VPAslope = 25.934; %put m here
VPAoffset = 465.207; % put os here
wmLogfile = '20180203.csv';

savefile = VPATempScanFunction(FreqRange, stepV, NumPerParamAvg, ...
    TMergeWait, AmpPAAOM, VPAslope, VPAoffset, wmLogfile);

%% Scan 4
FreqRange = [555, 555.3]; % Freq scan range (351XXX GHz)
stepV = 0.001; %V,  1mV ~ 30 MHz
NumPerParamAvg = 800; % Number Cs loads.
AmpPAAOM = 0.7;
TMergeWait = 1e-3;

VPAslope = 25.934; %put m here
VPAoffset = 465.207; % put os here
wmLogfile = '20180203.csv';

savefile = VPATempScanFunction(FreqRange, stepV, NumPerParamAvg, ...
    TMergeWait, AmpPAAOM, VPAslope, VPAoffset, wmLogfile);
%}

filename = [folder '\20180205\' 'VPAScan_20180205_042242.mat'];
%filename = [folder '\20180205\' 'VPAScan_20180205_065039.mat'];
%filename = [folder '\20180205\' 'VPAScan_20180205_092536.mat'];

folder = 'N:\NaCsLab\Data';
clearfig = 1; berror = 0;
p = load(filename); % Description
filelist = p.filelist;
VPATempList = p.VPATempList;
VPAslope = p.VPAslopeWM;
VPAoffset = p.VPAoffsetWM;
combine_data2({filelist{1}, filelist{end}}, [VPAslope, VPAoffset], clearfig, berror);

%filename = [folder '\20180205\' 'VPAScan_20180205_042242.mat'];
filename = [folder '\20180205\' 'VPAScan_20180205_065039.mat'];
%filename = [folder '\20180205\' 'VPAScan_20180205_092536.mat'];

folder = 'N:\NaCsLab\Data';
clearfig = 0; berror = 0;
p = load(filename); % Description
filelist = p.filelist;
VPATempList = p.VPATempList;
VPAslope = p.VPAslopeWM;
VPAoffset = p.VPAoffsetWM;
combine_data2({filelist{1}, filelist{end}}, [VPAslope, VPAoffset], clearfig, berror);



%filename = [folder '\20180205\' 'VPAScan_20180205_042242.mat'];
%filename = [folder '\20180205\' 'VPAScan_20180205_065039.mat'];
filename = [folder '\20180205\' 'VPAScan_20180205_092536.mat'];

folder = 'N:\NaCsLab\Data';
clearfig = 0; berror = 0;
p = load(filename); % Description
filelist = p.filelist;
VPATempList = p.VPATempList;
VPAslope = p.VPAslopeWM;
VPAoffset = p.VPAoffsetWM;
combine_data2({filelist{1}, filelist{end}}, [VPAslope, VPAoffset], clearfig, berror);


filename = [folder '\20180205\' 'VPAScan_20180205_105923.mat'];

folder = 'N:\NaCsLab\Data';
clearfig = 0; berror = 0;
p = load(filename); % Description
filelist = p.filelist;
VPATempList = p.VPATempList;
VPAslope = p.VPAslopeWM;
VPAoffset = p.VPAoffsetWM;
combine_data2({filelist{1}, filelist{end}}, [VPAslope, VPAoffset], clearfig, berror);
