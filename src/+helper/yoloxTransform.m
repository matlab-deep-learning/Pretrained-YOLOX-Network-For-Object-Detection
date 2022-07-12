function predictions = yoloxTransform(prediction, imgSize)
% This function transforms yolox network predictions to required dimension.

% Copyright 2022 The MathWorks, Inc.

grids = [];
expanded_strides = [];

% Define strides.
strides = [8, 16, 32];

% Compute horizontal and vertical grid sizes based on strides.
hsizes = floor(imgSize(1) ./ strides);
wsizes = floor(imgSize(2) ./ strides);
for k = 1: numel(strides)
    wsize = wsizes(k);
    hsize = hsizes(k);
    stride = strides(k);
    [xv, yv] = meshgrid(0:(wsize-1), 0:(hsize-1));
    grid = reshape(cat(3, xv', yv'),[],2);
    grids = [grids; grid];
    shape = size(grid,1);
    expanded_strides = [expanded_strides; ones(shape,1)*stride];
end

% Compute bounding box x,y coordinates based on grids.
prediction(1:2,:) = (prediction(1:2,:) + grids') .* expanded_strides';

% Compute bounding box width and height based on grids.
prediction(3:4,:) = exp(prediction(3:4,:)) .* expanded_strides';
predictions = {prediction};
end