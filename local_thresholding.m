%******************local thresholding - bradley method*******************
% arg 1: 2D image 
% arg 2: n by m neighborhood as [n m], Eg: [250 250]
% arg 3: threshold - a value between 0 and 100
% arg 4: padding
% output: thresholded binary image
function output = local_thresholding(image, varargin)

numvarargs = length(varargin);
optargs = {[15 15] 10 0 'replicate'};
optargs(1:numvarargs) = varargin;
[window, T, padding] = optargs{:};
image = double(image);
mean = averagefilter(image, window, padding);
output = true(size(image));
output(image <= mean*(1-T/100)) = 0;

%***************to calculate averages***************
% arg 1: 2D image 
% arg 2: n by m neighborhood as [n m], Eg: [250 250]
% arg 3: padding
% output: Image - averages of each pixel in input
function [image, t] = averagefilter(image, varargin)

numvarargs = length(varargin); 
optargs = {[3 3] 0};            
optargs(1:numvarargs) = varargin;
[window, padding] = optargs{:}; 
m = window(1);
n = window(2);
[rows columns] = size(image);
if ischar(padding) || isscalar(padding)
    imageP  = padarray(image, [floor((m+1)/2) floor((n+1)/2)], padding, 'pre');
    imagePP = padarray(imageP, [ceil((m-1)/2) ceil((n-1)/2)], padding, 'post');
    imageD = double(imagePP);
    t = cumsum(cumsum(imageD),2);
else
    intm = size(padding, 1) - rows;
    intn = size(padding, 2) - columns;
    deltaMPre = floor((intm+1)/2) - floor((m+1)/2) + 1;
    deltaMPost = ceil((intm-1)/2) - ceil((m-1)/2);
    deltaNPre = floor((intn+1)/2) - floor((n+1)/2) + 1;
    deltaNPost = ceil((intn-1)/2) - ceil((n-1)/2);    
    t = padding(deltaMPre : end-deltaMPost, deltaNPre : end-deltaNPost); 
end
imageI = t(1+m:rows+m, 1+n:columns+n) + t(1:rows, 1:columns)...
    - t(1+m:rows+m, 1:columns) - t(1:rows, 1+n:columns+n);
imageI = imageI/(m*n);
image = cast(imageI, class(image));
