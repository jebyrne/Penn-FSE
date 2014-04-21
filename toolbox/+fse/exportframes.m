function [] = exportframes()
%--------------------------------------------------------------------------
%
% Copyright (c) 2012 Jeffrey Byrne
%
%--------------------------------------------------------------------------

%ffmpeg = '/cygdrive/c/jebyrne/software/ffmpeg-git-cbf914c-win32-static/bin/ffmpeg.exe';
ffmpeg = 'ffmpeg';

info = fse.info();
h = fopen(fullfile(info.indir,'exportframes.sh'),'w');
fprintf(h,'#!/bin/bash\n\n');
for k=1:length(info.video.name)
  fprintf(h,'%s -qscale 1 -i %s.MP4 -qscale 1 -r 30 ./%s/img_%%08d.jpg\n', ffmpeg, info.video.name{k}, info.video.name{k});
end
fclose(h);
