# parking_app
<img src="https://github.com/gaurang98671/parking_app/blob/master/splash%20screen.jpeg" alt="alt text" width="200" height="350">


<p float="left">
  <img src="https://github.com/gaurang98671/parking_app/blob/master/home1.jpeg" width="200" height="350"/>
  <img src="https://github.com/gaurang98671/parking_app/blob/master/home2.jpeg" width="200" height="350"/> 
</p>


<p float="left">
  <img src="https://github.com/gaurang98671/parking_app/blob/master/info_window1.jpeg" width="200" height="350"/>
  <img src="https://github.com/gaurang98671/parking_app/blob/master/info_window2.jpeg" width="200" height="350"/> 
</p>

<p float="left">
  <img src="https://github.com/gaurang98671/parking_app/blob/master/host_parking.jpeg" width="200" height="350"/>
</p>





# VEHICLE DETECTION, TRACKING AND COUNTING

<p align="center">
  <img src="https://user-images.githubusercontent.com/47656352/87561441-52a5f700-c6da-11ea-90e5-2cc8de11acd0.png">
</p>


[TensorFlow™](https://www.tensorflow.org/) is an open source software library for numerical computation using data flow graphs. Nodes in the graph represent mathematical operations, while the graph edges represent the multidimensional data arrays (tensors) communicated between them.

[OpenCV (Open Source Computer Vision Library)](https://opencv.org/about.html) is an open source computer vision and machine learning software library. OpenCV was built to provide a common infrastructure for computer vision applications and to accelerate the use of machine perception in the commercial products.

### Tracker

<p align="center">
  <img src="https://user-images.githubusercontent.com/22610163/41812993-a4b5a172-7735-11e8-89f6-083ec0625f21.png" | width=700>
</p>

Source video is read frame by frame with OpenCV. Each frames is processed by ["SSD with Mobilenet" model](http://download.tensorflow.org/models/object_detection/ssd_mobilenet_v1_coco_2017_11_17) is developed on TensorFlow. This is a loop that continue working till reaching end of the video. The main pipeline of the tracker is given at the above Figure.


By default I use an ["SSD with Mobilenet" model](http://download.tensorflow.org/models/object_detection/ssd_mobilenet_v1_coco_2017_11_17) in this project. You can find more information about SSD in [here](https://towardsdatascience.com/understanding-ssd-multibox-real-time-object-detection-in-deep-learning-495ef744fab). See the [detection model zoo](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/detection_model_zoo.md) for a list of other models that can be run out-of-the-box with varying speeds and accuracies.

Installations:
  * numpy
  * scipy
  * scikit-image
  * tensorflow-gpu
  * opencv-python
  * packaging



# To Run The Program:

python3 vehicle_detection_main.py
