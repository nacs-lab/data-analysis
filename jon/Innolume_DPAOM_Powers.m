PADPaom = [0, 0.01, 0.05, 0.1, 0.15, 0.18, 0.2, 0.25, 0.3, 0.35,   0.4,  0.45,  0.5,   0.6,    0.7,   0.8, 0.9];
poweruW = [0, .009, 5.5, 88,   416,  834, 1238, 2780, 5210, 8530, 12500, 16800, 20500, 24900, 26700, 27500, 27700];

figure;
plot(PADPaom, poweruW, '.-')
xlabel('PADPaom (DDS)'); ylabel('DP Innolume power (uW)');