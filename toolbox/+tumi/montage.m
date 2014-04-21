function [] = montage()
%--------------------------------------------------------------------------
%
% Copyright (c) 2012 Jeffrey Byrne
% $Id: demo_hough.m 79 2012-07-27 14:30:30Z jebyrne $
%
%--------------------------------------------------------------------------
close all;


%% Inputs
info = tumi.info();
n_montage = 10;
outdir = 'C:\jebyrne\penn\papers\nested_motion_descriptors\figures\montage';
%outdir = fullfile(tempdir,'tumi');
if ~exist(outdir,'dir')
  mkdir(outdir);
end


%% Save montages
for i=1:length(info.object.usageidx)
  if info.object.usageidx(i) ~= 0 && ~isnan(info.object.startframe(i))
    n_skip = floor((info.object.endframe(i)-info.object.startframe(i))/n_montage);
    imroi = tumi.import(info.object.videoidx(i),info.object.classidx(i),info.object.instanceidx(i),info.object.usageidx(i),n_skip,info);
    montage(imroi(:,:,:,1:n_montage),'Size',[1 10]); drawnow;
    filename = fullfile(outdir,sprintf('montage_%03d.png',i));
    export_fig(filename);  
    fprintf('[%s][%d/%d]: writing montage ''%s''...\n', mfilename, i, length(info.object.usageidx), filename);
  end
end
