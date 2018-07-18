figure(1); clf;
Detuning = [-0.5, -1, -1.5];
RamanPeak = [298.45, 298.25, 298.190];
plot(Detuning, RamanPeak, '.', 'MarkerSize', 20);
fitData(Detuning, RamanPeak, 'a/x +b', 'Start', [1, 298.2], 'Plot', 1); 
xlabel('Detuning from v=0 (GHz)');
ylabel('Raman resonance (MHz)');


%%

figure(2); clf;
power = [10, 8, 7];
vectorShiftCal = 1.2; % kHz/mW
RamanPeak = [ 298.190, 298.156, 298.144];
plot(power, RamanPeak, '.', 'MarkerSize', 20);
fitData(power, RamanPeak, 'a*x +b', 'Start', [1, 298.1], 'Plot', 1); 
xlabel('Power (mW)');
ylabel('Raman resonance (MHz)');

%% 

RamanPeak = [
vectorShiftCal = 1.2; % kHz/mW

vectorShift = power
