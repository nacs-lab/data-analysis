%% Import data from text file.
% Script for importing data from the following text file:
%    H:\MergeTimeTraces.CSV

%% Initialize variables.
%filename = 'N:\NaCsLab\Data\20180117\TimeTraces\T0001ALL.CSV';
filename = 'G:\T0000CH2.CSV'

delimiter = ',';
startRow = 16;
formatSpec = '%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'ReturnOnError', false);
fclose(fileID);

t = dataArray{1};
Ch1 = dataArray{2};
%Ch2 = dataArray{4};
length(t)
dt = t(2) - t(1);

figure(1); clf; 
plot(t*1e3, Ch1);
%hold on; 
%plot(t*1e3, 0.9*Ch2/max(Ch2));
title(['AOD linearRamp,  dt=' num2str(dt*1e3) 'ms' ]);
xlabel('Time (ms)');
ylabel('V');
%ylim([0, 1.05]);

%% 2
%filename = 'N:\NaCsLab\Data\20180117\TimeTraces\T0001ALL.CSV';
filename = 'G:\T0001CH2.CSV'

delimiter = ',';
startRow = 16;
formatSpec = '%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'ReturnOnError', false);
fclose(fileID);

t = dataArray{1};
Ch1 = dataArray{2};
%Ch2 = dataArray{4};
length(t)
dt = t(2) - t(1);

figure(1); clf; 
plot(t*1e3, Ch1);
%hold on; 
%plot(t*1e3, 0.9*Ch2/max(Ch2));
title(['AOD trapMove,  dt=' num2str(dt*1e3) 'ms' ]);
xlabel('Time (ms)');
ylabel('V');
%ylim([0, 1.05]);


%% 3
%filename = 'N:\NaCsLab\Data\20180117\TimeTraces\T0001ALL.CSV';
filename = 'G:\T0002CH2.CSV'

delimiter = ',';
startRow = 16;
formatSpec = '%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
textscan(fileID, '%[^\n\r]', startRow-1, 'WhiteSpace', '', 'ReturnOnError', false, 'EndOfLine', '\r\n');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'ReturnOnError', false);
fclose(fileID);

t = dataArray{1};
Ch1 = dataArray{2};
%Ch2 = dataArray{4};
length(t)
dt = t(2) - t(1);

figure(1); clf; 
plot(t*1e3, Ch1);
%hold on; 
%plot(t*1e3, 0.9*Ch2/max(Ch2));
title(['AOD trapMove, DC  dt=' num2str(dt*1e3) 'ms' ]);
xlabel('Time (ms)');
ylabel('V');
%ylim([0, 1.05]);