# Pretrained YOLOX Network For Object Detection

This repository provides multiple pretrained YOLOX [1] object detection networks for MATLAB®, trained on the COCO 2017[2] dataset. These object detectors can detect 80 different object categories including [person, car, traffic light, etc](/src/%2Bhelper/getCOCOClasess.m). [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=matlab-deep-learning/Pretrained-YOLOX-Network-For-Object-Detection)

**Creator**: MathWorks Development


## Requirements
- MATLAB® R2023b or later
- Deep Learning Toolbox™
- Computer Vision Toolbox™
- Computer Vision Toolbox™ Automated Visual Inspection Library

Note: Previous MATLAB® release users can use [this](https://github.com/matlab-deep-learning/Pretrained-YOLOX-Network-For-Object-Detection/tree/previous) branch to download the pretrained models.


## Getting Started
[Getting Started with YOLOX for Object Detection](https://in.mathworks.com/help/vision/ug/getting-started-with-yolox-object-detection.html)


### Detect Objects Using Pretrained YoloX
Use to code below to perform detection on an example image using the pretrained model.

Note: This functionality requires Deep Learning Toolbox™ and the Computer Vision Toolbox™ Automated Visual Inspection Library. You can install the Computer Vision Toolbox Automated Visual Inspection Library from Add-On Explorer. For more information about installing add-ons, see [Get and Manage Add-Ons](https://in.mathworks.com/help/matlab/matlab_env/get-add-ons.html).

```matlab
% Read test image.
img = imread(fullfile("data", "inputTeam.jpg"));

% Create a yoloxobjectdetector object to configure a pretrained YOLOX network with a CSP-DarkNet-53 backbone as the feature extractor.
detector = yoloxObjectDetector("small-coco");

% Perform detection using pretrained model.
[bboxes,scores,labels] = detect(detector,I);

% Visualize results.
annotations = string(labels) + ": " + (round(100*scores)) + "%";
img = insertObjectAnnotation(img, "rectangle", bboxes, annotations);
figure, imshow(img);
```
![Results](/data/results.jpg)

### Train YOLOX Network and Perform Transfer Learning
To train a YOLOX object detection network on a labeled data set, use the [trainYOLOXObjectDetector](https://in.mathworks.com/help/vision/ref/trainyoloxobjectdetector.html) function. You must specify the class names for the data set you use to train the network. Then, train an untrained or pretrained network by using the [trainYOLOXObjectDetector](https://in.mathworks.com/help/vision/ref/trainyoloxobjectdetector.html) function. The training function returns the trained network as a [yoloxObjectDetector](https://in.mathworks.com/help/vision/ref/yoloxobjectdetector.html) object.

To learn how to configure and train a YOLOX object detector for transfer learning to detect small objects, see the [Detect Defects on Printed Circuit Boards Using YOLOX Network](https://in.mathworks.com/help/vision/ug/detect-pcb-defects-using-yolox-deep-learning.html) example.


## Network Details
YOLOX is one of the best performing object detectors and is considered as an improvement to the existing YOLO variants such as YOLO v4, and YOLO v5.
![YOLOX architecture](/data/yolox_arch.png)


## References
[1] Ge, Zheng, Songtao Liu, Feng Wang, Zeming Li, and Jian Sun. "Yolox: Exceeding yolo series in 2021." arXiv preprint arXiv:2107.08430 (2021).

[2] Lin, T., et al. "Microsoft COCO: Common objects in context. arXiv 2014." arXiv preprint arXiv:1405.0312 (2014).


Copyright 2022 - 2024 The MathWorks, Inc.
