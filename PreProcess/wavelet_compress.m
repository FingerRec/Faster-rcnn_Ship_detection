function [CR, BPP, outputImg] = wavelet_compress(inputImg, steps)
%WAVELET_FILTER1 wavelet compress and loss some water informations
%   Truecolor images can be compressed using the same scheme as grayscale images by
%   applying the same strategies to each of the three color components.
    inputImg = imresize(inputImg, [256,256]);
    [CR,BPP] = wcompress('c',inputImg,'wpeppers.wtc','spiht','maxloop',steps);
    outputImg = wcompress('u','wpeppers.wtc');
end

