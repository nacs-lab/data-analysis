%Data analysis 2/12/2018, PA    
%AmpPAAOM = 0.05; %400uW
    %TMergeWait = 5e-3;
    folder = 'N:\NaCsLab\Data';
    clearfig = 1; berror = 0;
    p = load([folder '\20180213\' 'VPAScan_20180213_012551.mat']); % Description
    filelist = p.filelist;
    VPATempList = p.VPATempList;
    VPAslope = p.VPAslopeWM; %put m here
    VPAoffset = p.VPAoffsetWM; % put os here
    combine_data2({filelist{1}, filelist{end}}, [VPAslope, VPAoffset], clearfig, berror);
    
    %AmpPAAOM = 0.7*0.05; %200uW
    %TMergeWait = 5e-3;
    folder = 'N:\NaCsLab\Data';
    clearfig = 0; berror = 0;
    p = load([folder '\20180213\' 'VPAScan_20180213_032039.mat']); % Description
    filelist = p.filelist;
    VPATempList = p.VPATempList;
    VPAslope = p.VPAslopeWM; %put m here
    VPAoffset = p.VPAoffsetWM; % put os here
    combine_data2({filelist{1}, filelist{end}}, [VPAslope, VPAoffset], clearfig, berror);
    
    %AmpPAAOM = 0.5*0.05;
    %TMergeWait = 5e-3;
    folder = 'N:\NaCsLab\Data';
    clearfig = 0; berror = 0;
    p = load([folder '\20180213\' 'VPAScan_20180213_051522.mat']); % Description
    filelist = p.filelist;
    VPATempList = p.VPATempList;
    VPAslope = p.VPAslopeWM; %put m here
    VPAoffset = p.VPAoffsetWM; % put os here
    combine_data2({filelist{1}, filelist{end}}, [VPAslope, VPAoffset], clearfig, berror);
    
    %AmpPAAOM = 1.4*0.05;
    %TMergeWait = 5e-3;
    folder = 'N:\NaCsLab\Data';
    clearfig = 0; berror = 0;
    p = load([folder '\20180213\' 'VPAScan_20180213_071014.mat']); % Description
    filelist = p.filelist;
    VPATempList = p.VPATempList;
    VPAslope = p.VPAslopeWM; %put m here
    VPAoffset = p.VPAoffsetWM; % put os here
    combine_data2({filelist{1}, filelist{end}}, [VPAslope, VPAoffset], clearfig, berror);
    
    %AmpPAAOM = 2*0.05;
    %TMergeWait = 5e-3;
    folder = 'N:\NaCsLab\Data';
    clearfig = 0; berror = 0;
    p = load([folder '\20180213\' 'VPAScan_20180213_090542.mat']); % Description
    filelist = p.filelist;
    VPATempList = p.VPATempList;
    VPAslope = p.VPAslopeWM; %put m here
    VPAoffset = p.VPAoffsetWM; % put os here
    combine_data2({filelist{1}, filelist{end}}, [VPAslope, VPAoffset], clearfig, berror);
    
    %AmpPAAOM = 2*0.05;
    %TMergeWait = 1e-3;
    folder = 'N:\NaCsLab\Data';
    clearfig = 1; berror = 0;
    p = load([folder '\20180213\' 'VPAScan_20180213_105916.mat']); % Description
    filelist = p.filelist;
    VPATempList = p.VPATempList;
    VPAslope = p.VPAslopeWM; %put m here
    VPAoffset = p.VPAoffsetWM; % put os here
    combine_data2({filelist{1}, filelist{end}}, [VPAslope, VPAoffset], clearfig, berror);
    
    legend({'400uW','200uW','100uW','800uW','1600uW'})
    