%% Import data from spectrum analyzer
filename = 'G:\N934XDATA\S1_35.CSV';
delimiter = ',';
startRow = [38,53];
endRow = [38,91770];
formatSpec = '%C%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
textscan(fileID, '%[^\n\r]', startRow(1)-1, 'WhiteSpace', '', 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    textscan(fileID, '%[^\n\r]', startRow(block)-1, 'WhiteSpace', '', 'ReturnOnError', false);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end
fclose(fileID);

time = dataArray{1}; %categorial array
time = cellstr(time); %convert to cell array
pts = 1:length(time);
freq = dataArray{2};
amp = dataArray{3};


figure(4); clf; 
plot(pts, freq)



%%  Read CSV file
filename = 'G:\N934XDATA\S1_37.CSV';
delimiter = ',';
startRow = 60;
formatSpec = '%s%f%*s%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);

signal = dataArray{2};
signal = (10.^(signal/10));
signal = signal/max(signal);
%freq =  cellstr(dataArray{1});
freq = 1000*linspace(4.157826087, 4.357826087, length(signal));
[~,idx] = max(signal);
freq = freq - freq(idx);

figure; clf; set(gcf, 'color','w');
plot(freq, signal);
xlim([-50, 50]);

%ft = fitData(freq, signal, 'a*(gamma/2)^2/((x-b)^2+(gamma/2)^2) + c', 'Start', [1, 0, 0, 20] , 'Plot', 1); 
ft = fitData(freq, signal, 'a*exp(-(x-b)^2/w^2)+ c', 'Start', [1, 0, 0, 20] , 'Plot', 1); 

xlabel('Freq (MHz)')
ylabel('Power');
title('PA fast linewidth');


