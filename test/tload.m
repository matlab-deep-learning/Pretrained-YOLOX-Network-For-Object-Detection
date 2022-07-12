classdef(SharedTestFixtures = {DownloadYoloXFixture}) tload < matlab.unittest.TestCase
    % Test for loading the downloaded models.
    
    % Copyright 2022 The MathWorks, Inc.
    
    % The shared test fixture DownloadYoloXFixture calls
    % DownloadYoloXFixture. Here we check the properties of downloaded
    % models.
    
    properties        
        DataDir = fullfile(getRepoRoot(),fullfile('src','model')); 
    end
    
     
    properties(TestParameter)
        Model = iGetYoloXModel();       
    end
    
    methods(Test)
        function verifyModelAndFields(test,Model)
            % Test point to verify the fields of the downloaded models are
            % as expected.         
            version
            loadedModel = load(fullfile(test.DataDir,Model.dataFileName));
            
            test.verifyClass(loadedModel.net,'dlnetwork');
            test.verifyEqual(numel(loadedModel.net.Layers), Model.expectedNumLayers);
            test.verifyEqual(size(loadedModel.net.Connections), Model.expectedConnectionsSize);
            test.verifyEqual(loadedModel.net.InputNames, Model.expectedInputNames);
            test.verifyEqual(loadedModel.net.OutputNames, Model.expectedOutputNames);
        end        
    end
end

function Model = iGetYoloXModel()
% Load yolox_s
dataFileName = 'yolox_s.mat';

% Expected anchor boxes and classes.
expectedNumLayers = 274;
expectedConnectionsSize = [380 2];
expectedInputNames = {{'images'}};
expectedOutputNames = {{'outputOutput'}};

detectorYOLOX = struct('dataFileName',dataFileName,...
    'expectedNumLayers',expectedNumLayers,'expectedConnectionsSize',expectedConnectionsSize,...
    'expectedInputNames',expectedInputNames, 'expectedOutputNames',expectedOutputNames);

Model = struct(...
     'detectorYOLOX',detectorYOLOX);
end
