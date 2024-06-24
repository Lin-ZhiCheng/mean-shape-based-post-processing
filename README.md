# mean-shape-based-post-processing
Based on the paper (to be published in PLOS one): 'A novel mean shape based post-processing method for enhancing deep learning lower-limb muscle segmentation accuracy'.

# 2D-processing
The code written by MATLAB provided in this folder mainly realizes the 2D post-processing method mentioned in 'Loss, post-processing and standard architecture improvements of liver deep learning segmentation from Computed Tomography and magnetic resonance'.
First, the label file predicted by the DL model is saved in the same folder according to the serial number. After the path is set, it is read into a 3D matrix in MATLAB. Then, 2D post-processing is carried out on the predicted results through convolution and basic image operations, e.g. erosion and dilation. 

# CRF
