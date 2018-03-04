function bruteForceDriver
    
    % NW Architecture
    hiddenLayers = [500 500 1000 7];
    hiddenActivationFunctions = {'ReLu','ReLu','ReLu','softmax'};
    
    % Epochs
    epoch = 50;
    
    % Learning Rate Params
    initialLR = 0.05;
    lrEpochThres = 10;
    lrSchedulingType = 1; % 1 = decrease after lrEpochThres, 2 = scaling, 3 = decrease until half at lrEpochThres
    lrScalingFactor = 0.99; % scaling factor per epoch for lrSchedulingType = 2
    
    % Momentum Params
    momentumEpochLowerThres = 1;
    momentumEpochUpperThres = 40;
    
    % Weight Initialisation Method
    weightInit = 3;
    
    % Weight Regularisation
    L2  = 0; % L2 regularisation coefficient
    L1  = 0; % L1 regularisation coefficient
    maxNorm = 0; % maximum norm allowed, if 0 then it's disabled
    
    % Dropout Params
    dropoutType = 1; % Enable Dropout
    
    % Stopping Criterion
    earlyStopping = 1; % Enable early stopping
    maxFail = 5; % Max number of validation set increases

    bruteForce(hiddenLayers, epoch, initialLR, lrEpochThres, lrSchedulingType, lrScalingFactor, momentumEpochLowerThres, momentumEpochUpperThres, hiddenActivationFunctions, weightInit, L2, L1, maxNorm, dropoutType, earlyStopping, maxFail);
end