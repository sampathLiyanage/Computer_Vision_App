function varargout = computer_vision(varargin)
% COMPUTER_VISION M-file for computer_vision.fig
%      COMPUTER_VISION, by itself, creates a new COMPUTER_VISION or raises the existing
%      singleton*.
%
%      H = COMPUTER_VISION returns the handle to a new COMPUTER_VISION or the handle to
%      the existing singleton*.
%
%      COMPUTER_VISION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPUTER_VISION.M with the given input arguments.
%
%      COMPUTER_VISION('Property','Value',...) creates a new COMPUTER_VISION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before computer_vision_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to computer_vision_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help computer_vision

% Last Modified by GUIDE v2.5 18-Nov-2014 23:20:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @computer_vision_OpeningFcn, ...
                   'gui_OutputFcn',  @computer_vision_OutputFcn, ...
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


% --- Executes just before computer_vision is made visible.
function computer_vision_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to computer_vision (see VARARGIN)

% Choose default command line output for computer_vision
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes computer_vision wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = computer_vision_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function pointoperationsmenu_Callback(hObject, eventdata, handles)
% hObject    handle to pointoperationsmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function filemenu_Callback(hObject, eventdata, handles)
% hObject    handle to filemenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function statistics_Callback(hObject, eventdata, handles)
% hObject    handle to statistics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function filters_Callback(hObject, eventdata, handles)
% hObject    handle to statistics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function invariantMoments_Callback(hObject, eventdata, handles)
% hObject    handle to canny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
descripters;

% --------------------------------------------------------------------
function imageComparison_Callback(hObject, eventdata, handles)
% hObject    handle to edgeDetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function edgeDetection_Callback(hObject, eventdata, handles)
% hObject    handle to edgeDetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function invariantMoments_Callback(hObject, eventdata, handles)
% hObject    handle to invariantMoments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%********************************************************************
%************************ file operations **************************
%********************************************************************

% --------------------------------------------------------------------
function openimage_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_original;
global im_edited;

% Browse for the image file.
[baseFileName, folder] = uigetfile('*.*', 'Specify an image file');
% Create the full file name.
fullImageFileName = fullfile(folder, baseFileName);
im_original=imread(fullImageFileName );
im_edited=im_original;

imshow(im_original);

% --------------------------------------------------------------------
function resetimage_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_original;
global im_edited;
im_edited = im_original;
imshow(im_original);

% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
[FileName, PathName] = uiputfile({'*.bmp'; '*.jpg'; '*.gif'}, 'Save As'); %# <-- dot
if PathName==0, return; end    %# or display an error message
Name = fullfile(PathName,FileName);  %# <--- reverse the order of arguments
imwrite(im_edited, Name);


%********************************************************************
%************************ edge detection **************************
%********************************************************************

% --------------------------------------------------------------------
function canny_Callback(hObject, eventdata, handles)
% hObject    handle to canny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
im = double(canny(im_edited,6,1,0.1));
im_edited = arrayfun(@(x) x*255,im);
imshow(im_edited);    

%********************************************************************
%************************ point operations **************************
%********************************************************************

% --------------------------------------------------------------------
function transpose_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

temp = zeros(size_y, size_x, size_z, 'uint8');
for i=1:size_z
    for j=1:size_x
        for k=1:size_y
            temp(k, j, i) = im_edited(j, k, i); 
        end
    end
end

im_edited = temp;
imshow(im_edited);

% --------------------------------------------------------------------
function rotate_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);


temp = zeros(size_y, size_x, size_z, 'uint8');
for i=1:size_z
    for j=1:size_x
        for k=1:size_y
            temp(size_y-k+1, j, i) = im_edited(j, k, i); 
        end
    end
end

im_edited = temp;
imshow(im_edited);

% --------------------------------------------------------------------
function tograyscale_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

if (size_z == 3)
    
    temp = zeros(size_x, size_y, 'uint8');
    for i=1:size_x
        for j=1:size_y
            temp(i, j) = .299 * im_edited(i, j, 1) + .587 * im_edited(i, j, 2) + .114 * im_edited(i, j, 3);
        end
    end
    im_edited = temp;
end

imshow(im_edited);

% --------------------------------------------------------------------
function verticalflip_Callback(hObject, eventdata, handles)
% hObject    handle to verticalflip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;

size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

temp = im_edited; 

for i=1:size_z
    for j=1:size_x
        for k=1:size_y
            temp(j,size_y+1-k,i) = im_edited(j,k,i);
        end
    end
end
im_edited = temp;
imshow(im_edited);

% --------------------------------------------------------------------
function crop_Callback(hObject, eventdata, handles)
% hObject    handle to verticalflip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
im_edited = imcrop;
imshow(im_edited);

% --------------------------------------------------------------------
function digitalnegative_Callback(hObject, eventdata, handles)
% hObject    handle to verticalflip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;

size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

temp = im_edited; 

for i=1:size_z
    for j=1:size_x
        for k=1:size_y
            temp(j,k,i) = 255 - im_edited(j,k,i);
        end
    end
end
im_edited = temp;
imshow(im_edited);

% --------------------------------------------------------------------
function squareroot_Callback(hObject, eventdata, handles)
% hObject    handle to verticalflip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;

size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

temp = im_edited; 

for i=1:size_z
    for j=1:size_x
        for k=1:size_y
            temp(j,k,i) = round(sqrt(double(im_edited(j,k,i))));
        end
    end
end
im_edited = temp;
imshow(im_edited);

