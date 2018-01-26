%% Fit the wavemeter data to lines  14
% Import wavemeter data from log file
n=1; m=2;
o(n) = combine_data2({'20170818_232101','20170819_114623'},[113.9, 729.7],0);  %scan 14
o(m) = combine_data2({'20170819_120205','20170819_161612'},[113.9, 729.7],0);  %scan 14, pt2

filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170819\8-18Scan14.csv';
delimiter = ',';
startRow = 2;
formatSpec = '%s%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
clearvars filename delimiter startRow formatSpec fileID ans; %dataArray

% Fitting wavemeter data to line
times = dataArray{1};
wl = dataArray{2};
wl = wl - 351000; 

wl1 = wl(1:6097);
wl2 = wl(6098:end);
plot(o(n).params ) ;

%Voltage axis
o(n).params(1)
VPATemp1 = linspace( o(n).params(1), o(n).params(end), length(wl1) ) ; 
VPATemp2 = linspace( o(m).params(1), o(m).params(end), length(wl2) ) ; 

figure; 
fit1 = fit(VPATemp1', wl1, 'poly1')
fit2 = fit(VPATemp2', wl2, 'poly1')

plot(fit1, VPATemp1, wl1, 'b');
hold on; 
plot(fit2, VPATemp2, wl2, 'g'); 
xlabel('VPATemp'); ylabel('351XXX (GHz)'); 

saveas(gcf, 'wm_scan14.fig' );

%% Fit the wavemeter data to lines. Scan 15
% Import wavemeter data from log file
n=3;
o(n) = combine_data2({'20170819_234827','20170820_150250'},[117.8, 705.9],0);  %scan 15

filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170819\8-19Scan15.csv';
delimiter = ',';
startRow = 2;
formatSpec = '%s%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
clearvars filename delimiter startRow formatSpec fileID ans; %dataArray

% Fitting wavemeter data to line
times = dataArray{1};
wl = dataArray{2};
wl = wl - 351000;

figure;
plot(wl)
wl1 = wl(1:end);
%wl2 = wl(6098:end);
plot(o(n).params ) ;

%Voltage axis
o(n).params(1)
o(n).params(end)
VPATemp1 = linspace( o(n).params(1), o(n).params(end), length(wl1) ) ; 
%VPATemp2 = linspace( o(m).params(1), o(m).params(end), length(wl2) ) ; 

figure; 
fit1 = fit(VPATemp1', wl1, 'poly1')
%fit2 = fit(VPATemp2', wl2, 'poly1')

plot(fit1, VPATemp1, wl1, 'b');
%hold on; 
%plot(fit2, VPATemp2, wl2, 'g'); 
xlabel('VPATemp'); ylabel('351XXX (GHz)'); 

saveas(gcf, 'wm_scan15.fig' );

%% Fit the wavemeter data to lines. Scan 16
n=4;
o(n) = combine_data2({'20170820_151457','20170820_172910'},[117.8, 705.9],0);  %scan 16  %XXX conv is weird

% Import wavemeter data from log file
filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170819\8-20Scan16.csv';
delimiter = ',';
startRow = 2;
formatSpec = '%s%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
clearvars filename delimiter startRow formatSpec fileID ans; %dataArray

% Fitting wavemeter data to line
times = dataArray{1};
wl = dataArray{2};
wl = wl - 351000;

figure;
plot(wl)
wl1 = wl(1:end);
%wl2 = wl(6098:end);
plot(o(n).params ) ;

%Voltage axis
o(n).params(1)
o(n).params(end)
VPATemp1 = linspace( o(n).params(1), o(n).params(end), length(wl1) ) ; 
%VPATemp2 = linspace( o(2).params(1), o(2).params(end), length(wl2) ) ; 

figure; 
fit1 = fit(VPATemp1', wl1, 'poly1')
%fit2 = fit(VPATemp2', wl2, 'poly1')

plot(fit1, VPATemp1, wl1, 'b');
%hold on; 
%plot(fit2, VPATemp2, wl2, 'g'); 
xlabel('VPATemp'); ylabel('351XXX (GHz)'); 

saveas(gcf, 'wm_scan16.fig' );

%% Fit the wavemeter data to lines. Scan 17
% Import wavemeter data from log file
n=5;
o(n) = combine_data2({'20170820_220645','20170821_064104'},[123.6, 676.9],0);  %scan 17

filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170819\8-20Scan17.csv';
delimiter = ',';
startRow = 2;
formatSpec = '%s%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
clearvars filename delimiter startRow formatSpec fileID ans; %dataArray

% Fitting wavemeter data to line
times = dataArray{1};
wl = dataArray{2};
wl = wl - 351000;
plot(o(n).params ) ;

figure;
plot(wl)
wl1 = wl(1:end);
%wl2 = wl(6098:end);

%Voltage axis
o(n).params(1)
o(n).params(end)
VPATemp1 = linspace( o(n).params(1), o(n).params(end), length(wl1) ) ; 
%VPATemp2 = linspace( o(2).params(1), o(2).params(end), length(wl2) ) ; 

figure; 
fit1 = fit(VPATemp1', wl1, 'poly1')
%fit2 = fit(VPATemp2', wl2, 'poly1')

plot(fit1, VPATemp1, wl1, 'b');
%hold on; 
%plot(fit2, VPATemp2, wl2, 'g'); 
xlabel('VPATemp'); ylabel('351XXX (GHz)'); 

saveas(gcf, 'wm_scan17.fig' );

%% Fit the wavemeter data to lines. Scan 18
% Import wavemeter data from log file
n=6;
o(n) = combine_data2({'20170821_064925','20170821_104627'},[95.622,725.7],0);  %scan 18

filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170819\8-20Scan18.csv';
delimiter = ',';
startRow = 2;
formatSpec = '%s%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
clearvars filename delimiter startRow formatSpec fileID ans; %dataArray

% Fitting wavemeter data to line
times = dataArray{1};
wl = dataArray{2};
wl = wl - 351000;
plot(o(n).params ) ;

figure;
plot(wl)
wl1 = wl(1:end);
%wl2 = wl(6098:end);

%Voltage axis
o(n).params(1)
o(n).params(end)
VPATemp1 = linspace( o(n).params(1), o(n).params(end), length(wl1) ) ; 
%VPATemp2 = linspace( o(m).params(1), o(m).params(end), length(wl2) ) ; 

figure; 
fit1 = fit(VPATemp1', wl1, 'poly1')
%fit2 = fit(VPATemp2', wl2, 'poly1')

plot(fit1, VPATemp1, wl1, 'b');
%hold on; 
%plot(fit2, VPATemp2, wl2, 'g'); 
xlabel('VPATemp'); ylabel('351XXX (GHz)'); 

saveas(gcf, 'wm_scan18.fig' );



%% Fit the wavemeter data to lines. Scan 18
% Import wavemeter data from log file
n=7;
o(n) = combine_data2({'20170821_105428','20170821_161856'},[125.5, 743.5],0);  %scan 19

filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170819\8-20Scan19.csv';
delimiter = ',';
startRow = 2;
formatSpec = '%s%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);
clearvars filename delimiter startRow formatSpec fileID ans; %dataArray

% Fitting wavemeter data to line
times = dataArray{1};
wl = dataArray{2};
wl = wl - 351000;
plot(o(n).params ) ;

figure;
plot(wl)
wl1 = wl(1:end);
%wl2 = wl(6098:end);

%Voltage axis
o(n).params(1)
o(n).params(end)
VPATemp1 = linspace( o(n).params(1), o(n).params(end), length(wl1) ) ; 
%VPATemp2 = linspace( o(m).params(1), o(m).params(end), length(wl2) ) ; 

figure; 
fit1 = fit(VPATemp1', wl1, 'poly1')
%fit2 = fit(VPATemp2', wl2, 'poly1')

plot(fit1, VPATemp1, wl1, 'b');
%hold on; 
%plot(fit2, VPATemp2, wl2, 'g'); 
xlabel('VPATemp'); ylabel('351XXX (GHz)'); 

saveas(gcf, 'wm_scan19.fig' );

