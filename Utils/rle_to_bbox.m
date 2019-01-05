function [bbox] = rle_to_bbox(maskRle, shape, shipThresh)
%RLE_DECODE select one best bbox from image
%   if bbox is in region, suppress it
%   run length encode is used to compress iamge mask file
%   decode rle here and find bounding box
    max_len = size(maskRle);
    img = zeros(1, ceil(shape(1)*shape(2)));
    for i = 1:max_len(2)/2
        img(maskRle(2*i-1):maskRle(2*i-1)-1+maskRle(2*i)) = 1;
    end
    %mask_img = imresize(img, shape);
    mask_img = reshape(img, shape);
    %imshow(mask_img)

    xs = shape(1);
    ys = shape(2);
    xe = 0;
    ye = 0;
    %This implement the same algorithm as below
    %bbox2 = regionprops(mask_img, 'convexarea', 'boundingbox')
    %rectangle('Position', bbox2.BoundingBox, 'EdgeColor', 'r')
    for x = 1:shape(1)
        for y = 1:shape(2)
            if mask_img(x, y) == 1
                xs = min(xs,x);
                xe = max(xe,x);
                ys = min(ys,y);
                ye = max(ye,y);
            end
        end
    end
    if xs <= 5 || ys <=5 || (xe-xs+1) < shipThresh || (ye-ys+1) < shipThresh
        bbox = -1;
    else
        bbox(2)=xs;
        bbox(1)=ys;
        bbox(4)=xe-xs+1;
        bbox(3)=ye-ys+1;
    end
end

