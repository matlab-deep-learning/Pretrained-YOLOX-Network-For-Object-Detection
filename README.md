# Pretrained YOLOX Network For Object Detection

This repository provides multiple pretrained YOLOX [1] object detection networks for MATLAB®, trained on the COCO 2017[2] dataset. These object detectors can detect 80 different object categories including [person, car, traffic light, etc](/src/%2Bhelper/getCOCOClasess.m).

**Creator**: MathWorks Development

**Includes un-trained model**: ❌  

**Includes transfer learning script**: ❌  


## Requirements
- MATLAB® R2022a or later
- Deep Learning Toolbox™
- Computer Vision Toolbox™


## Getting Started
Download or clone this repository to your machine and open it in MATLAB®.

### Setup
Add path to the source directory.

```matlab
addpath(genpath('src'));
```

### Download the pretrained network
Use the code below to download the pretrained network.

```matlab
% Supported inputs for "downloadPretrainedYoloX" include 'yolox_s', 'yolox_m', 'yolox_l'.
model = helper.downloadPretrainedYoloX('yolox_s');
net = model.net;
```

### Detect Objects Using Pretrained YoloX
Use to code below to perform detection on an example image using the pretrained model.

```matlab
% Read test image.
img = imread(fullfile("data", "inputTeam.jpg"));

% Get classnames for COCO dataset.
classNames = helper.getCOCOClasess;

% Perform detection using pretrained model.
executionEnvironment = 'auto';
[bboxes,scores,labels] = detectYoloX(net, img, classNames, executionEnvironment);

% Visualize results.
annotations = string(labels) + ": " + (round(100*scores)) + "%";
img = insertObjectAnnotation(img, "rectangle", bboxes, annotations);
figure, imshow(img);
```
![Results](/data/results.jpg)


## Metrics and Evaluation

### Size and Accuracy Metrics

| Model     | Input image resolution | Mean average precision (mAP) | Size (MB) |
|-----------|:----------------------:|:----------------------------:|:---------:|
| YoloX-s   |       640 x 640        |               39.8           |  32.0     |
| YoloX-m   |       640 x 640        |               45.9           |  90.2     |
| YoloX-l   |       640 x 640        |               48.6           |  192.9    |


mAP for models trained on the COCO dataset is computed as average over IoU of .5:.95.


## Network Details
YOLOX is one of the best performing object detectors and is considered as an improvement to the existing YOLO variants such as YOLO v4, and YOLO v5.
![YOLOX architecture](/data/yolox_arch.png)

Following are the key features of the YOLOX object detector compared to its predecessors:
- Anchor-free detectors significantly reduce the number of design parameters.
- A decoupled head for classification, regression, and localization improves the convergence speed.
- SimOTA advanced label assignment strategy reduces training time and avoids additional solver hyperparameters.
- Strong data augmentations like MixUp and Mosiac to boost YOLOX performance.


## References
[1] Ge, Zheng, Songtao Liu, Feng Wang, Zeming Li, and Jian Sun. "Yolox: Exceeding yolo series in 2021." arXiv preprint arXiv:2107.08430 (2021).

[2] Lin, T., et al. "Microsoft COCO: Common objects in context. arXiv 2014." arXiv preprint arXiv:1405.0312 (2014).


Copyright 2022 The MathWorks, Inc.
