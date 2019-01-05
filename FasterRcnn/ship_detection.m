function [outputImg] = ship_detection(inputImg, detector)
%SHIP_DETECTION 此处显示有关此函数的摘要
%   此处显示详细说明
    %data = load('ship_detection.mat');
    %detector = data.data.detector;
    trainImgSize = [228, 228]
    img = imresize(inputImg, trainImgSize);
    [bbox, score, label] = detect(detector, img);
    % Display detection results.
    outputImg = insertShape(img, 'Rectangle', bbox);
    if ~isempty(bbox)
        outputImg = insertObjectAnnotation(outputImg,'rectangle',bbox,score);
    end
end

