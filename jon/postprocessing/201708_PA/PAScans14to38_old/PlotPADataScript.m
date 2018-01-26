%To run, you must have matlab 2017a,  and you must have access to N drive
%on computer because the N drive calls it.  


%% load data using time ranges
%Here I have put the wavemeter log fits for each scan as an argument to
%combine_data2.  o.x is the frequency axis. 
figure(4); clf; clear o;
VPAslope = 24.7;
VPAoffset =   469.8;
o(1) = combine_data2({'20180127_113813','20180127_161510'}, [VPAslope, VPAoffset],0);


%save('rawoScan14to19.mat', 'o' );


%% load data using time ranges
%Here I have put the wavemeter log fits for each scan as an argument to
%combine_data2.  o.x is the frequency axis. 
figure(4); clf; clear o;
%o(1) = combine_data2({'20170901_230407','20170902_071359'}, [79.49, 572.88],0); %scan 20
%o(2) = combine_data2({'20170902_112058','20170902_153422'}, [91.46, 567.8],0); %scan 21
%o(3) = combine_data2({'20170902_161041','20170903_083941'}, [95.9, 568.9],0); %scan 22
%o(4) = combine_data2({'20170903_161727','20170903_181936'}, [95.539, 568.71-3],0); %scan 23
%o(5) = combine_data2({'20170903_181937','20170904_051255'}, [99.99, 569.4],0); %scan 24
%o(6) = combine_data2({'20170904_071535','20170904_113643'}, [99.99, 569.4],0); %scan 25

% 500 lines
%o(7) = combine_data2({'20170904_122059','20170904_213540'}, [117, 578.4],0); %scan 26, using scan 26 wm cal for 26,27,28
%o(8) = combine_data2({'20170904_224814','20170905_084636'}, [117, 578.4],0); %scan 27
%o(9) = combine_data2({'20170905_085341','20170905_114609'}, [117, 578.4],0); %scan 28

%c490 fine scan
%o(10) = combine_data2({'20170905_174248','20170905_205049'}, [117, 578.4],0); %scan 30
%o(11) = combine_data2({'20170905_205624','20170905_224642'}, [117, 578.4],0); %scan 31
%o(12) = combine_data2({'20170906_002128','20170906_ 100241'}, [117, 578.4],0); %scan 32
%o(13) = combine_data2({'20170906_144121','20170907_122751'}, [117, 578.4],0); %scan 33
%o(14) = combine_data2({'20170907_131936','20190907_131936'}, [117,
%578.4],0); %scan 35
o(15) = combine_data2({'20170907_144719','20170907_164949'}, [117, 578.4],0); %scan 36
o(16) = combine_data2({'20170907_165359','20170907_194755'}, [117, 578.4],0); %scan 37
o(17) = combine_data2({'20170907_195607','20170908_005824'}, [117, 578.4],0); %scan 37


%o(3) = combine_data2({'20170903_091112','20170903_100221'}, [95.539,
%568.71-3],0); %scan 30

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
