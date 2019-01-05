function [outputImage] = wiener_filter(image, motionLen, motionTheta, nsr)
%WIENER_FILTER use wiener filter to clean iamge's motion information
%  image:
%  motionLen:
%  motionTheta:
%  noiseValue:
%
%  COPYRIGHT:Awiny
%  Email:awinyimgprocess@gmail.com

image = im2double(image);
LEN = motionLen;
THETA = motionTheta;
PSF = fspecial('motion', LEN, THETA);
outputImage = deconvwnr(image, PSF, nsr);
end

