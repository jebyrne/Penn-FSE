function [] = montage()
%--------------------------------------------------------------------------
%
% Copyright (c) 2012 Jeffrey Byrne
%
%--------------------------------------------------------------------------
close all;


%% Inputs
info = fse.info();
n_montage = 10;
outdir = './results';
%outdir = fullfile(tempdir,'fse');
if ~exist(outdir,'dir')
  mkdir(outdir);
end


%% Save montages
for i=1:length(info.object.usageidx)
  if info.object.usageidx(i) ~= 0 && ~isnan(info.object.startframe(i))
    n_skip = floor((info.object.endframe(i)-info.object.startframe(i))/n_montage);
    imroi = fse.import(info.object.videoidx(i),info.object.classidx(i),info.object.instanceidx(i),info.object.usageidx(i),n_skip,info);
    montage(imroi(:,:,:,1:n_montage),'Size',[1 10]); drawnow;
    filename = fullfile(outdir,sprintf('montage_%03d.png',i));
    export_fig(filename);  
    fprintf('[%s][%d/%d]: writing montage ''%s''...\n', mfilename, i, length(info.object.usageidx), filename);
  end
end
