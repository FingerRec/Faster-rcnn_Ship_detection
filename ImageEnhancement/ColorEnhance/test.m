clc;
close all;
% clear all;

inImg = imread('/home/awiny/Dropbox/Code/MatlabCode/DSP_Project/BigShips/33.jpg');
subplot(1,2,1);imshow(inImg);title('Input Image');
output_img = inImg;
output_img = autoEnhancement(inImg);
subplot(1,2,2);imshow(output_img);title('Input Image');