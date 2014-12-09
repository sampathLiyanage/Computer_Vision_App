% arg 1: img
% arg 2: size of guassian kernal
% sigma: standard deviation of guassian function
% thresh: treshold (0 < thresh < 1)
function [gnh,gnl]= canny(img,si,sigma,thresh)
% --- input argument check.
if(thresh(1)>1 || thresh(1)<0)
 error('Thresh value(s) should be between 0 and 1');
end
I=img;
if(size(I,3)==3)
    I=rgb2gray(I);
end
dim=size(I);
if length(thresh)==1
    lthresh=0.4*thresh;
    uthresh=thresh;
else
    uthresh=thresh(1);
    lthresh=thresh(2);
end
if(uthresh>1.0)
    uthresh=1;
end

% --- convolving with gaussian filter
h=fspecial('gaussian',si,sigma);
I=im2double(I);
I=imfilter(I,h,'conv');

% --- Compute Gaussian derivatives
 x=-si:1:si;
 y=-si:1:si;
gaussx=-(x/(sigma*sigma)).*exp(-(x.*x+y.*y)/(2*sigma*sigma));
gaussy=gaussx';
Ix=imfilter(I,gaussx,'conv');
Iy=imfilter(I,gaussy,'conv');

Mag=sqrt(Ix .^ 2 + Iy .^ 2);
Magmax=max(Mag(:));
Mag=Mag/Magmax;
gnl=zeros(dim(1),dim(2));
gnh=zeros(dim(1),dim(2));
idxes = find(Mag>lthresh);
theta = cart2pol(Ix(idxes),Iy(idxes));
theta = theta/pi*180;
direction = floor(mod(theta+22.5,180)/45)+1;
deltax = [1 1 0 -1];
deltay = [0 1 1 1];
deltaxs = deltax(direction)';
deltays = deltay(direction)';

[yis,xis] = ind2sub(dim,idxes);
yis1=yis+deltays; yis1=max(yis1,1); yis1=min(yis1,dim(1));
yis2=yis-deltays; yis2=max(yis2,1); yis2=min(yis2,dim(1));
xis1=xis+deltaxs; xis1=max(xis1,1); xis1=min(xis1,dim(2));
xis2=xis-deltaxs; xis2=max(xis2,1); xis2=min(xis2,dim(2));
idxes1 = sub2ind(dim,yis1,xis1);
idxes2 = sub2ind(dim,yis2,xis2);

Mag1 = Mag(idxes1);
Mag2 = Mag(idxes2);
Mag0 = Mag(idxes);
idxes_gnh = idxes(Mag0>Mag1 & Mag0>Mag2 & Mag0>=uthresh);
idxes_gnl = idxes(Mag0>Mag1 & Mag0>Mag2 & Mag0<uthresh);

gnh(idxes_gnh)=1;
gnl(idxes_gnl)=1;

% --- Connectivity Analysis
[row,col]=find(gnh>0);
idxes = (col-1)*dim(1)+row;
gnl(gnh==1)=1;
gnh = imfill(gnl==0,idxes,8)-(gnl==0);

end
