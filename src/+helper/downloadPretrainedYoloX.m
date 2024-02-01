function model = downloadPretrainedYoloX(modelName)
% The downloadPretrainedYoloX function downloads a YOLOX networks 
% pretrained on COCO dataset.

% Copyright 2022-2023 The MathWorks, Inc.

supportedNetworks = ["yoloxS", "yoloxM", "yoloxL"];
validatestring(modelName, supportedNetworks);

dataPath = fullfile('src','model');

if ~exist(dataPath, 'dir')
    mkdir(dataPath)
end
addpath(genpath(dataPath));

% Delete the pretrained YOLOX zip files as they are not compatible with R2024b.
switch modelName
    case 'yoloxS'
        if isfile(fullfile(dataPath, 'yolox_s.zip'))
            delete(fullfile(dataPath, 'yolox_s.zip'))
        end
        netMatFileFullPath = fullfile(dataPath, 'yoloxS.mat');
    case 'yoloxM'
        if isfile(fullfile(dataPath, 'yolox_m.zip'))
            delete(fullfile(dataPath, 'yolox_m.zip'))
        end        
        netMatFileFullPath = fullfile(dataPath, 'yoloxM.mat');
    case 'yoloxL'
        if isfile(fullfile(dataPath, 'yolox_l.zip'))
            delete(fullfile(dataPath, 'yolox_l.zip'))
        end
        netMatFileFullPath = fullfile(dataPath, 'yoloxL.mat');
end

netZipFileFullPath = fullfile(dataPath, [modelName, '.zip']);

% Verify if the pretrained YOLOX .mat/.zip file exists.
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

% Load the pretrained YOLOX file
model = load(netMatFileFullPath);

% Check for any warnings related to compatibility issues.
[~, warnId] = lastwarn;
if strcmp(warnId,'nnet_cnn:dlnetwork:LoadobjFailureCauses')
    lastwarn('');
    error(['Delete all the references to YOLOX models from ', fullfile(dataPath), ' folder to re-download the pretrained YOLOX model.']);
end
