TweezerPower = 15.5*[1 0.5 1 1 0.5 1 1 0.5 1];
RamanRF = [1 1 0.5 1 1 0.5 1 1 0.5];
AODFreq = [48 48 48 56.5 56.5 56.5 65 65 65];
Omega = [211.2 203.1 94.3 191 208.7 103.1 203.7 192.0  107.4];
OmegaErr = [5.8 5.9 5.6 9.2 6.5 4.7 7.0 7.6 3.3];
x0 = [16.72 21.51 28.86 8.94 18.87 22.06 7.92 18.48 21.6];
x0Err = [0.32 0.29 0.24 0.39 0.34 0.25 0.3433 0.33 0.19];


%% Versus Position
figure(2); clf; hold on;
indx = [1,4,7];
x1 = AODFreq(indx);
y1 = x0(indx);
y1err = x0Err(indx);
errorbar( x1, y1, y1err ,'.-')
indx = [1,4,7]+1;
x1 = AODFreq(indx);
y1 = x0(indx);
y1err = x0Err(indx);
errorbar( x1, y1, y1err ,'.-')
indx = [1,4,7]+2;
x1 = AODFreq(indx);
y1 = x0(indx);
y1err = x0Err(indx);
errorbar( x1, y1, y1err ,'.-')
xlabel('AOD Freq (MHz)'); ylabel('x_0 (kHz)');
legend('Normal power','Half tweezer','Half Raman');

%%  Vs Tweezer power
figure(1); clf; hold on;
indx = [1,2];
x1 = TweezerPower(indx);
y1 = x0(indx);
y1err = x0Err(indx);
errorbar( x1, y1, y1err ,'.-')
fit( x1', y1', 'poly1' )  

indx = [4,5];
x1 = TweezerPower(indx);
y1 = x0(indx);
y1err = x0Err(indx);
errorbar( x1, y1, y1err ,'.-')
fit( x1', y1', 'poly1' )  

indx = [7,8];
x1 = TweezerPower(indx);
y1 = x0(indx);
y1err = x0Err(indx);
errorbar( x1, y1, y1err ,'.-')
fit( x1', y1', 'poly1' )  

xlabel('Tweezer power (mW)'); ylabel('x_0 (kHz)');
legend('48 MHz','57.5 MHz','65 MHz');


%% Versus Raman
figure(3); clf; hold on;
indx = [1,3];
x1 = RamanRF(indx);
y1 = x0(indx);
y1err = x0Err(indx);
errorbar( x1, y1, y1err ,'.-')
fit( x1', y1', 'poly1' )  

indx = [1,3]+3;
x1 = RamanRF(indx);
y1 = x0(indx);
y1err = x0Err(indx);
errorbar( x1, y1, y1err ,'.-')
fit( x1', y1', 'poly1' )  

indx = [1,3]+6;
x1 = RamanRF(indx);
y1 = x0(indx);
y1err = x0Err(indx);
errorbar( x1, y1, y1err ,'.-')
fit( x1', y1', 'poly1' )  

xlabel('Raman RF (au)'); ylabel('x_0 (kHz)');
legend('48 MHz','57.5 MHz','65 MHz');

fit( x1', y1', 'poly1' )  
