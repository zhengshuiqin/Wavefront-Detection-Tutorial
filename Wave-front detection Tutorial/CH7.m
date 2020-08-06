clc
clear
%%
UnitsAndConstant;
DefaultSimulationParameter;
Operator;
DefaultField;

%%
dis = 100*cm;
Field_Rec = Propagate(dis,Field);
Field_Ref = Propagate(dis,1*ones(size(Field)));
N = 4;

Image1 =Camera(0.5*(Field_Rec+Field_Ref*exp(i*2*pi*0/N)),BitDepth);
Image2 =Camera(0.5*(Field_Rec+Field_Ref*exp(i*2*pi*1/N)),BitDepth);
Image3 =Camera(0.5*(Field_Rec+Field_Ref*exp(i*2*pi*2/N)),BitDepth);
Image4 =Camera(0.5*(Field_Rec+Field_Ref*exp(i*2*pi*3/N)),BitDepth);

Image1(Aperture)=0;
Image2(Aperture)=0;
Image3(Aperture)=0;
Image4(Aperture)=0;

AC = Image1*exp(i*2*pi*0/N)+Image2*exp(i*2*pi*1/N)+Image3*exp(i*2*pi*2/N)+Image4*exp(i*2*pi*3/N);
AC_F = AC(X_,Y_);

RecField = Propagate(-dis,AC);
Rec= RecField(X_,Y_);

subplot(1,6,1)
imshow(Image1(X_,Y_));
axis equal
axis ij
axis off

subplot(1,6,2)
imshow(Image2(X_,Y_));
axis equal
axis ij
axis off

subplot(1,6,3)
imshow(Image3(X_,Y_));
axis equal
axis ij
axis off

subplot(1,6,4)
imshow(Image4(X_,Y_));
axis equal
axis ij
axis off


subplot(1,6,5)
imshow(field2pic(AC_F));

subplot(1,6,6)
imshow(field2pic(Rec));