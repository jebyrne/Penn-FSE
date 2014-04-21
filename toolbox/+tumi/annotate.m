function [] = annotate()
%--------------------------------------------------------------------------
%
% Copyright (c) 2012 Jeffrey Byrne
% $Id: demo_hough.m 79 2012-07-27 14:30:30Z jebyrne $
%
%--------------------------------------------------------------------------

%% Import
info = tumi.info();


%% Annotation
for k=1:length(info.object.instanceidx)
  if info.object.do_annotation(k) == 1
    if (info.object.usageidx(k) == 0)
      k_video = info.object.videoidx(k);
      fprintf('[tumi.%s]: Video=''%s'', Object=''%s'', Instance=%d\n', mfilename, info.video.name{k_video}, info.class.name{info.object.classidx(k)}, info.object.instanceidx(k));
      tumi.show(k_video, [], [], [], info, true, false, 0, false);
      info.object.bbox(k,:) = getrect();
      tumi.show(k_video, [], [], [], info, true, false, 0, false);
      
      % Write me (all usages)
      j_usage = find(info.object.videoidx==k_video & info.object.classidx==info.object.classidx(k) & info.object.instanceidx==info.object.instanceidx(k));
      for j=j_usage'
        info.object.bbox(j,:) = info.object.bbox(k,:);
        status = xlswrite(info.xlsname, round(info.object.bbox(j,:)), 'objects', sprintf('F%d:I%d',j+1,j+1));
        if ~status
          error('error writing to xls file ''%s''\n', info.xlsname);
        end
      end
    else      
      % Usage Annotation
      k_video = info.object.videoidx(k);
      k_class = info.object.classidx(k);
      k_instance = info.object.instanceidx(k);
      k_usage = info.object.usageidx(k);
      
      % Video bounding box annotation!
      global GUI;  % usage annotation
      GUI.videodir = fullfile(info.indir, info.video.name{k_video});
      GUI.imgstr = info.video.imgstr;
      GUI.startframe = info.object.startframe(k);
      GUI.endframe = info.object.endframe(k);
      if isnan(GUI.startframe)        
        GUI.startframe = max(info.object.minute(k)*60*30 + info.object.second(k)*30 - 128,1);
        GUI.endframe = min(GUI.startframe + 256, info.video.maxframes(k_video));
      end
      GUI.maxframes = info.video.maxframes(k_video);
      GUI.classname = info.class.name{k_class};
      GUI.bbox = info.object.bbox(k,:);
      gui_usage();  % interactive
      
      % Exit?
      if GUI.is_exit
        fprintf('[tumi.%s]: exiting annotation\n', mfilename);
        return;
      end
      
      % Export me
      if (GUI.startframe ~= info.object.startframe(k)) || (GUI.endframe ~= info.object.endframe(k))  % changed?
        status = xlswrite(info.xlsname, [GUI.startframe GUI.endframe], 'objects', sprintf('L%d:M%d',k+1,k+1));
        if ~status
          error('error writing to xls file ''%s''\n', info.xlsname);
        end
      end
    end
  else
    fprintf('[%s]: SKIPPING object = %d (annotation flag disabled)\n', mfilename, k);
  end
end

