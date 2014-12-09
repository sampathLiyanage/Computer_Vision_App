function varargout = descripters(varargin)
% DESCRIPTERS M-file for descripters.fig
%      DESCRIPTERS, by itself, creates a new DESCRIPTERS or raises the existing
%      singleton*.
%
%      H = DESCRIPTERS returns the handle to a new DESCRIPTERS or the handle to
%      the existing singleton*.
%
%      DESCRIPTERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DESCRIPTERS.M with the given input arguments.
%
%      DESCRIPTERS('Property','Value',...) creates a new DESCRIPTERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before descripters_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to descripters_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help descripters

% Last Modified by GUIDE v2.5 18-Nov-2014 23:42:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @descripters_OpeningFcn, ...
                   'gui_OutputFcn',  @descripters_OutputFcn, ...
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


% --- Executes just before descripters is made visible.
function descripters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to descripters (see VARARGIN)

% Choose default command line output for descripters
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes descripters wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = descripters_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% ********************************************************************
% ******************* helper functions *******************************
% ********************************************************************

% --------------------------------------------------------------------
function h=getHistogram(im)
h = zeros(256,1);
for i=0:255
    h(i+1)=sum(sum(im==i));
end

% --------------------------------------------------------------------
function h=smoothHistogram(neighbourSize,histogram)
to = floor(neighbourSize/2);
from = (-1)*to;
h = zeros(256,1);
for i=to+1:255-to
    sum = 0;
    for j=i+from:i+to
        sum=histogram(j)+sum;
    end
    h(i) = round(sum/neighbourSize);
end

% --------------------------------------------------------------------
function im=getGrayImage(im_color)
size_x = size(im_color,1);
size_y = size(im_color,2);
size_z = size(im_color,3);
if (size_z == 3)  
    temp = zeros(size_x, size_y, 'uint8');
    for i=1:size_x
        for j=1:size_y
            temp(i, j) = .299 * im_color(i, j, 1) + .587 * im_color(i, j, 2) + .114 * im_color(i, j, 3);
        end
    end
    im = temp;
end

% --------------------------------------------------------------------
function im = normalize(im_input)
size_x = size(im_input,1);
size_y = size(im_input,2);
size_z = size(im_input,3);
for i=1:size_z
    mn = min(min(im_input(:,:,i)));
    mx = max(max(im_input(:,:,i)));
    for j=1:size_x
        for k=1:size_y            
            im_input(j,k,i) = round(((double(im_input(j,k,i)) - double(mn)) * 255) ./double(mx-mn));
        end
    end
end
im = im_input;

% --------------------------------------------------------------------
function output = modifiedtrimmedfilter(im_input)
size_x = size(im_input,1);
size_y = size(im_input,2);
size_z = size(im_input,3);

%limit = +-95% of variance
output = zeros(size_x, size_y, size_z, 'uint8');
for i=1:size_z
    for j=2:size_x-1
        for k=2:size_y-1
            temp = double(im_input(j-1:j+1, k-1:k+1, i));
            temp = sort(temp(:));
            limit = std(temp(:))*(95/100);
            temp = temp(temp<round(limit) | temp>round(-1*limit));
            output(j,k,i) = mean(temp);
        end
    end
end

% --------------------------------------------------------------------
function output=preProcessGrayImage(image)
im_gray_flt = normalize(image);
im_gray_flt_nrm = modifiedtrimmedfilter(im_gray_flt);
output = im_gray_flt_nrm;


% ********************************************************************
% **************** functions for UI **********************************
% ********************************************************************

% --- Executes on button press in button1.
function button1_Callback(hObject, eventdata, handles)

global image_1;
global descripters_1;

% --- loading image
[baseFileName, folder] = uigetfile('*.*', 'Specify an image file');
fullImageFileName = fullfile(folder, baseFileName);
image_1=imread(fullImageFileName );

if (ndims(image_1)==3)
    im_gray = getGrayImage(image_1);
else
    im_gray = image_1;
end

% --- segmentation
localAreaCount = 10;
m = floor(size(im_gray,1)/localAreaCount);
n = floor(size(im_gray,2)/localAreaCount);
segments = local_thresholding(im_gray,[m, n]);

% --- calculating seven invariant moments
descripters_1 = seven_invariant_moments(imcomplement(segments));

% --- output to UI
axes(handles.imageAxes1);
imshow(image_1);
hist = getHistogram(im_gray);
axes(handles.histogramAxes1);
axis([0 256 0 max(hist)]);
area(hist);
set(handles.results1,'String',descripters_1);


% --- Executes on button press in button2.
function button2_Callback(hObject, eventdata, handles)

global image_2;
global descripters_2;

% --- loading image
[baseFileName, folder] = uigetfile('*.*', 'Specify an image file');
fullImageFileName = fullfile(folder, baseFileName);
image_2=imread(fullImageFileName );

if (ndims(image_2)==3)
    im_gray = getGrayImage(image_2);
else
    im_gray = image_2;
end

% --- segmentation
localAreaCount = 10;
m = floor(size(im_gray,1)/localAreaCount);
n = floor(size(im_gray,2)/localAreaCount);
segments = local_thresholding(im_gray,[m, n]);

% --- calculating seven invariant moments
descripters_2 = seven_invariant_moments(imcomplement(segments));

% --- output to UI
axes(handles.imageAxes2);
imshow(image_2);
hist = getHistogram(im_gray);
axes(handles.histogramAxes2);
axis([0 256 0 max(hist)]);
area(hist);
set(handles.results2,'String',descripters_2);
