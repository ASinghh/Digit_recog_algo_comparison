# Digit_recog_algo_comparison
In this project we tried to compare the performance of 3 different methods for handwritten digit recognition using the famous MNIST DataSet.

I have tried to use Neural Networks, SVM and SVM plus Principal component Analysis.

A SVM model with kernel of 9th order, gamma  = 0.01 and cost = 1000 gave me a test set accuracy of 95.24%.

A Neural net model with rectifier activation gave a test set accuracy of 97.41%. This might be further improved.My work was limited by my hardware and I couldn't do a grid search on the full data set


A SVM model on a  PCA transformed data gave the best result of 98%.This is inutitive as PCA would transform the dataset into  more relevant features and the less important features could be dropped. I plotted the variability explained versus the number of predictor from the top and selected the  
