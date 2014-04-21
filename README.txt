Jeffrey Byrne <jebyrne@cis.upenn.edu>
University of Pennsylvania

The Terrestrial Urban Motion Imagery (TUMI) dataset contains 24 annotated videos 
of functional scene elements in use in downtown Philadelphia.  

1.0 MATLAB QUICKSTART

>> cd $TUMI/toolbox
>> addpath(genpath(pwd))
>> set_paths
>> tumi.show

2.0 MATLAB USAGE

An example script that shows how to import this dataset as a training/testing set

<MATLAB>
%% Import
info = tumi.info();  

%% Objects
k_classes = setdiff(1:length(info.class.name),3);  % minus bus stop
dataset = []; trainset = []; testset = []; D = [];  k_index = 1;
for i=k_classes  
  j = find(info.object.classidx == i & info.object.usageidx > 0 & (info.object.is_hard ~= 1));
  k_classusage = j(randperm(length(j),n_train));  % randomly select n_train instances
  D = [];
  for j=1:length(k_classusage)
    k_video = info.object.videoidx(k_classusage(j));
    k_class = info.object.classidx(k_classusage(j));
    k_instance = info.object.instanceidx(k_classusage(j));
    k_usage = info.object.usageidx(k_classusage(j));
    
    D(j).imgdir = fullfile(info.indir,info.video.name{k_video});
    D(j).vidname = info.video.name{k_video};
    D(j).bbox = info.object.bbox(k_classusage(j),:);
    D(j).frames = info.object.startframe(k_classusage(j)):2:info.object.endframe(k_classusage(j));
    D(j).label = info.class.name{i};
    D(j).index = str2num(sprintf('%02d%02d%02d%02d\n', k_video, k_class, k_instance, k_usage));
    D(j).y = i;    
  end
  
  % Splits 
  testset = [testset; D(1)'];  % leave one out testing
  trainset = [trainset; D(2:end)'];
  dataset = [dataset; D'];
end
</MATLAB>

3.0 LICENSE

This dataset and program are free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

