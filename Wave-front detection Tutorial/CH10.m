clc
clear
%%
UnitsAndConstant;
DefaultSimulationParameter;
Operator;
DefaultField;

%%
Calibration_Field= Amplitude;

%%
T = 8;
DDD = 0.1*cm;

T = 8*2;
DDD = 0.1*cm*2;

T = 8*4;
DDD = 0.1*cm*4;

% T = 8;
% % DDD = 0.03*cm;
% DDD = 1.6*cm;
% DDD = 1*cm;

Modulater_x = double((0.5/T+0.5+0.5*sawtooth(2*pi*(1:X_num)./T))>0.5);
Modulater_x = repmat(Modulater_x(:),[1 Y_num]);
Modulater_y = double((0.5/T+0.5+0.5*sawtooth(2*pi*(1:Y_num)./T))>0.5);
Modulater_y = repmat(Modulater_y(:)',[X_num 1]);
Modulater_phase= mod(Modulater_x+Modulater_y,2);

Modulation = exp(i*Modulater_phase*pi*1.0);

Out = Propagate(DDD,Field.*Modulation);
Image = Camera_nmlz(Out,BitDepth);

Out_cali = Propagate(DDD,Calibration_Field.*Modulation);
Image_Cali = Camera_nmlz(Out_cali,BitDepth);

px = Width/X_num;
f0 = 1/(T*px);

filter = @(x,delta_x,m)exp(-(x/delta_x).^(2*m));
Pitch = T*px;

AC_x = ifft2(fft2(Image).*filter(var.fx+2/Pitch,1/Pitch,3).*filter(var.fy,1/Pitch,3));
AC_y = ifft2(fft2(Image).*filter(var.fy+2/Pitch,1/Pitch,3).*filter(var.fx,1/Pitch,3));

AC_x_Cali = ifft2(fft2(Image_Cali).*filter(var.fx+2/Pitch,1/Pitch,3).*filter(var.fy,1/Pitch,3));
AC_y_Cali = ifft2(fft2(Image_Cali).*filter(var.fy+2/Pitch,1/Pitch,3).*filter(var.fx,1/Pitch,3));

Dis = f0*Wavelength*DDD;

dF_dx = double(abs(nmlz(AC_x))>0.1).*wrapToPi(angle(AC_x)-angle(AC_x_Cali))/2/pi*Pitch/DDD*1/Wavelength/pi;
dF_dy = double(abs(nmlz(AC_y))>0.1).*wrapToPi(angle(AC_y)-angle(AC_y_Cali))/2/pi*Pitch/DDD*1/Wavelength/pi;
FFT_F = (fft2(dF_dx).*var.fx+fft2(dF_dy).*var.fy).*i./(var.fx.^2+var.fy.^2);
FFT_F(1,1)=0;
F = (ifft2(FFT_F));

Rec = abs(AC_x).*exp(i*real(F));
Rec = Propagate(-DDD,Rec);

subplot(1,4,1)
imagesc(Image(256:255+512,256:255+512))
axis equal
axis ij
axis off

subplot(1,4,2)
imagesc(dF_dx(256:255+512,256:255+512));
axis equal
axis ij
axis off

subplot(1,4,3)
imagesc(dF_dy(256:255+512,256:255+512));
axis equal
axis ij
axis off

subplot(1,4,4)
imagesc((field2pic((Rec(256:255+512,256:255+512)))))
axis equal
axis ij
axis off

colormap gray