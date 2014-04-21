function [] = show(k_video, k_class, k_instance, k_usage, info, do_bbox, do_usage, n_skip, is_verbose)
%--------------------------------------------------------------------------
%
% Copyright (c) 2012 Jeffrey Byrne
% $Id: demo_hough.m 79 2012-07-27 14:30:30Z jebyrne $
%
%--------------------------------------------------------------------------
close all;

%% Inputs
if ~exist('info','var') || isempty(info)
  info = fse.info();
end
if ~exist('n_skip','var') || isempty(n_skip)
  n_skip = 5;
end
if ~exist('do_bbox','var') || isempty(do_bbox)
  do_bbox = true;
end
if ~exist('do_usage','var') || isempty(do_usage)
  do_usage = false;
end
if ~exist('is_verbose','var') || isempty(is_verbose)
  is_verbose = true;
end
if nargin >= 4 && ~isempty(k_usage)
  do_usage = true;
end
if nargin == 0
  k_video = 1;
end


%% Show objects
if do_bbox
  imname = fullfile(info.indir, info.video.name{k_video}, 'img_00001000.jpg');
  figure(1); imagesc(imread(imname)); axis image; axis off;
  k_object = find(info.object.videoidx == k_video & info.object.usageidx==0);  % all objects
  for k=k_object'
    if ~any(isnan(info.object.bbox(k,:)))
      hold on; rectangle('position',info.object.bbox(k,:),'EdgeColor',[0 1 0],'LineWidth',2); hold off;
      hold on; text(info.object.bbox(k,1)+5,info.object.bbox(k,2)+12,sprintf('%s-%d',info.class.name{info.object.classidx(k)}, info.object.instanceidx(k)),'BackgroundColor',[1 1 1]); hold off;
      if is_verbose
        fprintf('[fse.%s]: Video=''%s'', Object=''%s'', Instance=%d\n', mfilename, info.video.name{k_video}, info.class.name{info.object.classidx(k)}, info.object.instanceidx(k));
      end
    end
  end
  drawnow;
end


%% Show object usage
if do_usage
  j = find((info.object.videoidx == k_video) & ...
    (info.object.classidx == k_class) & ...
    (info.object.instanceidx == k_instance) & ...
    (info.object.usageidx == k_usage));
  
  for k=info.object.startframe(j):n_skip:info.object.endframe(j)
    imgname = fullfile(info.indir, info.video.name{k_video}, sprintf(info.video.imgstr,k));
    roi = imcrop(imread(imgname), info.object.bbox(j,:));
    figure(2); imagesc(roi); axis image; axis off;
    title(sprintf('[%s-%d]:[%d-%d][%d/%d]', info.class.name{k_class}, k_instance, info.object.startframe(j), info.object.endframe(j), k-info.object.startframe(j), info.object.endframe(j)-info.object.startframe(j)));
    drawnow;
  end
end
