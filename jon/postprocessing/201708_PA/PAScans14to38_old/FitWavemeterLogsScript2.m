%% Fit the wavemeter data to lines  14
% Import wavemeter data from log file
n=1; m=2;
o(n) = combine_data2({'20170818_232101','20170819_114623'},[113.9, 729.7],0);  %scan 14
o(m) = combine_data2({'20170819_120205','20170819_161612'},[113.9, 729.7],0);  %scan 14, pt2


o(n)=combine_data2({'20170904_122059','20170904_213540})
filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170819\9-3-Scan26.csv';
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

%% Fit the wavemeter data to lines. Scan 21
% Import wavemeter data from log file
n=2;
o(n) = combine_data2({'20170902_112058','20170902_153422'},[117.8, 705.9],0);  %scan 15

filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170901\9-2-Scan21.csv';
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

saveas(gcf, 'wm_scan21.fig' );

%% Scan 22
% Import wavemeter data from log file
n=3;
o(n) = combine_data2({'20170902_161041','20170903_083941'}, [95.539, 568.71],0); %scan 22

filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170901\9-2-Scan22.csv';
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

wl1 = wl(1:7280);
wl2 = wl(7300:end);
plot(o(n).params ) ;
plot(wl1)
plot(wl2)

%Voltage axis
o(n).params(1)
VPATemp1 = linspace( 0.0868, -0.1942, length(wl1) ) ; 
VPATemp2 = linspace( o(m).params(1), o(m).params(end), length(wl2) ) ; 

figure; 
fit1 = fit(VPATemp1', wl1, 'poly1')
fit2 = fit(VPATemp2', wl2, 'poly1')

plot(fit1, VPATemp1, wl1, 'b');
hold on; 
plot(fit2, VPATemp2, wl2, 'g'); 
xlabel('VPATemp'); ylabel('351XXX (GHz)'); 

saveas(gcf, 'wm_scan14.fig' );


%% Scan 24
n=6;
o(n) = combine_data2({'20170903_181937','20170904_051255'}, [95.539, 568.71],0); %scan 24

filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170901\9-3-Scan24.csv';
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
wl1 = wl(1:5240);
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

saveas(gcf, 'wm_scan24.fig' );


%% Scan 25
n=7;
o(n) = combine_data2({'20170904_071535','20170904_113643'}, [99.99, 569.4],0); %scan 25

filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170901\9-3-Scan25.csv';
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

saveas(gcf, 'wm_scan25.fig' );


%% Scan 26
n=8;
o(n) = combine_data2({'20170904_122059','20170904_213540'}, [95.539, 568.71-7],0); %scan 26

filename = 'N:\NaCsLab\Data\Analysis Scripts\PlotPAScans\20170901\9-3-Scan26.csv';
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
wl1 = wl(1:4735);
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

saveas(gcf, 'wm_scan25.fig' );

