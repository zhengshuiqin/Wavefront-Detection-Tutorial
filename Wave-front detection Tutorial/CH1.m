clc
clear
%%
UnitsAndConstant;
%%
px = 10*um; %pixel size

X_num = 512;
Y_num = 512;

Width  = X_num*px;
Height = Y_num*px;

var = space(Width,X_num,Height,Y_num);
%%
Amplitude = double(rgb2gray(imread('A0.png')));
Amplitude = nmlz(Amplitude);
Phase = double(rgb2gray(imread('P0.png')));
Phase = 0.2*pi*nmlz(Phase);
Field = Amplitude.*exp(i*Phase);

DetectedIntensity = round((2^12-1)*nmlz(abs(Field).^2));

subplot(2,2,1)
imagesc(Amplitude)
axis equal
title('Amplitude');
subplot(2,2,2)
imagesc(Phase)
axis equal
title('Phase');
subplot(2,2,3)
imagesc(field2pic(Field))
title('Field');
axis equal
subplot(2,2,4)
imagesc(DetectedIntensity)
axis equal
title('Detected intensity');
colormap gray