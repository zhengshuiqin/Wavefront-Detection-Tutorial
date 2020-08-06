clc
clear
%%
UnitsAndConstant;
DefaultSimulationParameter;
Operator;
DefaultField;

Field = exp(i.*Phase);

%%
DDD = 10*cm; %1*mm
Out0 = Field;
Out1 = Propagate(DDD,Field);

% BitDepth = 12;
I0 = Camera(Out0,BitDepth);
I1 = Camera(Out1,BitDepth);

I = (I0+I1)/2;
dI_dz = (I1-I0)/DDD;
D2 = -((2*pi*var.fx).^2+(2*pi*var.fy).^2);
invD2 = -1./((2*pi*var.fx).^2+(2*pi*var.fy).^2);
invD2(1,1)=0;
Px = ifft2(i*2*pi*var.fx.*invD2.*fft2(dI_dz))./(I);
Py = ifft2(i*2*pi*var.fy.*invD2.*fft2(dI_dz))./(I);

P = ifft2(2*pi/Wavelength.*invD2.*(i*2*pi*var.fx.*fft2(Px)+i*2*pi*var.fy.*fft2(Py)));

% P = angle(Propagate(exp(i*P),DDD/2));

subplot(2,1,1)
imshow(I1(256:255+512,256:255+512)/max(I1(:)))
axis equal
axis ij
axis off
shading interp
colormap gray

subplot(2,1,2)
imagesc(real(P(256:255+512,256:255+512))/pi)
axis equal
axis ij
axis off
shading interp
colormap gray