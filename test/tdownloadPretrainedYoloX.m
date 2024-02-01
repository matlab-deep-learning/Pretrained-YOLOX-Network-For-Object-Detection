classdef(SharedTestFixtures = {DownloadYoloXFixture}) tdownloadPretrainedYoloX < matlab.unittest.TestCase
    % Test for downloadPretrainedYoloX

    % Copyright 2022 The MathWorks, Inc.

    % The shared test fixture DownloadYoloXFixture calls
    % downloadPretrainedYoloX. Here we check that the downloaded files
    % exists in the appropriate location.

    properties
        DataDir = fullfile(getRepoRoot(),'src','model');
    end

    methods(Test)
        function verifyDownloadedFilesExist(test)
            dataFileName = 'yoloxS.mat';
            test.verifyTrue(isequal(exist(fullfile(test.DataDir,dataFileName),'file'),2));
        end
    end
end
