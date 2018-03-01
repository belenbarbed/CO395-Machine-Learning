function bruteForce(hiddenLayers, epoch, initialLR, lrEpochThres, momentumEpochLowerThres, momentumEpochUpperThres, hiddenActivationFunctions, weightInit)

    % load MNIST data
    load('data4students.mat')

    % training inputs
    train_x = double(datasetInputs{1,1});
    train_y = double(datasetTargets{1,1});

    % test inputs
    test_x = double(datasetInputs{1,2});
    test_y = double(datasetTargets{1,2});

    % validation inputs
    val_x = double(datasetInputs{1,3});
    val_y = double(datasetTargets{1,3});

    inputSize = size(train_x,2);
    
    % parameters used for visualisation of first layer weights
    visParams.noExamplesPerSubplot = 1; % number of images to show per row
    visParams.noSubplots = floor(hiddenLayers(1) / visParams.noExamplesPerSubplot);
    visParams.col = 30;% number of image columns
    visParams.row = 30;% number of image rows 

    inputActivationFunction = 'linear'; %sigm for binary inputs, linear for continuous input

    % normalise data
    train_x = normaliseData(inputActivationFunction, train_x, []);
    val_x = normaliseData(inputActivationFunction, val_x, []);
    test_x = normaliseData(inputActivationFunction, test_x, []);

    %initialise NN params
    nn = paramsNNinit(hiddenLayers, hiddenActivationFunctions);
    
    % Set some NN params
    nn.batchsize = 80;
    nn.epochs = epoch;

    % set initial learning rate
    nn.trParams.lrParams.initialLR = initialLR;
    nn.trParams.lrParams.lrEpochThres = lrEpochThres;
    % set the learning rate update policy (check manual)
    % 1 = initialLR*lrEpochThres / max(lrEpochThres, T), 2 = scaling, 3 = lr / (1 + currentEpoch/lrEpochThres)
    nn.trParams.lrParams.schedulingType = 1;

    nn.trParams.momParams.schedulingType = 1;
    %set the epoch where the learning will begin to increase
    nn.trParams.momParams.momentumEpochLowerThres = momentumEpochLowerThres;
    %set the epoch where the learning will reach its final value (usually 0.9)
    nn.trParams.momParams.momentumEpochUpperThres = momentumEpochUpperThres;

    % set weight constraints
    nn.weightConstraints.weightPenaltyL1 = 0;
    nn.weightConstraints.weightPenaltyL2 = 0;
    nn.weightConstraints.maxNormConstraint = 4;

    % show diagnostics to monnitor training  
    nn.diagnostics = 1;
    % show diagnostics every "showDiagnostics" epochs
    nn.showDiagnostics = 5;

    % show training and validation loss plot
    nn.showPlot = 1;

    % use bernoulli dropout
    nn.dropoutParams.dropoutType = 0;

    % if 1 then early stopping is used
    nn.earlyStopping = 0;
    nn.max_fail = 10;

    nn.type = 2;

    % set the type of weight initialisation (check manual for details)
    nn.weightInitParams.type = weightInit;

    % set training method
    % 1: SGD, 2: SGD with momentum, 3: SGD with nesterov momentum, 4: Adagrad, 5: Adadelta,
    % 6: RMSprop, 7: Adam
    nn.trainingMethod = 2;
    %-----------

    % initialise weights
    [W, biases] = initWeights(inputSize, nn.weightInitParams, hiddenLayers, hiddenActivationFunctions);

    nn.W = W;
    nn.biases = biases;
  
    % if dropout is used then use max-norm constraint and a
    % high learning rate + momentum with scheduling
    % see the function below for suggested values
    %nn = useSomeDefaultNNparams(nn);
   
    step = 5;
    stops = floor(epoch/step);
    seq = repmat(step, 1, stops);
    rem = mod(epoch, step);
    seq = [seq rem];
    
    for i=1:length(seq)
        ep = list(seq);
        % nn.epochs = ep;
    end

    [nn, ~, L_train, L_val, clsfError_train, clsfError_val]  = trainNN(nn, train_x, train_y, val_x, val_y);

    nn = prepareNet4Testing(nn);

    % RESULTS LOGGING
    dir = 'results/';
    timestamp = datestr(now, 'dd-mm-yy_HH-MM-SS-FFF');
    % visualise loss per epoch
    figure()
    hold on
    p1 = plot(L_train, 'b-', 'Markersize', 8);
    p2 = plot(L_val, 'r-', 'Markersize', 8);
    xlabel('epoch')
    ylabel('loss')
    legend([p1,p2], {'Training','Validation'},'Location','NorthEast')
    hold off
    % save figure
    saveas(gca, strcat(dir, timestamp, '_loss.png'))

    % visualise classification error per epoch
    figure()
    hold on
    p1 = plot(clsfError_train, 'b-', 'Markersize', 8);
    p2 = plot(clsfError_val, 'r-', 'Markersize', 8);
    xlabel('epoch')
    ylabel('classification error (%)')
    legend([p1,p2], {'Training','Validation'},'Location','NorthEast')
    hold off
    % save figure
    saveas(gca, strcat(dir, timestamp, '_clasfError.png'))

    [stats, ~, ~, ~] = evaluateNNperformance( nn, test_x, test_y);
    % save nn hyperparameters and perfonmance in text file
    % format: ID, nw arch, epochs, initialLR, lrEpochThres, lrShedulingType,
    %         momShedulingType, momEpochLowerThres, momEpochUpperThres,
    %         dropoutType, earlyStopping, max_fail
    fileID = fopen(strcat(dir, 'results.txt'),'a');
    fprintf(fileID, '%21s | ', timestamp);
    fprintf(fileID, '%10.4f | ', stats.clsfRate);
    fprintf(fileID, strcat(repmat('%5d ', 1, length(nn.layersSize)), ' | '), nn.layersSize);
    fprintf(fileID, strcat(repmat('%5d ', 1, length(nn.activation_functions )), ' | '), nn.activation_functions);
    fprintf(fileID, '%6d | ', nn.epochs);
    fprintf(fileID, '%10.3f | ', nn.trParams.lrParams.initialLR);
    fprintf(fileID, '%7d | ', nn.trParams.lrParams.lrEpochThres);
    fprintf(fileID, '%6d | ', nn.trParams.lrParams.schedulingType);
    fprintf(fileID, '%5d | ', nn.trParams.momParams.schedulingType);
    fprintf(fileID, '%6d | ', nn.trParams.momParams.momentumEpochLowerThres);
    fprintf(fileID, '%6d | ', nn.trParams.momParams.momentumEpochUpperThres);
    fprintf(fileID, '%6d | ', nn.dropoutParams.dropoutType);
    fprintf(fileID, '%5d | ', nn.earlyStopping);
    fprintf(fileID, '%6d | ', nn.max_fail);
    fprintf(fileID, '%6d',    nn.weightInitParams.type);
    fprintf(fileID, '\n');
    fclose(fileID);
end