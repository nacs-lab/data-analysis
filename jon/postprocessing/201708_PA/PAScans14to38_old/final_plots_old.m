%% Load data and save summary .mat file
timeranges = {'20170811_220518','20170814_101703'}; %first and final filename

%Get filenames
path = 'N:\NaCsLab\Data\20170814\';
files = dir([path,'*.mat']);


serialnum = cellfun(@(x)datenum(x,'yyyymmdd_HHMMSS'),timeranges); %convert to serial numbers
 
 filelist ={};
 for m=1:length(files)
    if files(m).datenum>=serialnum(1) &&  files(m).datenum<=serialnum(2)
      filelist{end+1} = files(m).name ; 
    end
 end
N= length(filelist);

%Load files
params(N) = 0;
for i = 1:N
    fname = [path,filelist{i}];   
    d = load(fname);
    
    params(i) = d.Analysis.UniqueParameters;
    if params(i) > -0.02
        disp(fname);
    end
    
    survival(:,i) = d.Analysis.SurvivalProbability;
    survival_error(:,i) = d.Analysis.SurvivalProbabilityErr;    
end

save([path,'summary.mat'],'params','survival','survival_error','filelist');



%% Load data from summary file
clear params suvival survival_error path filelist
path = 'N:\NaCsLab\Data\20170814\';
cd(path);
load([path,'summary.mat']);
N = length(params)


%%  Convert x axis
xConv= [100.39,725.51] % from linear fit to wavemeter log 
x =(xConv(1)*params + xConv(2) )/d.Scan.PlotScale; %detuning from F=4 to F'=5.
%x = params;

%% Plot data
figure(1); clf; 
figure(2); clf;  
figure(3); clf; 
figure(4); clf;

ncol = size(survival, 1);
for i = 1:ncol
    %subplot(1, ncol, i);
    figure(i);
    set(gcf,'color','w');
    
    plot(x,  survival(i,:) ,'r.'); 
    %errorbar(x , survival(i,:), survival_error(i,:),'.');
    
    smoothswitch = 1;
    smoothspan = 15;
    if smoothswitch == 1
        survival_smooth(i,:)=smooth(survival(i,:),smoothspan); %running average
        survival_error_smooth(i,:)= smooth(survival_error(i,:),smoothspan)/sqrt(smoothspan);
        hold on; 
      
        %fill plot for smoothed errobar
        X=[x,fliplr(x)];                %#create continuous x value array for plotting
        Y=[survival_smooth(i,:)-survival_error_smooth(i,:),fliplr( survival_smooth(i,:)+survival_error_smooth(i,:))];              %#create y values for out and then back
        fill(X,Y,0.8*[1 1 1],'EdgeColor','none'); 
        
        %plot(x, survival_smooth(i,:)+survival_error_smooth(i,:) ,'k-');
        %plot(x, survival_smooth(i,:)-survival_error_smooth(i,:) ,'k-');
        
        %plot smooth data
        plot(x, survival_smooth(i,:) ,'k-');
        
        
        
        hold off; 
    end
       
    
    
    
    title({['survival: image ' logical_cond_2str(d.Scan.SurvivalLogicals{i},d.Scan.SingleAtomSpecies)], ...
                ['loading: image ' logical_cond_2str(d.Scan.SurvivalLoadingLogicals{i},d.Scan.SingleAtomSpecies)]})
    xlabel('351XXX (GHz)');
    ylabel('Survival probability');
    xlim([ min(x), max(x)]);
   % xlim([ 705, max(x)]);
    box on;
    %grid on;
    
    %plot vertical lines at expected points
    col = 'c';
    line('XData',711.1*[1 1], 'YData',[0 1],'Color', col); %tweaked tweezer
    line('XData',704.6*[1 1], 'YData',[0 1],'Color', col);  %changes Cs atom position
    line('XData',679.5*[1 1], 'YData',[0 1],'Color', col);  %tweaked tweezer
        
    %expected lines
    col= 'k';
    os = 0; 
    line('XData',724.3*[1 1]+os, 'YData',[0 1],'Color', col); 
    line('XData',719.0*[1 1]+os, 'YData',[0 1],'Color', col); 
    line('XData',712.7*[1 1]+os, 'YData',[0 1],'Color', col); 
    line('XData',707.6*[1 1]+os, 'YData',[0 1],'Color', col); 
    line('XData',694.2*[1 1]+os, 'YData',[0 1],'Color', col); 
    line('XData',688.2*[1 1]+os, 'YData',[0 1],'Color', col); 
    line('XData',667.4*[1 1]+os, 'YData',[0 1],'Color', col);     
    line('XData',659*[1 1]+os, 'YData',[0 1],'Color', col);
    
    print(['fig' num2str(i) '.pdf'] ,'-dpdf' )

    
