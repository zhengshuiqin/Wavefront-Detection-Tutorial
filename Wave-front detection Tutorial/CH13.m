clc
clear
%%
UnitsAndConstant;
DefaultSimulationParameter;
Operator;
DefaultField;
%%
Phase = 2*pi*(5/mm)*abs(var.x);
Field = (Amplitude.*exp(i*Phase));
Temp = Field;
for index = 1:1;
Temp = Propagate(10*cm/1,Temp);
Record(:,index) = Temp(512,Y_);
end
% PPP = Propagate(20*cm,Field);

subplot(1,1,1)
imagesc(abs(Record).^2)
colormap gray
return
%%
subplot(2,3,1)
imagesc((field2pic((Field(X_,Y_)))))
axis equal
axis ij
axis off

subplot(2,3,2)
imagesc((abs((Field(X_,Y_))).^2))
axis equal
axis ij
axis off

subplot(2,3,3)
imagesc((angle((Field(X_,Y_)))))
axis equal
axis ij
axis off

subplot(2,3,4)
imagesc((field2pic((Temp(X_,Y_)))))
axis equal
axis ij
axis off

subplot(2,3,5)
imagesc((abs((Temp(X_,Y_))).^2))
axis equal
axis ij
axis off

subplot(2,3,6)
imagesc(double(conv2(double(abs((Temp(X_,Y_))>0.1)),ones(50)/2500,'same')>0.1).*(angle((Temp(X_,Y_)))))
axis equal
axis ij
axis off
colormap gray