function [info] = info(xlsname)
%--------------------------------------------------------------------------
%
% Copyright (c) 2012 Jeffrey Byrne
% $Id: demo_hough.m 79 2012-07-27 14:30:30Z jebyrne $
%
%--------------------------------------------------------------------------

%% Inputs
if ~exist('xlsname','var')
  xlsname = which('PENN-FSE.xlsx');
  indir = fileparts(xlsname);  % run set_paths()
else
  indir = fileparts(xlsname);
end


%% Import xls file 
[NUM_overview,TXT_overview]=xlsread(xlsname,'overview');
[NUM_class,TXT_class]=xlsread(xlsname,'classes');
[NUM_objects,TXT_objects] = xlsread(xlsname,'objects');


%% Export!
info.indir = indir;
info.xlsname = xlsname;

info.video.name = TXT_overview(2:3:71,1);
info.video.index = unique(NUM_objects(:,1));
info.video.imgstr = 'img_%08d.jpg';  % sprintf
info.video.maxframes = NUM_overview(1:3:71,3);

info.class.name = TXT_class(2:end,1);
info.class.index = NUM_class(:,1);

info.object.videoidx = NUM_objects(:,1);
info.object.classidx = NUM_objects(:,2);
info.object.instanceidx = NUM_objects(:,3);
info.object.usageidx = NUM_objects(:,4);
info.object.bbox = NUM_objects(:,5:8);
info.object.minute = NUM_objects(:,9);  
info.object.second = NUM_objects(:,10);  
info.object.startframe = NUM_objects(:,11); 
info.object.endframe = NUM_objects(:,12); 
info.object.do_annotation = NUM_objects(:,13);
info.object.is_hard = NUM_objects(:,14);