end



%% Plot data  on same plot
figure(5); clf; 
set(gcf,'color','w');
hold on; 

ncol = size(survival, 1);
for i = 1:ncol
    
    smoothswitch = 1;
    smoothspan = 15;
    if smoothswitch == 1
        survival_smooth(i,:)=smooth(survival(i,:),smoothspan); %running average
        survival_error_smooth(i,:)= smooth(survival_error(i,:),smoothspan)/sqrt(smoothspan);
        hold on; 
      
        %fill plot for smoothed errobar
        X=[x,fliplr(x)];                %#create continuous x value array for plotting
        Y=[survival_smooth(i,:)-survival_error_smooth(i,:),fliplr( survival_smooth(i,:)+survival_error_smooth(i,:))];              %#create y values for out and then back
        fill(X,Y,0.8*[1 1 1],'EdgeColor','none'); 
        
        %plot(x, survival_smooth(i,:)+survival_error_smooth(i,:) ,'k-');
        %plot(x, survival_smooth(i,:)-survival_error_smooth(i,:) ,'k-');
        
        %plot smooth data
        plotlist(i)=plot(x, survival_smooth(i,:) ,'-','Linewidth',1.5);
         
        hold off; 
    end
end

%title({['survival: image ' logical_cond_2str(d.Scan.SurvivalLogicals{i},d.Scan.SingleAtomSpecies)], ...
%    ['loading: image ' logical_cond_2str(d.Scan.SurvivalLoadingLogicals{i},d.Scan.SingleAtomSpecies)]})
xlabel('351XXX (GHz)');
ylabel('Survival probability');
xlim([ min(x), max(x)]);
%xlim([ 705, max(x)]);
box on;
%grid on;

%plot vertical lines at expected points
col = 'c';
line('XData',711.1*[1 1], 'YData',[0 1],'Color', col); %tweaked tweezer
line('XData',704.6*[1 1], 'YData',[0 1],'Color', col);  %changes Cs atom position
line('XData',679.5*[1 1], 'YData',[0 1],'Color', col);  %tweaked tweezer

%expected lines
col= 'k';
os = 0;
line('XData',724.3*[1 1]+os, 'YData',[0 1],'Color', col);
line('XData',719.0*[1 1]+os, 'YData',[0 1],'Color', col);
line('XData',712.7*[1 1]+os, 'YData',[0 1],'Color', col);
line('XData',707.6*[1 1]+os, 'YData',[0 1],'Color', col);
line('XData',694.2*[1 1]+os, 'YData',[0 1],'Color', col);
line('XData',688.2*[1 1]+os, 'YData',[0 1],'Color', col);
line('XData',667.4*[1 1]+os, 'YData',[0 1],'Color', col);
line('XData',659*[1 1]+os, 'YData',[0 1],'Color', col);

legend([plotlist(1) plotlist(2) plotlist(3) plotlist(4)],{'Na 2-body','Cs 2-body','Na 1-body','Cs 1-body'})

print('sameplot.pdf' ,'-dpdf' )



%% old
if 0
    set(gcf,'Units','inches');
    screenposition = get(gcf,'Position');
    set(gcf,...
        'PaperPosition',[0 0 screenposition(3:4)],...
        'PaperSize',[screenposition(3:4)]);
    print -dpdf -painters epsFig
end