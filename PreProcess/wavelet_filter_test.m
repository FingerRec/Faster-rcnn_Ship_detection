%%  Wavelet Method 1
%   Progressive Methods
X = imread('/Users/Dropbox/课程/现代数字信号处理/项目/船只检测/MASATI-v1/detail/d0036.png');
X = imresize(X,[256,256]);

steps = 8;
[CR, BPP, Xc] = wavelet_compress(X, steps);
colormap(pink(255));
subplot(1,2,1); image(X);
axis square;
title('Original Image')
subplot(1,2,2); image(Xc);
axis square;
title('Compressed Image')
xlabel({['Steps: ' num2str(steps, '%d')], ...
        ['Compression Ratio: ' num2str(CR,'%1.2f %%')], ...
        ['BPP: ' num2str(BPP,'%3.2f')]})

    
%% Wavelet Method 2
% Global Thresholding and Huffman Encoding
X = imread('/Users/Dropbox/课程/现代数字信号处理/项目/船只检测/MASATI-v1/detail/d0036.png');
X = imresize(X,[256,256]);
meth   = 'gbl_mmc_h'; % Method name
option = 'c';         % 'c' stands for compression
[CR,BPP] = wcompress(option,X,'mask.wtc',meth,'BPP',0.3)

option = 'u';  % 'u' stands for uncompression
Xc = wcompress(option,'mask.wtc');

colormap(pink(255))
subplot(1,2,1); image(X);
axis square;
title('Original Image')
subplot(1,2,2); image(Xc);
axis square;
title('Compressed Image')
xlabel({['Compression Ratio: ' num2str(CR,'%1.2f %%')], ...
        ['BPP: ' num2str(BPP,'%3.2f')]})
    
%% Wavelet denosing
%load(fullfile(matlabroot,'examples','wavelet', 'jump.mat'));
jump = imread('/Users/Dropbox/课程/现代数字信号处理/项目/船只检测/MASATI-v1/detail/d0036.png');
wname = 'bior3.5';
level = 2;
[C,S] = wavedec2(jump,level,wname);

thr = wthrmngr('dw2ddenoLVL','penalhi',C,S,3);
sorh = 's';
[XDEN,cfsDEN,dimCFS] = wdencmp('lvd',C,S,wname,level,thr,sorh);


figure;
subplot(1,2,1);
imagesc(jump); colormap gray; axis off;
title('Noisy Image');
subplot(1,2,2);
imagesc(XDEN); colormap gray; axis off;
title('Denoised Image');

%% Wavelet 
load tartan
X = imread('/Users/Dropbox/课程/现代数字信号处理/项目/船只检测/MASATI-v1/detail/d0036.png');
X = imresize(X, [80, 80]);
nbcol = size(map,1);
cod_X = wcodemat(X,nbcol);
[ca,chd,cvd,cdd] = swt2(X,3,'sym4');
figure
subplot(2,2,1)
image(cod_X)
title('Original Image')
colormap(map)

for k = 1:3
    cod_ca  = wcodemat(ca(:,:,k),nbcol);
    cod_chd = wcodemat(chd(:,:,k),nbcol);
    cod_cvd = wcodemat(cvd(:,:,k),nbcol);
    cod_cdd = wcodemat(cdd(:,:,k),nbcol);
    decl = [cod_ca,cod_chd;cod_cvd,cod_cdd];
    
    subplot(2,2,k+1)
    image(decl)
    
    title(['SWT: Approx. ', ...
        'and Det. Coefs (Lev. ',num2str(k),')'])
    colormap(gray)
end