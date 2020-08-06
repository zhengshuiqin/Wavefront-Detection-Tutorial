

Amplitude_temp = double(rgb2gray(imread('A2.png')));
[M,N]= size(Amplitude_temp);

X0 = round((X_num-N)/2);
Y0 = round((Y_num-M)/2);
X_ = [X0:X0+N-1];
Y_ = [Y0:Y0+M-1];

Amplitude = zeros(size(var.x));
Amplitude(X_,Y_) = Amplitude_temp;
Amplitude = nmlz(conv2(Amplitude,ones(50),'same')); % softedge

Phase = zeros(size(var.x));
Phase_temp = double(rgb2gray(imread('P1.png')));

Phase(X_,Y_) = Phase_temp;
Phase = 0.2*pi*nmlz(Phase);

Field = (Amplitude.*exp(i*Phase));

Aperture = ones(size(var.x));
Aperture(X_,Y_) = 0;
Aperture = logical(Aperture);