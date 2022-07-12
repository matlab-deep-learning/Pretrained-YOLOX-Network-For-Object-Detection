classdef(SharedTestFixtures = {DownloadYoloXFixture}) tPretrainedYOLOX < matlab.unittest.TestCase
    % Test for PretrainedYOLOX
    
    % Copyright 2022 The MathWorks, Inc.
    
    % The shared test fixture downloads the model. Here we check the
    % detections of each models.
    properties        
        RepoRoot = getRepoRoot;
    end
    
    properties(TestParameter)
        Model = iGetYoloXModel();
    end

    methods(Test)
        function exerciseDetection(test,Model)            
            detector = load(fullfile(test.RepoRoot,'src','model',Model.dataFileName));
            image = imread(fullfile(test.RepoRoot,'data','inputTeam.jpg'));
            classNames = helper.getCOCOClasess;
            [bboxes, scores, labels] = detectYoloX(detector.net, image, classNames, 'auto');
            test.verifyEqual(bboxes, Model.expectedBboxes,'AbsTol',single(1e-4));
            test.verifyEqual(scores, Model.expectedScores,'AbsTol',single(1e-4));
            test.verifyEqual(labels, Model.expectedLabels);            
        end       
    end
end

function Model = iGetYoloXModel()
% Load yolox_s
dataFileName = 'yolox_s.mat';

% Expected detection results.
expectedBboxes = single([155.48085	33.221832	108.86650	371.32471
263.10626	38.897644	119.73260	350.60150
390.14221	49.816055	107.93585	319.93030
30.533241	54.371277	135.13126	358.51074]);

expectedScores = single([0.92699677; 0.93545032; 0.95401210; 0.93229830]);
expectedLabels = categorical({'person';'person';'person';'person'});
detectorYOLOXs = struct('dataFileName',dataFileName,...
    'expectedBboxes',expectedBboxes,'expectedScores',expectedScores,...
    'expectedLabels',expectedLabels);

 Model = struct(...
    'detectorYOLOXs',detectorYOLOXs);  
end