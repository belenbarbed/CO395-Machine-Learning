function bruteForceDriver

    hiddenLayers = [500 500 1000 7];
    epoch = 50;
    initialLR = 0.001;
    lrEpochThres = 10;
    momentumEpochLowerThres = 10;
    momentumEpochUpperThres = 45;
    hiddenActivationFunctions = {'ReLu','ReLu','ReLu','softmax'};

    bruteForce(hiddenLayers, epoch, initialLR, lrEpochThres, momentumEpochLowerThres, momentumEpochUpperThres, hiddenActivationFunctions);


end