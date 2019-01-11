%% Parameters

clc; clear; close all;
baseBone = ['resnet50', 'alexnet', 'vgg16', 'vgg19', 'resnet50',...
        'resnet101', 'inceptionv3', 'googlenet', 'inceptionresnetv2', 'squeezenet']
    
params.csvFilePath = '/home/awiny/Datasets/ship_detection/train_ship_segmentations_v2.csv';
params.datasetPath = '/home/awiny/Datasets/ship_detection/train_v2/';
params.newPath = '/home/awiny/Dropbox/Code/MatlabCode/DSP_Project/BigShips/';
params.allImgNum = 100000;
params.shipThresh = 60; %100 recommand
params.trainImgSize = [228, 228];
params.originImgSize = [768, 768];
params.cnnInputSize = [32, 32];
params.batchSize = 1;
params.initialLR = 1e-3;
params.maxEpoches = 30;
params.VerboseFrequency = 200;
params.numClasses = 1; %Only Ship
params.baseNet = resnet50; %choose one from baseBone or contrust CNN by cnn_construct.m

addpath('FasterRcnn', 'Utils')
%% Consturct Dataset
% Step1: Read csv File and find 
%
[data, ship_count] = create_dataset(params.csvFilePath, params.newPath, ...
            params.datasetPath, params.allImgNum, params.originImgSize, ...
            params.trainImgSize, params.shipThresh)
fprintf("All img num is: %d \n",ship_count)
%bbox = rle_to_bbox

%% Plot Data
dataMat = data;
vehicleDataset = dataMat.vehicleTrainingData;
for i = 100:100
    
    I = imread(vehicleDataset.imageFileName{i});

    % Insert the ROI labels.
    I = insertShape(I, 'Rectangle', vehicleDataset.Ship{i});

    % Resize and display image.
    I = imresize(I,3);
    imshow(I)
    pause(1)
end


%% Divide Dataset
% Split data into a training and test set.
% If training and test in a dataset, do this step, otherwise skip it.
% 70 precent are used to train and 30 precent are used to test.
idx = floor(0.7 * height(vehicleDataset));
trainingData = vehicleDataset(1:idx,:);
testData = vehicleDataset(idx:end,:);
data.trainingData = trainingData;
data.testData = testData;
data.idx = idx;
fprintf("Train img num is: %d \n",idx)
fprintf("Test img num is: %d \n",height(vehicleDataset) - idx)
%% Load data

%trainingData = dataMat.vehicleTrainingData;

%% Define CNN
cnn = rcnn_based_network(params.baseNet, params.numClasses)
%cnn = cnn_construct(params.cnnInputSize, trainingData)

%% Load Training Options
[options] = training_options(params.batchSize, params.initialLR,...
    params.maxEpoches, params.VerboseFrequency);


%% Train Detector
% Train detector. Training will take a few minutes.
% Cnn based
detector = trainFasterRCNNObjectDetector(trainingData, cnn, options, ...
    'NegativeOverlapRange',[0 0.3], ...
    'PositiveOverlapRange',[0.6 1], ...
    'NumRegionsToSample',[256 128 256 128], ...
    'BoxPyramidScale', 1.2);
% Resnet50 based
%detector = trainFasterRCNNObjectDetector(trainingData, cnn, options, ...
%    'NegativeOverlapRange',[0 0.3], ...
%    'PositiveOverlapRange',[0.6 1], ...
%    'NumRegionsToSample',[256 128 256 128]);
data.detector = detector;

%% Save Result
save(fullfile('.','CheckPoints/ship_detection.mat'), 'data');

%{
%% Load Test Detector
%data = load('fasterRCNNVehicleTrainingData.mat');
data = load('ship_detection.mat');
detector = data.data.detector;
%}