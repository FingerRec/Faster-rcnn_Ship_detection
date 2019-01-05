function [outputImg] = dct_transform(inputImg, blkSizes)
%DCT_TRANSFORM dct transform
%   use dct transform

    inImg = inputImg
    inImg = imresize(inImg, [224,224]);
    s_inImg = size(inImg);
    outImg = zeros(s_inImg);

    %DCT Parameters
    blkSize = blkSizes;

    ycbcrInImg = rgb2ycbcr(inImg);
    y_inImg = ycbcrInImg(:,:,1);
    cb_inImg = ycbcrInImg(:,:,2);
    cr_inImg = ycbcrInImg(:,:,3);

    I_max = max(max(y_inImg));

    %Block-wise Splitting
    y_blocks = Mat_dec(y_inImg, blkSize);

    s = size(y_blocks);
    dctBlks = zeros(s);

    for i = 1 : s(3)
        for j = 1 : s(4)
            localBlk = y_blocks(:,:,i,j);
            localdctBlk = dct2(localBlk);

            localdctBlk = localdctBlk ./ 8;

            orig_dc = localdctBlk(1,1);

            %Adjustment of Local Background Illumination
            x = localdctBlk(1,1) / double(I_max);
            mapped_dc = x * (2 - x) * double(I_max);

            %Preservation of Local Contrast
            k = mapped_dc / orig_dc;

            localdctBlk(1,1) = k * localdctBlk(1,1);

            dctBlks(:,:,i,j) = localdctBlk;
        end
    end

    dctImg = merge_blocks(dctBlks);

    dctImg = dctImg .* 8;

    y_outImg = blkproc(dctImg, [blkSizes blkSizes], 'idct2(x)');
    y_outImg = imresize(y_outImg, [224, 224]);
    ycbcrOutImg = zeros(224,224,3);
    ycbcrOutImg(:,:,1) = y_outImg;
    ycbcrOutImg(:,:,2) = cb_inImg;
    ycbcrOutImg(:,:,3) = cr_inImg;

    ycbcrOutImg = uint8(ycbcrOutImg);

    rgbOutImg = ycbcr2rgb(ycbcrOutImg);
    outputImg = rgbOutImg;
end

