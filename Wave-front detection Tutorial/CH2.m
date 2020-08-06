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
PlaneWavefront = 2*pi*((2/mm)*var.x+(1/mm)*var.y);
subplot(2,2,1)
imagesc(field2pic(exp(i*PlaneWavefront)))
axis equal
axis off
SphericalWavefront = (2*pi/(633*nm))/(1*m)*(var.x.^2+var.y.^2);
subplot(2,2,2)
imagesc(field2pic(exp(i*SphericalWavefront)))
axis equal
axis off
CylindricalWavefront = (2*pi/(633*nm))/(1*m)*(var.x.^2);
subplot(2,2,3)
imagesc(field2pic(exp(i*CylindricalWavefront)))
axis equal
axis off
Helicalphase = 2*var.theta;
subplot(2,2,4)
imagesc(field2pic(exp(i*Helicalphase)))
axis equal
axis off
% imwrite(field2pic(exp(i*PlaneWavefront)),'PlaneWavefront.bmp');
% imwrite(field2pic(exp(i*SphericalWavefront)),'SphericalWavefront.bmp');
% imwrite(field2pic(exp(i*CylindricalWavefront)),'CylindricalWavefront.bmp');
% imwrite(field2pic(exp(i*Helicalphase)),'Helicalphase.bmp');