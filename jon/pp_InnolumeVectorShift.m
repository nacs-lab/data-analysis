%% Old files
%file = [20180409, 152624];
file = [20180409, 174357];
file = [20180409, 182037];
file = [20180409, 184715];
file = [20180409, 191155];
file = [20180409, 192757];
file = [20180409, 194201];
file = [20180409, 195421];
file = [20180409, 200840];
%vertical
file = [20180409, 204128];
file = [20180409, 205712];
file = [20180409, 211852];
file = [20180409, 214238];
file = [20180409, 220406];
file = [20180409, 230425];
file = [20180409, 231413];
file = [20180409, 233024];
%checking
file = [20180410, 143459];
file = [20180412, 140108];
file = [20180412, 141425];
file = [20180412, 144525];
file = [20180412, 145818];
file = [20180412, 151546];
file = [20180412, 152540];
%checking on 4/16
file = [20180416, 135451];
file = [20180417, 193333];
file = [20180417, 214118];
file = [20180418, 152303];
file = [20180418, 153555];
file = [20180418, 153555];
%file = [20180419, 164223];
file = [20180420, 213549];
file = [20180421, 093608];
file = [20180521, 185916];
file = [20180521, 191506];
file = [20180522, 144000];
file = [20180522, 150013];
file = [20180522, 150753];
file = [20180522, 151616];
file = [20180522, 152404];
file = [20180522, 152904];
file = [20180522, 153550];

file = [20180522, 154031];
file = [20180522, 154504];
file = [20180522, 155318];
file = [20180522, 160512];
%%
file = [20180522, 161331];
file = [20180522, 181141]; 
file = [20180525, 183202];
file = [20180527, 145952];
file = [20180527, 150936];
file = [20180527, 153846];
file = [20180527, 215313];
file = [20180527, 215746];
file = [20180527, 225829];
file = [20180528, 102444];
file = [20180528, 144337];
file = [20180528, 162647];
file = [20180528, 183832];
file = [20180529, 152904];
file = [20180601, 145023];
file = [20180601, 225348];
file = [20180601, 225947];
file = [20180602, 105144];

data = DataScanSeq(file);

figure(4); clf; set(gcf,'color','w');
subplot(1, 2, 1);

survival = 1; %1 for Na, 2 for Cs
scanFieldIdx = 1; %1 for Na, 2 for Cs
scale = 1e6;

