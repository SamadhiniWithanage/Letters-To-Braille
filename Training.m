clc;
clear all;
close all;
%% Taking an Image
[fname, path]=uigetfile('.png','Open an Image as input for training');
fname=strcat(path, fname);

im1=imread(fname);0
grayImage = rgb2gray(im1);
threshold = graythresh(grayImage);
binary = im2bw(grayImage,threshold);
filtImage=medfilt2(binary);
se = strel('disk',4);
im = imerode(filtImage, se);

imshow(im);
title('Input Image for processing');
c=input('Enter the Class - 1 to 50 \n');
%% Feature Extraction
F=FeatureStatistical(im);
try 
    load database;
    F=[F c];
    database=[database; F];
    save database.mat database 
catch 
    database=[F c]; % 10 12 1
    save database.mat database 
end



