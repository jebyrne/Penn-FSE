function [imroi] = import(k_video, k_class, k_instance, k_usage, n_skip, info)
%--------------------------------------------------------------------------
%
% Copyright (c) 2012 Jeffrey Byrne
%
%--------------------------------------------------------------------------
close all;


%% Inputs
if ~exist('info','var') || isempty(info)
  info = fse.info();
end
if ~exist('n_skip','var') || isempty(n_skip)
 n_skip = 1;
end


%% Import object usage
j = find((info.object.videoidx == k_video) & ...
  (info.object.classidx == k_class) & ...
  (info.object.instanceidx == k_instance) & ...
  (info.object.usageidx == k_usage));

fprintf('[%s]: importing video=%d, class=%d, instance=%d, usage=%d\n', mfilename, k_video, k_class, k_instance, k_usage); 
k_frame = info.object.startframe(j):n_skip:info.object.endframe(j);
for k=1:length(k_frame)
  imgname = fullfile(info.indir, info.video.name{k_video}, sprintf(info.video.imgstr,k_frame(k)));
  imroi(:,:,:,k) = imcrop(imread(imgname), info.object.bbox(j,:));
  fprintf('[%s][%d/%d]: importing...\n', mfilename, k, length(k_frame));
end
