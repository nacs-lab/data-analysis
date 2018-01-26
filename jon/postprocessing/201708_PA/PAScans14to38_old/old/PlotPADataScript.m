%To run, you must have matlab 2017a,  and you must have access to N drive
%on computer because the N drive calls it.  

%% load data using time ranges
%Here I have put the wavemeter log fits for each scan as an argument to
%combine_data2.  o.x is the frequency axis. 
figure(4); clf; clear o;
o(1) = combine_data2({'20170818_232101','20170819_114623'}, [106.9, 728.5],0); %scan 14a
o(2) = combine_data2({'20170819_120205','20170819_161612'}, [106.9, 728.5],0);  %scan 14b
o(3) = combine_data2({'20170819_234827','20170820_150250'}, [112.0, 731.3],0);  %scan 15
o(4) = combine_data2({'20170820_151457','20170820_172910'}, [124.0, 741.1],0);  %scan 16
o(5) = combine_data2({'20170820_220645','20170821_064104'}, [122.3, 740.5],0);  %scan 17
o(6) = combine_data2({'20170821_064925','20170821_104627'}, [125.5, 743.5],0);  %scan 18
o(7) = combine_data2({'20170821_105428','20170821_161856'}, [130.0, 748.7],0);  %scan 19

save('rawoScan14to19.mat', 'o' );
%% look at params and filenames
% plot(  o(1).params ,'.') ;
% hold on;  plot(  o(2).params ,'.') ;  hold off; 
% % o.params(99)
% % o.params(100)
% % o.params(101)
% % o.filelist{101}
% o(1).params(1)
% o(1).params(end)
% o(2).params(1)
% o(2).filelist{3}



%% Plot survival data
clear o;
load('rawoScan14to19.mat');

%set titles
titles = {'Na, 2-body', 'Cs, 2-body', 'Na, 1-body', 'Cs, 1-body'};
%define colors
%cmp = colormap(parula(8)); %default matlab color map
cmp = get(groot,'DefaultAxesColorOrder'); 

%colors =  { cmp(2,:), cmp(2,:), cmp(2,:), cmp(2,:), cmp(2,:), cmp(2,:), cmp(2,:); ...
%             cmp(1,:), cmp(1,:), cmp(1,:), cmp(1,:), cmp(1,:), cmp(1,:), cmp(1,:); ...
%             cmp(2,:), cmp(2,:), cmp(2,:), cmp(2,:), cmp(2,:), cmp(2,:), cmp(2,:); ...
%             cmp(1,:), cmp(1,:), cmp(1,:), cmp(1,:), cmp(1,:), cmp(1,:), cmp(1,:);} ;
        a = 0.6; 
colors =  { a*cmp(2,:), cmp(2,:), cmp(2,:), a*cmp(2,:), cmp(2,:), a*cmp(2,:), cmp(2,:); ...
            a*cmp(1,:), cmp(1,:), cmp(1,:), a*cmp(1,:), cmp(1,:), a*cmp(1,:), cmp(1,:); ...
            a*cmp(2,:), cmp(2,:), cmp(2,:), a*cmp(2,:), cmp(2,:), a*cmp(2,:), cmp(2,:); ...
            a*cmp(1,:), cmp(1,:), cmp(1,:), a*cmp(1,:), cmp(1,:), a*cmp(1,:), cmp(1,:);} ;

       
markers = {'+','o','*','.','x','s','d','^','v','>','<','p','h'};
markers = {'.','.','.','.','.','.','.'};



for i=1:4
    
    plotfig(i) = figure;  set(gcf,'color','w');
    %set figure size
    if 0
        fig = gcf;
        fig.PaperUnits = 'inches';
        fig.PaperPosition = [0 0 6 3];
    end
    

    
    hold on;
    for m=1:length(o)
        
        bfill = 1; 
        if bfill
            X=[o(m).x, fliplr(o(m).x)];                %#create continuous x value array for plotting
            Y=[o(m).survival(i,:) - o(m).survival_error(i,:), fliplr( o(m).survival(i,:)+ o(m).survival_error(i,:))];              %#create y values for out and then back
            fill(X,Y,0.8*[1 1 1],'EdgeColor','none');
        end
                
        
        %errorbar( o(m).x , o(m).survival(i,:), o(m).survival_error(i,:), ...
        %    '.', 'Linewidth', 0.5, 'Marker', markers{m}, 'MarkerSize', 2, 'MarkerFaceColor', 'auto','Color', colors{i,m});  
        
        plot( o(m).x , o(m).survival(i,:),  ...
            '.-', 'Linewidth', 0.7, 'Marker', markers{m}, 'MarkerSize', 4, 'MarkerFaceColor', 'auto','Color', colors{i,m});  
        
    end
    hold off; 
    
    xlabel('351XXX (GHz)');
    ylabel('Survival probability')
    title(titles{i});
    box on;
    %grid on;
    pbaspect([2 1 1]); %aspect ratio, xyz
    set(gca,'linewidth',0.8);
    
   
    %store x,y limits
    xlimit = xlim;
    ylimit = ylim; 
    
    %expected lines
    col= 0.8*[1, 1, 1];%'c';
    os = 0; %offset
    %line('XData',724.3*[1 1]+os, 'YData',[0 1],'Color', col);
    %line('XData',719.0*[1 1]+os, 'YData',[0 1],'Color', col);
    %line('XData',712.7*[1 1]+os, 'YData',[0 1],'Color', col);
    line('XData',707.6*[1 1]+os, 'YData',[0 1],'Color', col);
    line('XData',694.2*[1 1]+os, 'YData',[0 1],'Color', col);
    line('XData',688.2*[1 1]+os, 'YData',[0 1],'Color', col);
    line('XData',667.4*[1 1]+os, 'YData',[0 1],'Color', col);
    line('XData',659.0*[1 1]+os, 'YData',[0 1],'Color', col);
    line('XData',625.4*[1 1]+os, 'YData',[0 1],'Color', col);
    line('XData',618.4*[1 1]+os, 'YData',[0 1],'Color', col);
  
    
   %go back to default limit before lines
   xlim( xlimit );
   xlim([603,706]);
   ylim( ylimit ); 
   
   ylim([0,1]); 
   
    %print(['figAllScans_' num2str(i) '.pdf'] ,'-dpdf' )
    %saveas( gcf, ['figAllScans_' num2str(i) '.fig'] ); 
    
end
