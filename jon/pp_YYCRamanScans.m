%% Load data  -0.6 GHz  (10mW)
date = '20180707'; time = '203908';
data = DataScanSeq([date '_' time]);

%% Plot data
PlotLogics = { {[1,1],[2,1]} };

%fitvar = {'FitType',' a*exp(-x/c)','Start', [1, 10]};
%fitvar = {'FitType','a - b*exp(-(x-c)^2/d^2)','Start', [0.5, 0.3, 298.18, .02]};
fitvar = {'FitType', 'a - b/(1 + (x-c)^2/(gamma/2)^2)','Start', [0.5, 0.3, 298.18, .02]};
FitLogics= { {fitvar, fitvar} };

data.plotSurvival('PlotLogics', PlotLogics, ...
    'FitLogics', FitLogics);

%% Load data  -0.8 GHz (10mW)
date = '20180707'; time = '214833';
data = DataScanSeq([date '_' time]);

%% Plot data
PlotLogics = { {[1,1],[2,1]} };

%fitvar = {'FitType',' a*exp(-x/c)','Start', [1, 10]};
%fitvar = {'FitType','a - b*exp(-(x-c)^2/d^2)','Start', [0.5, 0.3, 298.18, .02]};
fitvar = {'FitType', 'a - b/(1 + (x-c)^2/(gamma/2)^2)','Start', ...
    [0.5, 0.3, 298.155, .02]};
FitLogics= { {fitvar, fitvar} };

data.plotSurvival('PlotLogics', PlotLogics, ...
    'FitLogics', FitLogics);

%% Load data  -0.8 GHz PA (10mW)
date = '20180708'; time = '002802';
data = DataScanSeq([date '_' time]);

%% Plot data
PlotLogics = { {[1,1],[2,1]} };

fitvar = {'FitType',' a*exp(-x/b) + c*exp(-x/d)','Start', [1, 10, 0.1, 50]};
fitvar = {'FitType',' a*exp(-x/b)+c','Start', [1, 10, 0.1]};
%fitvar = {'FitType','a - b*exp(-(x-c)^2/d^2)','Start', [0.5, 0.3, 298.18, .02]};
%fitvar = {'FitType', 'a - b/(1 + (x-c)^2/(gamma/2)^2)','Start', ...
%    [0.5, 0.3, 298.155, .02]};
FitLogics= { {fitvar, fitvar} };

data.plotSurvival('PlotLogics', PlotLogics, ...
    'FitLogics', FitLogics);

%% Load data  -1.0 GHz (10mW)
date = '20180708'; time = '081600';
data = DataScanSeq([date '_' time]);

%% Plot data
data = data.modifyScan('PlotScale', 1e6, 'ParamName', 'fInnolumeRamanAOM', 'ParamUnits', 'MHz');
PlotLogics = { {[1,1],[2,1]} };
fitvar = {'FitType', 'a - b/(1 + (x-c)^2/(gamma/2)^2)','Start', ...
    [0.7, 0.2, 298.1, .02]};
FitLogics= { {fitvar, fitvar} };

data.plotSurvival('PlotLogics', PlotLogics, ...
    'FitLogics', FitLogics);

%% Load data  -1.5 GHz (10mW)
date = '20180708'; time = '091634';
data = DataScanSeq([date '_' time]);

%% Plot data
data = data.modifyScan('PlotScale', 1e6, 'ParamName', 'fInnolumeRamanAOM', 'ParamUnits', 'MHz');
PlotLogics = { {[1,1],[2,1]} };

fitvar = {'FitType', 'a - b/(1 + (x-c)^2/(gamma/2)^2)','Start', ...
    [0.7, 0.2, 298.100, .02]};
FitLogics= { {fitvar, fitvar} };

data.plotSurvival('PlotLogics', PlotLogics, ...
    'FitLogics', FitLogics);

%% Load data  -1.5 GHz,  attempt 2 (10mW)
date = '20180708'; time = '210745';
data = DataScanSeq([date '_' time]);

%% Plot data
data = data.modifyScan('PlotScale', 1e6, 'ParamName', 'fInnolumeRamanAOM', 'ParamUnits', 'MHz');
PlotLogics = { {[1,1],[2,1]} };

