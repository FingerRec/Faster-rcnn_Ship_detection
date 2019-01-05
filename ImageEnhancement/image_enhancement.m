%% Image Enhancement by Histogram Equalization
% This example shows how to generate HDL code from a MATLAB(R) design 
% that does image enhancement using histogram equalization.

%   Copyright 2011-2015 The MathWorks, Inc.

%% Algorithm
%  
% The Histogram Equalization algorithm enhances the contrast of images by 
% transforming the values in an intensity image so that the histogram 
% of the output image is approximately flat.
%
  I = imread('/Users/Dropbox/课程/现代数字信号处理/项目/船只检测/MASATI-v1/detail/d0128.png');
  J = histeq(I);
  subplot(2,2,1);
  imshow( I );
  subplot(2,2,2);   
   imhist(I)
   subplot(2,2,3);
   imshow( J );
   subplot(2,2,4);
   imhist(J)
%% FFT
%f = zeros(30,30);
%f(5:24,13:17) = 1;
%imshow(f,'InitialMagnification','fit')
f = imread('/Users/Dropbox/课程/现代数字信号处理/项目/船只检测/MASATI-v1/detail/d0128.png');
%f = rgb2gray(f);
%f = imbinarize(f);
figure
imshow(f)
figure
f = medfilt3(f, [5, 5, 1]);
imshow(f);
%{
F = fft2(f);
F2 = log(abs(F));
subplot(1,4,2),
imshow(F2,[-1 5],'InitialMagnification','fit');
colormap(jet); colorbar
F = fft2(f,256,256);
subplot(1,4,3),
imshow(log(abs(F)),[-1 5]); colormap(jet); colorbar
F = fft2(f,256,256);F2 = fftshift(F);
subplot(1,4,4),
imshow(log(abs(F2)),[-1 5]); colormap(jet); colorbar
%}

%% Other Filter
I = imread('/Users/Dropbox/课程/现代数字信号处理/项目/船只检测/MASATI-v1/detail/d0128.png');
for i = 1:3
    figure
    subplot(1,3,1)
    imshow(I)
    SE = strel('arbitrary',eye(3));
    BW2 = imerode(I,SE);
    subplot(1,3,2)
    imshow(BW2)
    SE = strel('arbitrary',eye(5));
    BW2 = imdilate(BW2,SE);
    subplot(1,3,3)
    imshow(BW2), title('Original')
    I = BW2;
end