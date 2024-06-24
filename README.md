# mean-shape-based-post-processing
Based on the paper (to be published in PLOS one): 'A novel mean shape based post-processing method for enhancing deep learning lower-limb muscle segmentation accuracy'.

# 2D-processing
The code written by MATLAB provided in this folder mainly realizes the 2D post-processing method mentioned in 'Loss, post-processing and standard architecture improvements of liver deep learning segmentation from Computed Tomography and magnetic resonance'.
First, the label file predicted by the DL model is saved in the same folder according to the serial number. After the path is set, it is read into a 3D matrix in MATLAB. Then, 2D post-processing is carried out on the predicted results through convolution and basic image operations, e.g. erosion and dilation. 

# CRF
This folder contains files that implement CRF post-processing methods. 
The core of the method is based on the following two papers.
'Efficient Inference in Fully Connected CRFs with Gaussian Edge Potentials'
'SEMANTIC IMAGE SEGMENTATION WITH DEEP CONVOLUTIONAL NETS AND FULLY CONNECTED CRFS'

include the 2 scripts：
--main_save_to_npy.ipynb
  The purpose of using this file is to first save the result of the DL model prediction into the [height, width, n] npy file format. Height and Width are the size of the image, respectively, and n represents the number of classes in the training task. In this study, there are 26 classes (including background, class 0), so the output size should be [256,256,26].
--main_all.ipynb
  Start by installing the 'pydensecrf' package  provided by Python. After the installation is complete, CRF can be used for post-processing by adjusting and setting different hyperparameters, and then the post-processed result is saved as 2Dslice (.png file in this study).