fitvar = {'FitType', 'a - b/(1 + (x-c)^2/(gamma/2)^2)','Start', ...
    [0.7, 0.2, 298.100, .02]};
FitLogics= { {fitvar, fitvar} };

data.plotSurvival('PlotLogics', PlotLogics, ...
    'FitLogics', FitLogics);


%% Load data  -3 GHz (14mW)
date = '20180708'; time = '223849';
data = DataScanSeq([date '_' time]);

%% Plot data
data = data.modifyScan('PlotScale', 1e6, 'ParamName', 'fInnolumeRamanAOM', 'ParamUnits', 'MHz');
PlotLogics = { {[1,1],[2,1]} };

fitvar = {'FitType', 'a - b/(1 + (x-c)^2/(gamma/2)^2)','Start', ...
    [0.7, 0.2, 298.07, .005]};
FitLogics= { {fitvar, fitvar} };

data.plotSurvival('PlotLogics', PlotLogics, ...
    'FitLogics', FitLogics);


%% Load data  -3 GHz PA
date = '20180709'; time = '065705';
data = DataScanSeq([date '_' time]);

%% Plot data
PlotLogics = { {[1,1],[2,1]} };

%fitvar = {'FitType',' a*exp(-x/b) + c*exp(-x/d)','Start', [1, 10, 0.1, 50]};
fitvar = {'FitType',' a*exp(-x/b)+c','Start', [1, 100, 0.1]};
%fitvar = {'FitType','a - b*exp(-(x-c)^2/d^2)','Start', [0.5, 0.3, 298.18, .02]};
%fitvar = {'FitType', 'a - b/(1 + (x-c)^2/(gamma/2)^2)','Start', ...
%    [0.5, 0.3, 298.155, .02]};
FitLogics= { {fitvar, fitvar} };

data.plotSurvival('PlotLogics', PlotLogics, ...
    'FitLogics', FitLogics);

%% Load data  -10 GHz (16.7mW)
date = '20180711'; time = '012050';
data = DataScanSeq([date '_' time]);

%% Plot data
data = data.modifyScan('PlotScale', 1e6, 'ParamName', 'fInnolumeRamanAOM', 'ParamUnits', 'MHz');
PlotLogics = { {[1,1],[2,1]} };

fitvar = {'FitType', 'a - b/(1 + (x-c)^2/(gamma/2)^2)','Start', ...
    [0.7, 0.2, 298.082, .005]};
FitLogics= { {fitvar, fitvar} };

data.plotSurvival('PlotLogics', PlotLogics, ...
    'FitLogics', FitLogics);

%% Summary plot
detuning = [0.6, 0.8, 1.0, 1.5, 1.5, 3, 10];
power = [10, 10, 10, 10, 10, 14, 16.7];
detuningWithPower = detuning./(power/10);
starkshift = [298.192, 298.156, 298.133, 298.103 298.101, 298.070, 298.083];
starkshifterr = [.001, .001, 0.001, .002, 0.002, 0.001, 0.001];
FWHM = [44, 26, 15, 5, 8, 4.7, 5.8];
FWHMerr = [9, 4, 4, 2, 2, 0.5, 0.8];
ind = 1:length(detuning)-1;

figure(1);
errorbar(detuning(ind), starkshift(ind), starkshifterr(ind), 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
ylim([ 298.05, 298.2]);
fitData(detuning(ind), starkshift(ind), 'a/x + b', 'Start', [0.3, 298.07], 'Plot', 1);
xlabel('Detuning (GHz)'); 
ylabel('Raman resonance (MHz)');
ylim([ 298.05, 298.2]);
title('Raman resonance stark shift vs detuning');

figure(2);
errorbar(detuning(ind), FWHM(ind), FWHMerr(ind), 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
ylim([0, 60]);
fitData(detuning(ind), FWHM(ind), 'a/x^2 +b', 'Start', [100, 0], 'Plot', 1);
xlabel('Detuning (GHz)'); 
ylabel('FWHM (kHz)');
ylim([0, 60]);
title('Raman resonance FWHM vs detuning');