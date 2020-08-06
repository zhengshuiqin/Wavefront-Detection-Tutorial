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

d = 5*mm;
Field_plane1 = Propagate(focus_length-2*d,Fourier_Plane);
Field_plane2 = Propagate(focus_length-1*d,Fourier_Plane);
Field_plane3 = Propagate(focus_length-0*d,Fourier_Plane);
Field_plane4 = Propagate(focus_length+1*d,Fourier_Plane);
Field_plane5 = Propagate(focus_length+2*d,Fourier_Plane);

DetectedIntensity1 = Camera(Field_plane1,BitDepth);
DetectedIntensity2 = Camera(Field_plane2,BitDepth);
DetectedIntensity3 = Camera(Field_plane3,BitDepth);
DetectedIntensity4 = Camera(Field_plane4,BitDepth);
DetectedIntensity5 = Camera(Field_plane5,BitDepth);

subplot(1,5,1)
imshow(DetectedIntensity1(X_,Y_))
axis equal
axis ij
axis off

subplot(1,5,2)
imshow(DetectedIntensity2(X_,Y_))
axis equal
axis ij
axis off

subplot(1,5,3)
imshow(DetectedIntensity3(X_,Y_))
axis equal
axis ij
axis off

subplot(1,5,4)
imshow(DetectedIntensity4(X_,Y_))
axis equal
axis ij
axis off

subplot(1,5,5)
imshow(DetectedIntensity5(X_,Y_))
axis equal
axis ij
axis off

%%
PPP = zeros(512,600);
for index = 1:600
    dis = (index-300)/300*d*3+focus_length;
    K = Propagate(dis,Fourier_Plane);
    I = (abs((K(512,:)).^2));
    PPP(:,index)=I(Y_);
    index
end


