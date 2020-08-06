%% 
Wavelength = 633*nm;
px = 10*um; %pixel size
X_num = 1024;
Y_num = 1024;
BitDepth = 10; %camera bit depth

%% 
Width  = X_num*px;
Height = Y_num*px;
var = space(Width,X_num,Height,Y_num);