clc
clear
%%
UnitsAndConstant;
DefaultSimulationParameter;
Operator;
DefaultField;

%%
focus_length = 10*cm;
Fourier_Plane = Propagate(focus_length,Lens(focus_length).*Propagate(focus_length*2,Field));

D = 0.1*mm; 
zD = 0.2*mm; 
% D = 0.4*mm; 
% D = 0.8*mm; 
% D = 100*mm; 
% Q_Mask = double(var.rho>D);
QW_Mask = double(var.rho<D);
Fourier_Plane = Fourier_Plane.*exp(-i*pi/4*QW_Mask);

Field_ImagingPlane = Propagate(focus_length,Fourier_Plane);
DetectedIntensity = Camera(Field_ImagingPlane,BitDepth);

FourierPlaneIntensityLogScale = nmlz(log(abs(Fourier_Plane)));
FourierPlaneAndQW_Mask(:,:,1) = FourierPlaneIntensityLogScale;
FourierPlaneAndQW_Mask(:,:,2) = FourierPlaneIntensityLogScale;
FourierPlaneAndQW_Mask(:,:,3) = FourierPlaneIntensityLogScale+QW_Mask;

subplot(2,1,1)
imagesc(var.x_/mm,var.y_/mm,FourierPlaneAndQW_Mask)
axis equal
axis ij
axis off
shading interp
xlim([-1 1]*1)
ylim([-1 1]*1)

subplot(2,1,2)
imagesc(DetectedIntensity(X_,Y_))
axis equal
axis ij
axis off
colormap gray

