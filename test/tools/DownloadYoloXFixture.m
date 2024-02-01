classdef DownloadYoloXFixture < matlab.unittest.fixtures.Fixture
    % DownloadYoloXFixture   A fixture for calling downloadPretrainedYOLOX
    % if necessary. This is to ensure that this function is only called
    % once and only when tests need it. It also provides a teardown to
    % return the test environment to the expected state before testing.
    
    % Copyright 2022 The MathWorks, Inc
    
    properties(Constant)
        YoloxDataDir = fullfile(getRepoRoot(),'src','model')
    end
    
    properties
        YoloxsExist (1,1) logical
    end
    
    methods
        function setup(this)            
            this.YoloxsExist = exist(fullfile(this.YoloxDataDir,'yolox_s.mat'),'file')==2;
            
            % Call this in eval to capture and drop any standard output
            % that we don't want polluting the test logs.
            if ~this.YoloxsExist
            	evalc('helper.downloadPretrainedYoloX(''yoloxS'');');                
            end
        end
        
        function teardown(this)
            if ~this.YoloxsExist
            	delete(fullfile(this.YoloxDataDir,'yoloxS.mat'));
            end
        end
    end
end
