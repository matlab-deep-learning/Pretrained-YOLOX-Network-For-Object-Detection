function [bboxes,scores,labels] = postprocess (YPredData, classes, info)
% This function processes the network predictions to obtain final
% detections.

% Copyright 2022 The MathWorks, Inc.

predictions = cellfun(@gather, YPredData,'UniformOutput',false);
extractDetections = cellfun(@extractdata, predictions, 'UniformOutput', false);

detections = cell2mat(extractDetections)';

% Filter the classes based on (confidence score * class probability).
[classProbs, classIdx] = max(detections(:,6:end),[],2);
detections(:,5) = detections(:,5).*classProbs;
detections(:,6) = classIdx;

% Keep detections whose objectness score is greater than thresh.
detections = detections(detections(:,5)>=0.5,:);

[bboxes,scores,labels] = iPostProcessDetections(detections, classes, info);
end

%--------------------------------------------------------------------------
function [bboxes,scores,labels] = iPostProcessDetections(detections,classes,info)

if ~isempty(detections)

    scorePred = detections(:,5);
    bboxesTmp = detections(:,1:4);
    classPred = detections(:,6);

    inputImageSize(2) = info.InputImageSize(2);
    inputImageSize(1) = info.InputImageSize(1);
    
    scale = [info.ScaleX info.ScaleY info.ScaleX info.ScaleY];
    bboxTmp = bboxesTmp.*scale;

    % Convert x and y position of detections from centre to top-left.
    % Resize boxes to image size.
    bboxPred = iConvertCenterToTopLeft(bboxTmp);

    % Apply NMS.
    [bboxes, scores, classNames] = selectStrongestBboxMulticlass(bboxPred, scorePred, classPred ,...
        'RatioType', 'Union', 'OverlapThreshold', 0.5);

    % Limit width detections
    detectionsWd = min((bboxes(:,1) + bboxes(:,3)),inputImageSize(1,2));
    bboxes(:,3) = detectionsWd(:,1) - bboxes(:,1);

    % Limit Height detections
    detectionsHt = min((bboxes(:,2) + bboxes(:,4)),inputImageSize(1,1));
    bboxes(:,4) = detectionsHt(:,1) - bboxes(:,2);

    bboxes(bboxes<1) = 1;

    % Convert classId to classNames.
    %labels = categorical(classes);
    labels = categorical(classes(classNames),classes);
else
    bboxes = zeros(0,4,'single');
    scores = zeros(0,1,'single');
    labels = categorical(cell(0,1),cellstr(classes));
end
end


%--------------------------------------------------------------------------
% Convert x and y position of detections from centre to top-left.
function bboxes = iConvertCenterToTopLeft(bboxes)
bboxes(:,1) = bboxes(:,1)- bboxes(:,3)/2 + 0.5;
bboxes(:,2) = bboxes(:,2)- bboxes(:,4)/2 + 0.5;
bboxes(bboxes<1) = 1;
end
