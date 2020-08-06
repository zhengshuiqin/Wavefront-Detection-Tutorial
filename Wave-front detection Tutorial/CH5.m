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

D = -0.4*mm; 
% D = -0.2*mm; 
% D = -0.0*mm; 
% D = 0.2*mm; 
% D = 0.4*mm; 

Fourier_Plane(var.x<D)=0;
% Fourier_Plane(var.y<D)=0;

Field_ImagingPlane = Propagate(focus_length,Fourier_Plane);

DetectedIntensity = Camera(Field_ImagingPlane,BitDepth);

FourierPlaneIntensityLogScale = (log(abs(Fourier_Plane)));

subplot(2,1,1)
imagesc(var.x_/mm,var.y_/mm,FourierPlaneIntensityLogScale)
axis equal
axis ij
axis off
xlim([-1 1]*1)
ylim([-1 1]*1)

subplot(2,1,2)
imagesc(DetectedIntensity(X_,Y_))
axis equal
axis ij
axis off
colormap gray

