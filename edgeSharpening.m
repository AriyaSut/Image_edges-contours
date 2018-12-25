clear
clc

%up load picture
picColor = imread('pic.png');

    %change to black&white color
pic = rgb2gray(picColor);

    %pic size
pix1 = size(pic,1);
pix2 = size(pic,2);

%% Laplace filter
L = [0 1 0; 1 -4 1; 0 1 0];
W = 0.5; %weight factor >0

edgeL = conv2(pic, L); %filtered image
edgeL = uint8(edgeL);
edgeL = double(edgeL);

pic = double(pic);

ShL = pic-W*edgeL(2:pix1+1,2:pix2+1); %sharpening
ShL = uint8(ShL);

%% Unsharp masking
H = [0 1 0; 1 1 1; 0 1 0]; %smoothing filter
a = 0.3 %weight factor 0.2<a<4
Hi = conv2(pic, H);
Hi = uint8(Hi);
Hi = double(Hi);
M = pic-Hi(2:pix1+1,2:pix2+1);
im = pic+a*M;

im = uint8(im);
pic = uint8(pic);
subplot(1,3,1); imshow(pic, 'InitialMagnification', 'fit'); title('Original image')
subplot(1,3,2); imshow(ShL, 'InitialMagnification', 'fit'); title('Laplace filter sharpening')
subplot(1,3,3); imshow(im, 'InitialMagnification', 'fit'); title('Unsharp masking')