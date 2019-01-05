function [outputImg] = middle_filter(inputImg, thresh)
%MEDIA_FILTER 
    inputImg
    outputImg = medfilt3(inputImg, [thresh, thresh, 1]);
    %f = medfilt3(f, [5, 5, 1]);
end

