%plot_data(Scan, Images, fname)
file = [20180216, 013913];

data = DataScanSeq(file);

i = 1;
survival = 1;
scanFieldIdx = 1;

[x,y] = data.PlotSurvival(i, scanFieldIdx, survival);


figure(4); clf; set(gcf,'color','w');
%subplot(2,3,1);

plot(x,y);