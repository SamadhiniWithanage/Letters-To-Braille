%% Test Image
clc;
clear all;
close all;

%original code
%[fname, path]=uigetfile('.png','provide an Image for testing');
[fname, path]=uigetfile({'*.png';'*.jpg';'*.bmp';'*.jpeg'},'provide an Image for testing');

%uigetfile({'*.png';'*.jpg';'*.bmp';'*.jpeg'},'Select an Image');


fname=strcat(path, fname);
im1=imread(fname);
%imtool(im1);

%convert image into gray scale 
grayImage = rgb2gray(im1);

%imtool(grayImage);

%calculate the threshold value using otsu methods
threshold = graythresh(grayImage);
threshold
%convet to black and white
binary = im2bw(grayImage,threshold);
%imtool(binary);

%remove the noice of the background
filtImage=medfilt2(binary);
%imtool(filtImage);

%improve the image boundary line----------
%create structuring element
se = strel('disk',4);
im = imerode(filtImage, se);
%perform dialation to an image

%imtool(im);
%title('Test Image');

%diaplay all the images in one plane
subplot(2,2,1);imshow(im1);title("Original Image");
subplot(2,2,2);imshow(grayImage);title("Gray Image");
subplot(2,2,3);imshow(binary);title("Black and White image");
subplot(2,2,4);imshow(im);title("Enhamced Image");
%% Find the class the test image belongs
Ftest=FeatureStatistical(im);
%% Compare with the feature of training image in the database
load database.mat
Ftrain=database(:,1:2);
Ctrain=database(:,3);
for (i=1:size(Ftrain,1))
    dist(i,:)=sum(abs(Ftrain(i,:)-Ftest));
end  



m=find(dist==min(dist),1);
det_class=Ctrain(m);%take class number


%load the braille image in separate folder called "braille"
        D = 'braille';
        S = dir(fullfile(D,'braille_*.png')); % pattern to match filenames.

switch(det_class)
    case 1
        fprintf('A \n');
        %imshow('braille_1.png');
        %display the relevent braille image
            for k = 1
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)   
            end
        
   
    case 2
        fprintf('B \n');
        
            for k = 2
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)   
            end
        
       
    case 3
        fprintf('C \n');
        
            for k = 3
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)    
            end
        
     case 4
        fprintf('D \n');
        
            for k = 4
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 5
        fprintf('E \n');
        
            for k = 5
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)    
            end
    case 6
        fprintf('F \n');
            for k = 6
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
    case 7
        fprintf('G \n');
            for k = 7
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
    case 8
        fprintf('H \n');
        
            for k = 8
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
    case 9
       fprintf('I \n');
        
           for k = 9
               F = fullfile(D,S(k).name);
               I = imread(F);
               imtool(I)     
           end
           
    case 10
       fprintf('J \n');
        
            for k = 10
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
           
     case 11
        fprintf('K \n');
        
            for k = 11
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)    
            end
            
     case 12
        fprintf('L \n');
        
            for k = 12
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 13
       fprintf('M \n');
        
            for k = 13
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 14
        fprintf('N \n');
        
            for k = 14
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)   
            end
            
     case 15
       fprintf('O \n');
        
            for k = 15
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 16
        fprintf('P \n');
        
            for k = 16
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)    
            end
            
     case 17
        fprintf('Q \n');
        
            for k = 17
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 18
        fprintf('R \n');
        
            for k = 18
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 19
        fprintf('S \n');
        
            for k = 19
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 20
        fprintf('T \n');
        
            for k = 20
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 21
        fprintf('U \n');
        
            for k = 21
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)    
            end
            
     case 22
        fprintf('V \n');
        
            for k = 22
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 23
        fprintf('W \n');
        
            for k = 23
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 24
        fprintf('X \n');
        
            for k = 24
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 25
        fprintf('Y \n');
        
            for k = 25
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)    
            end
            
     case 26
        fprintf('Z \n');
        
            for k = 26
                F = fullfile(D,S(k).name);
                I = imread(F);
                imshow(I)   
            end
            
     case 27
        fprintf('a \n');
        
            for k = 1
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 28
        fprintf('b \n');
        
            for k = 2
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 29
        fprintf('d \n');
        
            for k = 4
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)    
            end
            
     case 30
        fprintf('e \n');
        
            for k = 5
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 31
        fprintf('g \n');
        
            for k = 7
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 32
        fprintf('h \n');
        
            for k = 8
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)   
            end
            
     case 33
        fprintf('i \n');
        
            for k = 9
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 34
       fprintf('j \n');
        
            for k = 10
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 35
        fprintf('l \n');
        
            for k = 12
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 36
        fprintf('m \n');
        
            for k = 13
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)   
            end
            
     case 37
        fprintf('n \n');
        
            for k = 14
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)    
            end
            
     case 38
        fprintf('q \n');
        
            for k = 17
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
    case 39
        fprintf('r \n');
        
            for k = 18
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
    
            
     case 40
        fprintf('t \n');
        
            for k = 20
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 41
        fprintf('0 \n');
        
            for k = 27
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 42
        fprintf('1 \n');
        
            for k = 28
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)    
            end
            
     case 43
        fprintf('2 \n');
        
            for k = 29
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 44
        fprintf('3 \n');
        
            for k = 30
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 45
        fprintf('4 \n');
        
            for k = 31
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 46
        fprintf('5 \n');
        
            for k = 32
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 47
        fprintf('6 \n');
        
            for k = 33
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)    
            end
            
     case 48
        fprintf('7 \n');
        
            for k = 34
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 49
       fprintf('8 \n');
        
            for k = 35
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
            
     case 50
       fprintf('9 \n');
        
            for k = 36
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)     
            end
       
        
end

msgbox(strcat('Detected Class=',num2str(det_class)));





