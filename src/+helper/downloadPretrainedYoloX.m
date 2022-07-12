function model = downloadPretrainedYoloX(modelName)
% The downloadPretrainedYoloX function downloads a YOLOX networks 
% pretrained on COCO dataset.

% Copyright 2022 The MathWorks, Inc.

supportedNetworks = ["yolox_s", "yolox_m", "yolox_l"];
validatestring(modelName, supportedNetworks);

dataPath = fullfile('src','model');

if ~exist(dataPath, 'dir')
    mkdir(dataPath)
end
addpath(genpath(dataPath));

netMatFileFullPath = fullfile(dataPath, [modelName, '.mat']);
netZipFileFullPath = fullfile(dataPath, [modelName, '.zip']);

if ~exist(netMatFileFullPath,'file')
    if ~exist(netZipFileFullPath,'file')
        fprintf(['Downloading pretrained ', modelName ,' network.\n']);
        fprintf('This can take several minutes to download...\n');
        url = ['https://ssd.mathworks.com/supportfiles/vision/deeplearning/models/yolox/', modelName, '.zip'];
        websave(netZipFileFullPath, url);
        fprintf('Done.\n\n');
        unzip(netZipFileFullPath, dataPath);
    else
        fprintf(['Pretrained ', modelName, ' network (zip file) already exists.\n\n']);
        unzip(netZipFileFullPath, dataPath);
    end
else
    fprintf(['Pretrained ', modelName, ' network (mat file) already exists.\n\n']);
end
model = load(netMatFileFullPath);
end


