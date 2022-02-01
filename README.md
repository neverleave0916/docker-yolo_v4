# docker-yolo_v4
[![GitHub release](https://img.shields.io/github/release/neverleave0916/docker-yolo_v4)](https://github.com/neverleave0916/docker-yolo_v4/releases/latest)
[![GitHub license](https://img.shields.io/github/license/neverleave0916/docker-yolo_v4)](https://github.com/neverleave0916/docker-yolo_v4/blob/main/LICENSE)
![Docker Image CI workflow](https://github.com/neverleave0916/docker-yolo_v4/actions/workflows/docker-image.yml/badge.svg)


# YOLO-v4 Envirement
 
 **中文教學(full Tutorial)：https://hackmd.io/@neverleave0916/YOLOv4 (可跳過安裝環境，由 3.測試YOLOv4 開始實作)**

 **<font color="#B24B42">Last updated:**  2022/2/1 17:52</font>

- This Repository install all the Dependencies that you need to run yolov4 with GPUs on your own machine.
- YOLO-v4：https://github.com/alexeyab/darknet
- This Docker image is base on nvcr.io/nvidia/pytorch:20.03-py3([reference](https://ngc.nvidia.com/catalog/containers/nvidia:pytorch))(we won't use pytorch)
- You should have CUDA installed on the machine

### Test platform
|   Software    | Version |
|:--------------|:--------|
|    Ubunut     | 18.04  |
|    Docker     | 19.03.8 |
| Nividia Driver| 440.82 |
|     CUDA      | 10.2   |

## Tutorial
### 1. Start docker
> You may use `latest` or `auto` tag to specify the image you need.  
> `latest` is the original image that I generated manually.(2020.07)  
> `auto` is the image that automatic build from this DockerFile.(2022.02)  
- **`auto` image does not contain VNC server**  
- **Except for the package version, there is no difference between the two images. If you can't run Yolo on one, you may try another one.** 
```console=
docker run --gpus all --ipc=host -it -p 8888:8888 -p 5901:5901 neverleave0916/yolo_v4:auto
```
- port 8888: jupyter
- port 5901: VNC(if installed)

### 2. Clone YOLO
```console=
git clone https://github.com/AlexeyAB/darknet
chmod -R 777 darknet/  #This step is important
```
### 3. Use make to compile (you can follow the AlexeyAB/darknet tutorial if you want, below are the steps that I use, because I kept get error in the AlexeyAB/darknet tutorial)
1. Open Makefile
```console=
cd darknet
vim Makefile
```
2. Modify these param to train with GPU and display image  
You may need to follow the newest instruction in the original yolov4 GitHub.
```console=
GPU=1
CUDNN=1
CUDNN_HALF=1
OPENCV=1
AVX=0
OPENMP=0
LIBSO=1
ZED_CAMERA=0 # ZED SDK 3.0 and above
ZED_CAMERA_v2_8=0 # ZED SDK 2.X
```
3. Compile
```console=
make
```
### 4. Test YOLOv4
1. get the pre-train weights
```console=
wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights
```
2. testing YOLOv4(on single Image)
caution ：If there are GUI env on your computer，you could remove  -dont_show to display the image.
```console=
./darknet detector test cfg/coco.data cfg/yolov4.cfg yolov4.weights data/person.jpg -i 0 -thresh 0.25 -dont_show
```
3. View the result

If success, you will get predictions.jpg in your folder.
