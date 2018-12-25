clear
clc

%up load picture
picColor = imread('pic.png');

    %change to black&white color
pic = rgb2gray(picColor);
%pic = picColor;

    %pic size
pix1 = size(pic,1);
pix2 = size(pic,2);

    %add picture frame value to be 0
newMetrix = zeros(pix1+2,pix2+2);
newMetrix(2:pix1+1,2:pix2+1) = pic;

    %matrix operator 
%Perwitt operation 
Px = [-1 0 1; -1 0 1; -1 0 1];
Py = [-1 -1 -1; 0 0 0; 1 1 1];
%Sobel operator
Sx = [-1 0 1; -2 0 2; -1 0 1];
Sy = [-1 -2 -1; 0 0 0; 1 2 1];
%Roberts operator
R1 = [0 1; -1 0];
R2 = [-1 0; 0 1];
%Compass operator



    %find new pixel value
DPx = zeros(pix1,pix2);
DPy = zeros(pix1,pix2);
DSx = zeros(pix1,pix2);
DSy = zeros(pix1,pix2);
DR1 = zeros(pix1,pix2);
DR2 = zeros(pix1,pix2);
for u=2:pix1+1
     for v=2:pix2+1
         for x=u-1:u+1
             for y=v-1:v+1
                 DPx(u-1,v-1) = DPx(u-1,v-1)+newMetrix(x,y)*Px((x-u)+2,(y-v)+2);
                 DPy(u-1,v-1) = DPy(u-1,v-1)+newMetrix(x,y)*Py((x-u)+2,(y-v)+2);
                 DSx(u-1,v-1) = DSx(u-1,v-1)+newMetrix(x,y)*Sx((x-u)+2,(y-v)+2);
                 DSy(u-1,v-1) = DSy(u-1,v-1)+newMetrix(x,y)*Sy((x-u)+2,(y-v)+2);
             end
         end
     end 
end
DR1 = conv2(pic, R1);
DR2 = conv2(pic, R2);

DSx = uint8(DSx);
DSy = uint8(DSy);
DSx = double(DSx);
DSy = double(DSy);

%find Edge strength and Edge orientation of sobel
for u=1:pix1
    for v=1:pix2
        ES(u,v) = sqrt((DSx(u,v)^2)+(DSy(u,v)^2)); %Edge strength
        OS(u,v) = atan(DSy(u,v)/DSx(u,v)); %Edge orientation
    end
end

figure
subplot(1,3,1); imshow(pic, 'InitialMagnification', 'fit'); title('Original image')
subplot(1,3,2); imshow(DPx, 'InitialMagnification', 'fit'); title('horizontal derivative')
subplot(1,3,3); imshow(DPy, 'InitialMagnification', 'fit'); title('vertical derivative')
figure
subplot(3,2,1); imshow(pic, 'InitialMagnification', 'fit'); title('Original image')
subplot(3,2,3); imshow(DSx, 'InitialMagnification', 'fit'); title('horizontal derivative')
subplot(3,2,4); imshow(DSy, 'InitialMagnification', 'fit'); title('vertical derivative')
subplot(3,2,5); imshow(ES, 'InitialMagnification', 'fit'); title('Edge strength')
subplot(3,2,6); imshow(OS, 'InitialMagnification', 'fit'); title('Edge orientation')
figure
subplot(1,3,1); imshow(pic, 'InitialMagnification', 'fit'); title('Original image')
subplot(1,3,2); imshow(DR1, 'InitialMagnification', 'fit'); 
subplot(1,3,3); imshow(DR2, 'InitialMagnification', 'fit'); 