function bruteForceDriver

    hiddenLayers = [500 500 1000 7];
    epoch = 50;
    initialLR = 0.02;
    lrEpochThres = 10;
    lrSchedulingType = 2; %2 = scaling
    lrScalingFactor = 0.9; %Comment out if not using scaling
    momentumEpochLowerThres = 10;
    momentumEpochUpperThres = 25;
    hiddenActivationFunctions = {'ReLu','ReLu','sigm','softmax'};
    weightInit = 8;

    bruteForce(hiddenLayers, epoch, initialLR, lrEpochThres, lrSchedulingType, lrScalingFactor, momentumEpochLowerThres, momentumEpochUpperThres, hiddenActivationFunctions, weightInit);
end