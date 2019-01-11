## Requirements

[![Minimum Version](https://img.shields.io/badge/Matlab-R2018b-green.svg)][matlab]
[![](https://img.shields.io/badge/Matlab-DeeplearningToolbox-brightgreen.svg)][matlab toolbox]
[![](https://img.shields.io/badge/Matlab-ImageProcessToolbox-orange.svg
)][matlab toolbox]
[![](https://img.shields.io/badge/Matlab-ComputerVisionSystemToolbox-yellow.svg)][matlab toolbox]
[![](https://img.shields.io/badge/Nvidia-CUDA--GPU-blue.svg)][cuda]

> Install these toolboxs from MatlabR2018b app manager directly.  
> A cuda-avilable gpu is auto used in matlab. Make sure you have a GPU, cpu train is very cery slow.

## Screenshots
![](https://uc6ebc35cff4e21bee75632e70da.previews.dropboxusercontent.com/p/thumb/AASJuayOLOkpIHDcGVWHQIs6Y2X7F0piK8B0UBWmcAw9JxOESvoHVrxefvZmM4_2t-oZovIJRA9SCJMLTVhxmuqwUg0wrLnT_sTRjkJI6SFi1GeDdIykkqSlSzxVoiTAACGH-OwuPp2STWyVpEbTYqa3DlxB4TWJj3O3i0_oDk1gYOW3MDWj7mVxF9AiZEnS5zJjksvF6p2LnmeVtSVCn7FBzDZCAtGAidpPneVH1HI2Cy5TcTLyx5Vr9o0Vn-F5FNHNhUxs_kdJN4Q8uTSUO9DJxF4meThlGaySS7qTggOFd3gztROjVnNOzHaKEwxaHP8WN7TTWCe407X3pv68y3ZjqTUjNWauXJjGkDd6upfhL8b0ZsHpYXc-rnLDgGk5kbTkLVj_HWuCJJkeKxsnXxrN9fMFdLXVrN5yqO97Y94S5QXpO7SHn_UWriPJRV25j-fd1Z6YT7o1GVOWdvUkPYM_/p.jpeg?size=1280x960&size_mode=3)

![image](https://github.com/FingerRec/Faster-rcnn_Ship_detection/raw/master/Output/software_capture2.bmp)
![image](https://github.com/FingerRec/Faster-rcnn_Ship_detection/raw/master/Output/wavelet_filter_compress.bmp)
![image](https://github.com/FingerRec/Faster-rcnn_Ship_detection/raw/master/Output/wiener_filter_example_1.bmp)

## Introduction
This project include 3 parts.

* Preprocess
* Image Enhancement
* Ship Detection

> Preprocess: denoise(medfilt), motionclear(winner filter), compress(wavelet compress)
> Enhancement: DCT, Color based
> Ship Detection: Faster-rcnn

## Run
1. download [MASTAI](http://www.iuii.ua.es/datasets/masati/) and [airbus-ship-detection-data](https://www.kaggle.com/c/airbus-ship-detection/data), extract to any place. (**MASTAI only have main class label without mask. Kaggle airbus data are used to train faster-rcnn.**)
2. add this project to path.
3. Modify line7-line9 in FasterRcnn/train_faster_rcnn.m according to your dataset's place, train faster-rcnn and use FasterRcnn/test_faster_rcnn.m to test the model.(**Install resnet50 according to the tip.**)
4. Test the model's preformance on **MASTAI** by using test_another_dataset.m.(**modify line 5 and line 12.**)
5. Open main.mlapp and run.

## Trained Model

I have published trained model:
[mlp_based_faster_rcnn](https://www.dropbox.com/s/f5mvu4gr9if6r6d/ship_detection.mat?dl=0) [resnet50_based_faster_rcnn](https://www.dropbox.com/s/f5mvu4gr9if6r6d/ship_detection.mat?dl=0)
## Others
This project is based on [matlab toolobox](https://ww2.mathworks.cn/products.html).

[matlab]: https://ww2.mathworks.cn/products/matlab/whatsnew.html
[matlab toolbox]: https://ww2.mathworks.cn/products.html
[cuda]: https://developer.nvidia.com/cuda-downloads
