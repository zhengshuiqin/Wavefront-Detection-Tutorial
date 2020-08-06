clc
clear
%%
UnitsAndConstant;
DefaultSimulationParameter;
Operator;
DefaultField;

%%
dis = 0*cm;
Field_Rec = Propagate(dis,Field);
Field_Cali = Propagate(dis,double(~Aperture));

Alfa = 0.125*deg/2;
Field_Ref = exp(i*2*pi/Wavelength*sin(Alfa).*var.x);
N = 4;

Image_Cali =Camera(0.5*(Field_Cali+Field_Ref),BitDepth);
Image_Cali(Aperture)=0;

Image =Camera(0.5*(Field_Rec+Field_Ref),BitDepth);
Image(Aperture)=0;

filter = @(x,delta_x,m)exp(-(x/delta_x).^(2*m));

AC = ifft2(fft2(Image).*filter(var.fx+1/Wavelength*sin(Alfa),1/Wavelength*sin(Alfa)*0.5,3));
AC_Cali = ifft2(fft2(Image_Cali).*filter(var.fx+1/Wavelength*sin(Alfa),1/Wavelength*sin(Alfa)*0.5,3));

MeasureField = abs(AC).*exp(i*(angle(AC)-angle(AC_Cali)));

RecField = Propagate(-dis,MeasureField);

subplot(3,1,1)
imshow(Image(X_,Y_));
axis equal
axis ij
axis off
colormap gray

subplot(3,1,2)
imshow(field2pic(MeasureField(X_,Y_)));

subplot(3,1,3)
imshow(field2pic(RecField(X_,Y_)));