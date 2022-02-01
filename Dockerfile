FROM nvcr.io/nvidia/pytorch:20.03-py3
LABEL maintainer="neverleave0916@gmail.com" version="1.0"
 
#https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
ARG DEBIAN_FRONTEND=noninteractive

#prevent error
RUN chmod 777 /tmp
RUN apt-get update -y

#vim
RUN apt-get install -y vim

#CMake >= 3.8 (for modern CUDA support)(CPU and GPU)
RUN apt install -y cmake>=3.14.0

#4.OpenCV >= 2.4 (For CPU and GPU)
RUN apt install -y libopencv-dev python3-opencv

#others
RUN apt install -y make git g++

#8888:jupyter
#8070:flask
#5000:flask default
#8080:nothing
#5901:VNC(if installed)
EXPOSE 8888 8070 5000 8080 5901