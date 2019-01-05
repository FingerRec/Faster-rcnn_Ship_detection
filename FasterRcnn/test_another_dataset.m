%% Load Detector And Test Data
clc;
clear;
close all;
data = load('/Users/Dropbox/Code/MatlabCode/DSP_Project/FasterRcnn/ship_detection.mat');
detector = data.data.detector;

%% Test MASATI
% Test the Fast R-CNN detector on a test image folder.
% Modify data_path here if needed.

test_data_path = '/Users/Dropbox/课程/现代数字信号处理/项目/船只检测/MASATI-v1/detail/'
%% Img Test And Show
trainImgSize = [228, 228]
imgDir = dir([test_data_path '*.png'])
figure
for i = 1:length(imgDir)
    img = imread([test_data_path imgDir(i).name]);
    % Run detector.
    img = imresize(img, trainImgSize);
    [bbox, score, label] = detect(detector, img);
    % Display detection results.
    detectedImg = insertShape(img, 'Rectangle', bbox);
    label_name = categories(label);
    title(char(cellstr(label_name)));
    if ~isempty(bbox)
        detectedImg = insertObjectAnnotation(detectedImg,'rectangle',bbox,score);
    end
    imshow(detectedImg)
    pause(1)
end