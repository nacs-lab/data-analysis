%20180227_144826

%% Load VPAScan data
folder = 'N:\NaCsLab\Data';
clearfig = 1; berror = 1;
f = load([folder '\20180227\' 'VPAScan_20180227_144826.mat']); % Description
filelist = f.filelist;
VPATempList = f.VPATempList;
VPAslope = f.VPAslopeWM; %WM
VPAoffset = f.VPAoffsetWM; %WM
fWavemeter = f.fWavemeter; %wavemeter frequencies
length(filelist)

%%% Load file data
clear data;
for m = 1 : length(filelist)
    data(m) = DataScanSeq(filelist{m});
end


%%% Get data
clearfig = 1; berror = 1;
clear x y yerr;
for i = 1 : data(1).Scan.NumSurvival
    survival = i;
    for m = 1 : length(data)
        %i = 1; % which scan
        %scanFieldIdx = 1; %1 for Na, 2 for Cs
        [x(i,m,:), y(i,m,:), yerr(i,m,:)] = data(m).getSurvival(survival);
    end
end
size(y);

% Get the VPATemp axis (should be the same as VPATempList)
VPATempList2 = [];
for i = 1 : length(data)
    VPATempList2 = [VPATempList2, data(i).ScanSeq.p.('VPATemp')];
end
% Convert PA voltage to PA frequency using wavemeter calibration
%fPA = VPATempList*VPAslope + VPAoffset;
fPA = fWavemeter; % use Wavemeter frequencies

% Convert x, the DP frequency, to Two-photon frequency
f2Photon = 2*squeeze(x(1,1,:));

% For plot titles
d = data(1); 

%% Plot no PA and PA without DP
% input:   f2Photon,  fPA, and survival's y, yerr

figure(4);
set(gcf,'color','w');
clf;
ncol = data(1).Scan.NumSurvival;
m=1;

for i = 1:ncol
      
    % format x(survival, which scan, DP frequency)
%     xplot = squeeze(x(i,m,:));
%     yplot = squeeze(y(i,m,:));
%     yerrplot = squeeze(yerr(i,m,:));
    
    xplot = fPA;
    yplot = squeeze(y(i,:,m));
    yerrplot = squeeze(yerr(i,:,m));
    
    
    subplot(1, ncol, i);
    berror = 1;
    hold on;
    if berror
        errorbar(xplot, yplot, yerrplot ,'.');
    else
        plot(xplot,  yplot,'.-');
    end
    title({['survival: ' logical_cond_2str(d.Scan.SurvivalLogicals{i},d.Scan.SingleAtomSpecies)], ...
                ['loading: ' logical_cond_2str(d.Scan.SurvivalLoadingLogicals{i},d.Scan.SingleAtomSpecies)]})
    %xlabel([d.Scan.ParamName, ' [', d.Scan.ParamUnits, ']'])
    if i < ncol
        xlabel('351XXX (GHz)');
    else
        xlabel({'351XXX (GHz)', [filelist{end}]},'interpreter', 'none');
    end
    ylabel('Survival probability')
    box on
    %grid on
    hold off;
      
end

m=2;
for i = 1:ncol
    
    xplot = fPA;
    yplot = squeeze(y(i,:,m));
    yerrplot = squeeze(yerr(i,:,m));
    
    subplot(1, ncol, i);
    berror = 1;
    hold on;
    if berror
        errorbar(xplot, yplot, yerrplot ,'.');
    else
        plot(xplot,  yplot,'.-');
    end
    hold off;
    
end



%% Plot PA with DP
% input:   f2Photon,  fPA, and survival's y, yerr

figure(4);
set(gcf,'color','w');
clf;
ncol = data(1).Scan.NumSurvival;
clear ft; 

for m = 2 : length(f2Photon)
    for i = 1:ncol
        
        % format x(survival, which scan, DP frequency)
        %     xplot = squeeze(x(i,m,:));
        %     yplot = squeeze(y(i,m,:));
        %     yerrplot = squeeze(yerr(i,m,:));
        
        xplot = fPA;
        yplot = squeeze(y(i,:,m));
        yerrplot = squeeze(yerr(i,:,m));
        
        subplot(1, ncol, i);
        berror = 0;
        hold on;
        if berror
            errorbar(xplot, yplot, yerrplot ,'.-');
        else
            plot(xplot,  yplot,'.-');
        end
        
        bfit = 1;
        if bfit
            ft{m,i} = fit(xplot', yplot', 'a - b*exp(-(x-c-688.7)^2/w^2)', 'StartPoint', [0.9, 0.4, 0.1, 0.05]);
            %hold on;
            %plot(ft);
            %hold off;
        end
        
        title({['survival: ' logical_cond_2str(d.Scan.SurvivalLogicals{i},d.Scan.SingleAtomSpecies)], ...
                ['loading: ' logical_cond_2str(d.Scan.SurvivalLoadingLogicals{i},d.Scan.SingleAtomSpecies)]})
        %xlabel([d.Scan.ParamName, ' [', d.Scan.ParamUnits, ']'])
        if i < ncol
            xlabel('351XXX (GHz)');
        else
            xlabel({'351XXX (GHz)', [filelist{end}]},'interpreter', 'none');
        end
        ylabel('Survival probability')
        box on
        %grid on
        hold off;
        
    end
end

legend(num2str(f2Photon(2:end)))

%% plot above fits
%above I make ft{m, survival}
clear offsetlist offseterrlist widthlist widtherrlist fitresult
for m = 2:length(ft)
    fitresult = ft{m,2}; %1 for Na, 2 for Cs
    
    cnfint = confint(fitresult, 0.6827); %standard deviation
    std = abs(cnfint(1,:) - cnfint(2,:))/2 ; 
    
    offsetlist(m) = fitresult.c;
    offseterrlist(m) = std(3);    
    
    widthlist(m) = fitresult.w;
    widtherrlist(m) = std(4);
end

figure; 
errorbar(f2Photon(2:end), offsetlist(2:end),offseterrlist(2:end),'.-');
xlabel('Two photon detuning');
ylabel('PA resonance offset (555.X GHz)')

figure; 
errorbar(f2Photon(2:end), widthlist(2:end),widtherrlist(2:end),'.-');
xlabel('Two photon detuning');
ylabel('PA resonance width (GHz)')
%plot(f2Photon(2:end), widthlist(2:end))

%% Plot PA with DP, againstf2Photon
% input:   f2Photon,  fPA, and survival's y, yerr

figure(4);
set(gcf,'color','w');
clf;
ncol = data(1).Scan.NumSurvival;
mlist = 1:2;%length = 15

for m = mlist%length(fPA)
    for i = 1:ncol
        
        % format x(survival, which scan, DP frequency)
        %     xplot = squeeze(x(i,m,:));
        %     yplot = squeeze(y(i,m,:));
        %     yerrplot = squeeze(yerr(i,m,:));
        
        xplot = f2Photon;
        yplot = squeeze(y(i,m,:));
        yerrplot = squeeze(yerr(i,m,:));
        
        subplot(1, ncol, i);
        berror = 1;
        hold on;
        if berror
            errorbar(xplot, yplot, yerrplot ,'.');
        else
            plot(xplot,  yplot,'.-');
        end
        
        %fit
        if m == 2 && (i == 1 || i == 2)
            ft = fit(xplot, yplot, 'a + b * exp(-(x-c)^2/d^2)', 'StartPoint', [0.2, 0.7, 298.4, 2])
            %ft = fit(xplot, yplot, 'a + b*(1/pi)*(gamma/2)/((x-os)^2+(gamma/2)^2)', 'StartPoint', [0.2, 0.7, 2, 298.4])

            plot(ft);
            
        end
        
         title({['survival: ' logical_cond_2str(d.Scan.SurvivalLogicals{i},d.Scan.SingleAtomSpecies)], ...
                ['loading: ' logical_cond_2str(d.Scan.SurvivalLoadingLogicals{i},d.Scan.SingleAtomSpecies)]})
        %xlabel([d.Scan.ParamName, ' [', d.Scan.ParamUnits, ']'])
        if i < ncol
            xlabel('2-Photon Freq (MHz)');
        else
            xlabel({'2-Photon Freq (MHz)', [filelist{end}]},'interpreter', 'none');
        end
        ylabel('Survival probability')
        box on
        %grid on
        hold off;
        xlim([283, 317]);
        
    end
end

 subplot(1, ncol, 1);
legend(num2str(fPA(mlist)'))

%% Plot Image of PA with DP
% input:   f2Photon,  fPA, and survival's y, yerr

figure(4);
set(gcf,'color','w');
clf;
ncol = data(1).Scan.NumSurvival;

mrange = 3 : length(f2Photon);
 
 for i = 1:ncol
     
     xplot = f2Photon(3:end)';
     yplot = squeeze(y(i,:,mrange));
     yerrplot = squeeze(yerr(i,:,mrange));
     
     subplot(1, ncol, i);
     
     berror = 0;
     %hold on;
     %imagesc(xplot, fPA, yplot);  
     surf(xplot, fPA, yplot); view(2);   
     xlim([min(xplot), max(xplot)]);
     ylim([min(fPA), max(fPA)]);
     
     if i < ncol
         xlabel('2-Photon Freq (MHz)');
     else
         xlabel({'2-Photon Freq (MHz)', [filelist{end}]},'interpreter', 'none');
     end
     ylabel('351XXX (GHz)')
     %box on
     colorbar;
     %grid on
     %hold off;
     
     
 end

 
 
%% Plot Image of PA with DP, using down branch freq as x-axis
% input:   f2Photon,  fPA, and survival's y, yerr

figure(4);
set(gcf,'color','w');
clf;
ncol = data(1).Scan.NumSurvival;

mrange = 3 : length(f2Photon);
 
 for i = 1:ncol
     
     xplot = f2Photon(3:end)';
     yplot = squeeze(y(i,:,mrange));
     yerrplot = squeeze(yerr(i,:,mrange));
     X = xplot;
     Y = fPA;
     
     %convert x-axis to down branch freq, instead of 2photon detuning
     [X,Y] = meshgrid(X, Y);
     X = X*1e-3 + Y;
     X = X - 688;
     Y = Y - 688;
     
     subplot(1, ncol, i);
     
     berror = 0;
     %hold on;
     %imagesc(xplot, fPA, yplot);  
     surf(X, Y, yplot); view(2);   
     xlim([min(min(X)), max(max(X))]);
     ylim([min(min(Y)), max(max(Y))]);
     
     if i < ncol
         xlabel('Down Freq (MHz)');
     else
         xlabel({'Down Freq (MHz)', [filelist{end}]},'interpreter', 'none');
     end
     ylabel('Up Freq (GHz)')
     %box on
     colorbar;
     %grid on
     %hold off;
     
     
 end
