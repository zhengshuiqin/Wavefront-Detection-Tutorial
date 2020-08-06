function pic = field2pic(field)
H = (angle(field)+pi)/2/pi;
S = ones(size(field));
Max_abs = max(abs(field(:)));
V = abs(field)./Max_abs;
hsv_image(:,:,1) = H;
hsv_image(:,:,2) = S;
hsv_image(:,:,3) = V;

pic = hsv2rgb(hsv_image);