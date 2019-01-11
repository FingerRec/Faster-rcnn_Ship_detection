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
![image](https://github.com/FingerRec/Faster-rcnn_Ship_detection/raw/master/Output/software_capture1.bmp)
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
