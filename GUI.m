function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 10-Apr-2020 01:32:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);







% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%load the image to the panel
% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%fname--- file name
%pname---path name

[fname,pname]= uigetfile({'*.png';'*.jpg';'*.bmp';'*.jpeg'},'Select an Image');
if isequal(fname,0) || isequal(pname,0)
    uiwait(msgbox('User cancle the action','failed','modal'))
  
    hold off;
else
    uiwait(msgbox('Image added Successfully','success','modal'))
    hold off;
    originalImagePath= strcat(pname,fname);
    im1 = imread(originalImagePath);
    imshow(im1,'Parent',handles.axes1) 
end
handles.im1 = im1;
guidata(hObject,handles);


%enhanced the image 
% --- Executes on button press in enhanced.
function enhanced_Callback(hObject, eventdata, handles)
% hObject    handle to enhanced (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

im1=handles.im1;
imshow(im1,'Parent',handles.axes1)

%convert image into gray scale 
grayImage = rgb2gray(im1);

%imtool(grayImage);

%calculate the threshold value using otsu methods
threshold = graythresh(grayImage);

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

imshow(im,'Parent',handles.axes2) 



handles.im = im;
guidata(hObject,handles);



%identify the letter using the build network
% --- Executes on button press in letterIdentification.
function letterIdentification_Callback(hObject, eventdata, handles)
% hObject    handle to letterIdentification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




im=handles.im;
imshow(im,'Parent',handles.axes2)



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
        
        letterNew = 'A';
            for k = 1
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)   
            end
        
   
    case 2
        fprintf('B \n');
        
        letterNew = 'B';
            for k = 2
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)   
            end
        
       
    case 3
        fprintf('C \n');
        
        letterNew = 'C';
            for k = 3
                F = fullfile(D,S(k).name);
                I = imread(F);
                imtool(I)    
            end
        
     case 4
        fprintf('D \n');
        
        letterNew = ''D;
            for k = 4
                F = fullfile(D,S(k).name);
                I = imread(F);
               % imtool(I)     
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

imshow(I,'Parent',handles.axes3)







msgbox(strcat('Detected Class=',num2str(det_class)));




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