% Plot
i = 1; % which scan
[x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
fitData( x/scale, y, 'a*rabiLine(2*pi*(x-x0), 17e-6*1e6, b)/rabiLine(0, 17e-6*1e6, b)', 'Plot', 1, 'Start', [0.8, 200, 10])
hold on;
i = 2;
[x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
fitData( x/scale, y, 'a*rabiLine(2*pi*(x-x0), 17e-6*1e6, b)/rabiLine(0, 17e-6*1e6, b)', 'Plot', 1, 'Start', [0.8, 200, 10], 'TextRow', 2)

hold off; 

xlabel('Detuning (MHz)');
ylabel('Survival');
title('Na Coprop with and without 1038nm');
grid on;
ylim([0 1]);

subplot(1,2,2);
survival = 2; %1 for Na, 2 for Cs
scanFieldIdx = 2; %1 for Na, 2 for Cs
scale = 1e3;

% Plot
i = 1; % which scan
[x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
ylim([0,1]);
fitData( x/scale, y, 'a*rabiLine(2*pi*(x-x0), 17e-6*1e3, b)', 'Plot', 1, 'Start', [0.9, 100, 10])
hold on;
i = 2;
[x,y,yerr] = data.getSurvival(survival, i, scanFieldIdx);
errorbar( x/scale, y, yerr, '.-', 'CapSize', 2, 'Linewidth', 1, 'Marker', '.', 'MarkerSize', 14);
ylim([0,1]);
fitData( x/scale, y, 'a*rabiLine(2*pi*(x-x0), 17e-6*1e3, b)', 'Plot', 1, 'Start', [0.9, 50, 30], 'TextRow', 2)
hold off; 

%title( titles{i} );
%xlabel('TNaRaman1 (us)');
xlabel('Detuning (kHz)');
ylabel('Survival');
title('Cs Coprop with and without 1038nm');
grid on;
ylim([0 1]);

%% Horizontal Data 5/22
%Horizontal
x = [20, 10, 0, -10, -20, -30, -40, -50, -60, -70, -80]; %steps
x  = 0.140*x;
y = [ 8.78, 11.3, 24.75, 47.2, 53.2, 51.4, 51.2, 52.5, 34, 36.74, 23.7]; %kHz
yerr = [3, 2, 2, 3, 2, 2.5, 2.5, 2.5, 2.5, 2, 3]; %kHz

% sort
[x, ind] = sort(x);
y = y(ind);
yerr = yerr(ind);

%plot
figure(7);
errorbar(x, y, yerr, '.-', 'MarkerSize', 10);
fitData(x,y, 'a*exp(-2*(x-x0)^2/b^2)', 'Start', [55, 5, -3], 'Plot', 1)
xlabel('Horizontal position (um)');
ylabel('Vector shift (kHz)');
title('1038nm vector shift vs horizontal position');
%% Vertical Data 5/22
x = [-60, -50, -40, -30, -20, -10, 0, 10, 30, 50, 70, 90]; %steps
x  = 0.100*x; %0.100 if +,  0.85 is going -
y = [34.4, 42, 39.5, 43.9, 56.6, 50.5, 48.6, 50.66, 49, 44.9, 36.1, 31.9]; %kHz
yerr = [3, 3, 3, 3, 3, 3, 3, 1.5, 3, 2, 3, 3]; %kHz

% sort
[x, ind] = sort(x);
y = y(ind);
yerr = yerr(ind);

%plot
figure(7);
errorbar(x, y, yerr, '.-');
fitData(x,y, 'a*exp(-2*(x-x0)^2/b^2)', 'Start', [120, 5, 5], 'Plot', 1)
xlabel('Vertical position (um)');
ylabel('Vector shift (kHz)');
title('1038nm vector shift vs Vertical position');
%% Horizontal
x = [0, -20, 20, 40, 60, 80, 100, 120]; %steps
x  = 0.140*x;
y = [28.2, 9, 82, 110, 146, 136, 67, 30]; %kHz
yerr = [1.3, 2, 2, 2, 2, 2, 2, 1.4]; %kHz

% sort
[x, ind] = sort(x);
y = y(ind);
yerr = yerr(ind);

%plot
figure(7);
errorbar(x, y, yerr, '.-');
fitData(x,y, 'a*exp(-2*(x-x0)^2/b^2)', 'Start', [120, 5, 5], 'Plot', 1)
xlabel('Horizontal position (um)');
ylabel('Vector shift (kHz)');
title('1038nm vector shift vs horizontal position');
%% Vertical
x = [0, 30, -30, -60, -90]; %steps
x  = 0.085*x;
y = [132, 116, 163, 162, 120]; %kHz
yerr = [2, 2, 2, 2, 2]; %kHz

% sort
[x, ind] = sort(x);
y = y(ind);
yerr = yerr(ind);

%plot
figure(7);
errorbar(x, y, yerr, '.-');
fitData(x,y, 'a*exp(-2*(x-x0)^2/b^2)', 'Start', [120, 5, 5], 'Plot', 1)
xlabel('Vertical position (um)');
ylabel('Vector shift (kHz)');
title('1038nm vector shift vs Vertical position');
%% Horizontal 2
x = [0 -20 20 40 30]; %steps
x  = 0.140*x;
y = [97, 62, 147 135, 151]; %kHz
yerr = [3,3,3,3,3]; %kHz

% sort
[x, ind] = sort(x);
y = y(ind);
yerr = yerr(ind);

%plot
figure(7);
errorbar(x, y, yerr, '.-');
fitData(x,y, 'a*exp(-2*(x-x0)^2/b^2)', 'Start', [120, 5, 5], 'Plot', 1)
xlabel('Horizontal position (um)');
ylabel('Vector shift (kHz)');
title('1038nm vector shift vs horizontal position');
