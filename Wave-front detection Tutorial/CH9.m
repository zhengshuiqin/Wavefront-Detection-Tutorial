clc
clear
%%
UnitsAndConstant;
DefaultSimulationParameter;
Operator;
DefaultField;

%%
Calibration_Field= Amplitude;
% Field = Amplitude.*exp(i*var.theta);
% Field = Amplitude.*Lens(100*cm);
%%

Pitch = 8*px;
subFocus_length=0.3*cm;
% 
% Pitch = 12*px;
% subFocus_length=0.3*cm;
% % 
% Pitch = 24*px;
% subFocus_length=0.3*cm;


subX = 0.5*sawtooth(2*pi./Pitch*var.x).*Pitch;
subY = 0.5*sawtooth(2*pi./Pitch*var.y).*Pitch;

SH = exp(1i.*2*pi/Wavelength.*(subX.^2+subY.^2)./2./subFocus_length);

Out = Propagate(subFocus_length,Field.*SH); 
Image = Camera_nmlz(Out,BitDepth);

Out_cali = Propagate(subFocus_length,Calibration_Field.*SH); 
Image_cali = Camera_nmlz(Out_cali,BitDepth);

filter = @(x,delta_x,m)exp(-(x/delta_x).^(2*m));

AC_x = ifft2(fft2(Image).*filter(var.fx+1/Pitch,0.5/Pitch,3).*filter(var.fy,0.5/Pitch,3));
AC_y = ifft2(fft2(Image).*filter(var.fy+1/Pitch,0.5/Pitch,3).*filter(var.fx,0.5/Pitch,3));

AC_Cali_x = ifft2(fft2(Image_cali).*filter(var.fx+1/Pitch,0.5/Pitch,3).*filter(var.fy,0.5/Pitch,3));
AC_Cali_y = ifft2(fft2(Image_cali).*filter(var.fy+1/Pitch,0.5/Pitch,3).*filter(var.fx,0.5/Pitch,3));

dF_dx = double(abs(nmlz(AC_x))>0.1).*wrapToPi(angle(AC_x)-angle(AC_Cali_x))/2/pi*Pitch/subFocus_length*1/Wavelength;
dF_dy = double(abs(nmlz(AC_y))>0.1).*wrapToPi(angle(AC_y)-angle(AC_Cali_y))/2/pi*Pitch/subFocus_length*1/Wavelength;

FFT_F = (fft2(dF_dx).*var.fx+fft2(dF_dy).*var.fy).*i./(var.fx.^2+var.fy.^2);
FFT_F(1,1)=0;
F = (ifft2(FFT_F));

Rec = abs(AC_x).*exp(i*real(F));

Rec=Propagate(-subFocus_length,Rec); 

subplot(1,4,1)
pcolor(Image(X_,Y_))
axis equal
axis ij
axis off
shading interp
colormap gray

subplot(1,4,2)
imagesc(dF_dx(X_,Y_))
axis equal
axis ij
axis off


subplot(1,4,3)
imagesc(dF_dy(X_,Y_))
axis equal
axis ij
axis off


subplot(1,4,4)
imagesc(field2pic(Rec(X_,Y_)))
axis equal
axis ij
axis off