function bruteForceDriver

    hiddenLayers = [500 500 1000 7];
    epoch = 50;
    initialLR = 0.01;
    lrEpochThres = 5;
    momentumEpochLowerThres = 5;
    momentumEpochUpperThres = 50;
    hiddenActivationFunctions = {'ReLu','ReLu','sigm','softmax'};
    weightInit = 3;

    bruteForce(hiddenLayers, epoch, initialLR, lrEpochThres, momentumEpochLowerThres, momentumEpochUpperThres, hiddenActivationFunctions, weightInit);
end