% --------------------------------------------------------------------
function normalize_Callback(hObject, eventdata, handles)
% hObject    handle to verticalflip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;

size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

for i=1:size_z
    mn = min(min(im_edited(:,:,i)));
    mx = max(max(im_edited(:,:,i)));
    for j=1:size_x
        for k=1:size_y            
            im_edited(j,k,i) = round(((double(im_edited(j,k,i)) - double(mn)) * 255) ./double(mx-mn));
        end
    end
end
imshow(im_edited);



%********************************************************************
%************************ filters ********************************
%********************************************************************

% --------------------------------------------------------------------
function meanfilter_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

mask = (1/121)* [1,2,3,2,1; 2,7,11,7,2; 3,11,17,11,3; 2,7,11,7,2; 1,2,3,2,1];
output = zeros(size_x, size_y, size_z, 'uint8');
for i=1:size_z
    for j=3:size_x-2
        for k=3:size_y-2
            temp = im_edited(j-2:j+2, k-2:k+2, i);
            mul = mask .* double(temp);
            output(j,k,i) = round(sum(mul(:)));
        end
    end
end

im_edited = output;
imshow(im_edited);

% --------------------------------------------------------------------
function medianfilter_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

output = zeros(size_x, size_y, size_z, 'uint8');
for i=1:size_z
    for j=2:size_x-1
        for k=2:size_y-1
            temp = im_edited(j-1:j+1, k-1:k+1, i);
            output(j,k,i) = round(median(temp(:)));
        end
    end
end

im_edited = output;
imshow(im_edited);

% --------------------------------------------------------------------
function midfilter_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

output = zeros(size_x, size_y, size_z, 'uint8');
for i=1:size_z
    for j=2:size_x-1
        for k=2:size_y-1
            temp = im_edited(j-1:j+1, k-1:k+1, i);
            mn = min(temp(:));
            mx = max(temp(:));
            output(j,k,i) = round((mn+mx)/2);
        end
    end
end

im_edited = output;
imshow(im_edited);

% --------------------------------------------------------------------
function minfilter_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

output = zeros(size_x, size_y, size_z, 'uint8');
for i=1:size_z
    for j=2:size_x-1
        for k=2:size_y-1
            temp = im_edited(j-1:j+1, k-1:k+1, i);
            output(j,k,i) = round(min(temp(:)));
        end
    end
end

im_edited = output;
imshow(im_edited);

% --------------------------------------------------------------------
function maxfilter_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

output = zeros(size_x, size_y, size_z, 'uint8');
for i=1:size_z
    for j=2:size_x-1
        for k=2:size_y-1
            temp = im_edited(j-1:j+1, k-1:k+1, i);
            output(j,k,i) = round(max(temp(:)));
        end
    end
end

im_edited = output;
imshow(im_edited);

% --------------------------------------------------------------------
function mmsefilter_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

%window_size = 5;

output = zeros(size_x, size_y, size_z, 'uint8');
for i=1:size_z
    channel = double(im_edited(:,:,i));
    global_var = var(channel(:));
    for j=3:size_x-2
        for k=3:size_y-2
            temp = double(im_edited(j-2:j+2, k-2:k+2, i));
            local_var = var(temp(:));
            local_mean = mean(temp(:));
            output(j,k,i) = round((1 - (local_var/global_var)).*double(im_edited(j,k,i)) + (local_var/global_var).*local_mean);
        end
    end
end

im_edited = output;
imshow(im_edited);

% --------------------------------------------------------------------
function alphatrimmedfilter_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

p = 3;

output = zeros(size_x, size_y, size_z, 'uint8');
for i=1:size_z
    for j=2:size_x-1
        for k=2:size_y-1
            temp = im_edited(j-1:j+1, k-1:k+1, i);
            temp = sort(temp(:));
            from = p+1;
            to = size(temp,1)-p;
            temp = temp(from:to);
            output(j,k,i) = mean(temp);
        end
    end
end

im_edited = output;
imshow(im_edited);

% --------------------------------------------------------------------
function modifiedtrimmedfilter_Callback(hObject, eventdata, handles)
% hObject    handle to openimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

%limit = +-95% of variance

output = zeros(size_x, size_y, size_z, 'uint8');
for i=1:size_z
    for j=2:size_x-1
        for k=2:size_y-1
            temp = double(im_edited(j-1:j+1, k-1:k+1, i));
            temp = sort(temp(:));
            limit = std(temp(:))*(95/100);
            temp = temp(temp<round(limit) | temp>round(-1*limit));
            output(j,k,i) = mean(temp);
        end
    end
end

im_edited = output;
imshow(im_edited);


%********************************************************************
%************************ statistics ********************************
%********************************************************************
% --------------------------------------------------------------------
function histogram_Callback(hObject, eventdata, handles)
% hObject    handle to verticalflip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_edited;
size_x = size(im_edited,1);
size_y = size(im_edited,2);
size_z = size(im_edited,3);

% convert to gray scale
if (size_z == 3)
    
    temp = zeros(size_x, size_y, 'uint8');
    for i=1:size_x
        for j=1:size_y
            temp(i, j) = .299 * im_edited(i, j, 1) + .587 * im_edited(i, j, 2) + .114 * im_edited(i, j, 3);
        end
    end
else
    temp = im_edited;
end

h = zeros(256,1);
for i=0:255
    h(i+1)=sum(sum(temp==i));
end
figure('name','Histogram'), bar(0:255,h);


