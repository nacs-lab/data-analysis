d = DataScanSeq([20180514, 095226]);
d.plotSurvival()

%%
figure(1); clf;
for i = 1:4
[x,y,yerr] = d.getSurvival(2,i);
x = x.^2*1e3;
errorbar(x,y,yerr);
xlabel('Power (au)');
ylabel('Survival');
hold on;
end

legend('300uW','200uW', '150uW', '100uW')

%%
figure;
turns = [14,  10, 6, 2, 0];
power = [1.05, 0.85, 0.76, 0.74, 0.74];
turnsCs = [-2, -6, -10, -14];
powerCs = [0.72, 0.78, 0.8, 0.85];
plot(turns, power,'.-');
hold on; 
plot(turnsCs, powerCs, '.-');
xlabel('2nd telescope lens turns for Na tweezer');
ylabel('3dB power');
ylim([0, 1.2])

%%
figure;
nm = 1e-9; um = 1e-6;
z = linspace(-2,2,100)*um;
w0 = 0.8*um; 
lambda = 700*nm;
zR = pi*w0^2/lambda;
w = w0*sqrt( 1 + z.^2/zR.^2 );
intensity = w.^2/w0^2;
plot(z/um, 1./intensity)
ylim([0, 1])
xlabel('z (um)');
ylabel('Intensity');