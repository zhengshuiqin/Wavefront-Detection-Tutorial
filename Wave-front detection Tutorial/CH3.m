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

R0 = 2.5*mm;
n=2;
index = 1;
for m=-2 :2:2
Zernike_Phase = nan(size(var.x));
Zernike_Phase(var.rho<R0) = zernfun(n,m,var.rho(var.rho<R0)/R0,var.theta(var.rho<R0));
subplot(2,3,index)
imagesc(Zernike_Phase)
index = index+1;
colormap jet
axis equal 
axis off
end

n=3;
index = 1;
for m=-3 :2:3
Zernike_Phase = nan(size(var.x));
Zernike_Phase(var.rho<R0) = zernfun(n,m,var.rho(var.rho<R0)/R0,var.theta(var.rho<R0));
subplot(2,4,4+index)
imagesc(Zernike_Phase)
index = index+1;
colormap jet
axis equal 
axis off
end