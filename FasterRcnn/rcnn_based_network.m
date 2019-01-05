function [lgraph] = rcnn_based_network(baseNet, numClasses)
%RCNN_BASED_NETWORK construct faster-rcnn based on selected network
% Load pretrained ResNet-50(ImageNet) as base bone.
    net = baseNet;
    
    lgraph = layerGraph(net);

    % Remove the the last 3 layers. 
    layersToRemove = {
        'fc1000'
        'fc1000_softmax'
        'ClassificationLayer_fc1000'
        };
    lgraph = removeLayers(lgraph, layersToRemove);

    % Specify the number of classes the network should classify.
    numClassesPlusBackground = numClasses + 1;

    % Define new classification layers.
    newLayers = [
        fullyConnectedLayer(numClassesPlusBackground, 'Name', 'rcnnFC')
        softmaxLayer('Name', 'rcnnSoftmax')
        classificationLayer('Name', 'rcnnClassification')
        ];

    % Add new object classification layers.
    lgraph = addLayers(lgraph, newLayers);

    % Connect the new layers to the network. 
    lgraph = connectLayers(lgraph, 'avg_pool', 'rcnnFC');

    % Define the number of outputs of the fully connected layer.
    numOutputs = 4 * numClasses;

    % Create the box regression layers.
    boxRegressionLayers = [
        fullyConnectedLayer(numOutputs,'Name','rcnnBoxFC')
        rcnnBoxRegressionLayer('Name','rcnnBoxDeltas')
        ];

    % Add the layers to the network.
    lgraph = addLayers(lgraph, boxRegressionLayers);

    % Connect the regression layers to the layer named 'avg_pool'.
    lgraph = connectLayers(lgraph,'avg_pool','rcnnBoxFC');

    % Select a feature extraction layer.
    featureExtractionLayer = 'activation_40_relu';

    % Disconnect the layers attached to the selected feature extraction layer.
    lgraph = disconnectLayers(lgraph, featureExtractionLayer,'res5a_branch2a');
    lgraph = disconnectLayers(lgraph, featureExtractionLayer,'res5a_branch1');

    % Add ROI max pooling layer.
    outputSize = [14 14];
    roiPool = roiMaxPooling2dLayer(outputSize,'Name','roiPool');
    lgraph = addLayers(lgraph, roiPool);

    % Connect feature extraction layer to ROI max pooling layer.
    lgraph = connectLayers(lgraph, featureExtractionLayer,'roiPool/in');

    % Connect the output of ROI max pool to the disconnected layers from above.
    lgraph = connectLayers(lgraph, 'roiPool','res5a_branch2a');
    lgraph = connectLayers(lgraph, 'roiPool','res5a_branch1');

    % Define anchor boxes.
    anchorBoxes = [
        16 16
        32 16
        16 32
        ];

    % Create the region proposal layer.
    proposalLayer = regionProposalLayer(anchorBoxes,'Name','regionProposal');

    lgraph = addLayers(lgraph, proposalLayer);

    % Number of anchor boxes.
    numAnchors = size(anchorBoxes,1);

    % Number of feature maps in coming out of the feature extraction layer. 
    numFilters = 1024;

    rpnLayers = [
        convolution2dLayer(3, numFilters,'padding',[1 1],'Name','rpnConv3x3')
        reluLayer('Name','rpnRelu')
        ];

    lgraph = addLayers(lgraph, rpnLayers);

    % Connect to RPN to feature extraction layer.
    lgraph = connectLayers(lgraph, featureExtractionLayer, 'rpnConv3x3');

    %Add the RPN classification output layers. The classification layer classifies each anchor as "object" or "background".

    % Add RPN classification layers.
    rpnClsLayers = [
        convolution2dLayer(1, numAnchors*2,'Name', 'rpnConv1x1ClsScores')
        rpnSoftmaxLayer('Name', 'rpnSoftmax')
        rpnClassificationLayer('Name','rpnClassification')
        ];
    lgraph = addLayers(lgraph, rpnClsLayers);

    % Connect the classification layers to the RPN network.
    lgraph = connectLayers(lgraph, 'rpnRelu', 'rpnConv1x1ClsScores');
    %Add the RPN regression output layers. The regression layer predicts 4 box offsets for each anchor box.

    % Add RPN regression layers.
    rpnRegLayers = [
        convolution2dLayer(1, numAnchors*4, 'Name', 'rpnConv1x1BoxDeltas')
        rcnnBoxRegressionLayer('Name', 'rpnBoxDeltas');
        ];

    lgraph = addLayers(lgraph, rpnRegLayers);

    % Connect the regression layers to the RPN network.
    lgraph = connectLayers(lgraph, 'rpnRelu', 'rpnConv1x1BoxDeltas');
%    Finally, connect the classification and regression feature maps to the region proposal layer inputs, and the ROI pooling layer to the region proposal layer output.

    % Connect region proposal network.
    lgraph = connectLayers(lgraph, 'rpnConv1x1ClsScores', 'regionProposal/scores');
    lgraph = connectLayers(lgraph, 'rpnConv1x1BoxDeltas', 'regionProposal/boxDeltas');

    % Connect region proposal layer to roi pooling.
    lgraph = connectLayers(lgraph, 'regionProposal', 'roiPool/roi');

    % Show the network after adding the RPN layers.
    %figure
    %plot(lgraph)
    ylim([30 42])
end

