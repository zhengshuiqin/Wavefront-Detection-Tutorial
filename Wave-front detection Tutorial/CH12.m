clc
clear
%%
UnitsAndConstant;
DefaultSimulationParameter;
Operator;
DefaultField;

DDD = 0.1*cm;
Out0 = Propagate(0*cm,Field);
Out1 = Propagate(0*cm+DDD,Field);


I0 = Camera(Out0,BitDepth);
I0(Aperture)=0;
I1 = Camera(Out1,BitDepth);
I1(Aperture)=0;
F_rec = sqrt(I0);
index = 0;

subplot(3,1,1)
imagesc(I0(X_,Y_))
axis equal
axis ij
axis off
shading interp
colormap gray

subplot(3,1,2)
imagesc(I1(X_,Y_))
axis equal
axis ij
axis off
shading interp
colormap gray

while(index<50)
    
F_rec = sqrt(I0).*exp(i*angle(F_rec));
F_temp = Propagate(DDD,F_rec);
F_temp = sqrt(I1).*exp(i*angle(F_temp));
F_rec = Propagate(-DDD,F_temp);

F_answer = Propagate(-0*cm,F_rec);

subplot(3,1,3)
imagesc(field2pic(F_answer(X_,Y_)))
axis equal
axis ij
axis off
drawnow
index = index+1
end
%%
subplot(3,1,1)
imagesc(I0(X_,Y_))
axis equal
axis ij
axis off
shading interp
colormap gray

subplot(3,1,2)
imagesc(I1(X_,Y_))
axis equal
axis ij
axis off
shading interp
colormap gray
subplot(3,1,3)
imagesc(field2pic(F_answer(X_,Y_)))
axis equal
axis ij
axis off
drawnow

%% ¼ÓÎó²îÇúÏß

return
subplot(1,4,1)
imagesc(Phase(X_,Y_))
axis equal
axis ij
axis off
shading interp
colormap gray

subplot(1,4,2)
imagesc(I0(X_,Y_))
axis equal
axis ij
axis off
shading interp
colormap gray

subplot(1,4,3)
imagesc(I1(X_,Y_))
axis equal
axis ij
axis off
shading interp
colormap gray

subplot(1,4,4)
imagesc(real(P(X_,Y_)))
axis equal
axis ij
axis off
shading interp
colormap gray