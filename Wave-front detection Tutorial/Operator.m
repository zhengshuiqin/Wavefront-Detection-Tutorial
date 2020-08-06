kz = 2*pi*sqrt((1/Wavelength).^2-(var.fx).^2-(var.fy).^2);
Propagate  =@(dis,field) fft2(exp(-i*(kz-2*pi./Wavelength).*dis).*ifft2(field)); 
Lens =@(focus_length) exp(1i.*2*pi/Wavelength.*(var.x.^2+var.y.^2)./2./focus_length);
Camera_nmlz = @(Field,BitDepth) round((2^BitDepth-1)*nmlz(abs(Field).^2))./(2^BitDepth-1);
Camera = @(Field,BitDepth) round((2^(BitDepth-1))*abs(Field).^2)./(2^BitDepth-1);