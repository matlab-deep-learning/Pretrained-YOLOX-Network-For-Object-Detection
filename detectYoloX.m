function [bboxes,scores,labels] = detectYoloX(dlnet, image, classNames, executionEnvironment)
% detectYoloX runs prediction on a trained yolox network.
%
% Inputs:
% dlnet                - Pretrained yolox dlnetwork
% image                - RGB image to run prediction on. (H x W x 3)
% executionEnvironment - Environment to run predictions on. Specify cpu,
%                        gpu, or auto.
%
% Outputs:
% bboxes     - Final bounding box detections ([x y w h]) formatted as
%              NumDetections x 4.
% scores     - NumDetections x 1 classification scores.
% labels     - NumDetections x 1 categorical class labels.

% Copyright 2022 The MathWorks, Inc.

targetSize = [640 640];

sz = size(image);
imgScale   = sz(1:2)./targetSize(1:2);
[~,idx] = max(imgScale);
[info.ScaleX,info.ScaleY] = deal(imgScale(idx),imgScale(idx));

% Preprocess the image.
Ipreprocessed = helper.preprocess(image, targetSize);
Ipreprocessed = Ipreprocessed(:,:,[3,2,1]);

info.PreprocessedImageSize = size(Ipreprocessed);
info.InputImageSize = size(image);

% Convert to dlarray.
XTest = dlarray(Ipreprocessed, 'SSCB');

% If GPU is available, then convert data to gpuArray.
if (executionEnvironment == "auto" && canUseGPU) || executionEnvironment == "gpu"
    XTest = gpuArray(XTest);
end

% Output from YoloX model for the given test image.
features = predict(dlnet, XTest);
outputFeatures = helper.yoloxTransform(features, targetSize);

% Postprocess the output.
[bboxes,scores,labels] = helper.postprocess(outputFeatures, classNames, info);
end