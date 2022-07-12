function output = preprocess(img,targetSize)
% This function preprocesses the input image.

% Copyright 2022 The MathWorks, Inc.

% Compute the scale to resize the input image.
imgSize = size(img);
scale = targetSize(1:2)./imgSize(1:2);
[~,index] = max(scale);

% Resize the img to targetSize.
if index == 1
    img = imresize(img, [nan,targetSize(index)]);
    img = cat(1,img,ones(targetSize(index)-size(img,1),size(img,2),3)*127);
else
    img = imresize(img, [targetSize(index),nan]);
    img = cat(2,img,ones(size(img,1),targetSize(index)-size(img,2),3)*127);
end
img = single(img);

% Rescale the img in the range [0,1].
output = img;
end