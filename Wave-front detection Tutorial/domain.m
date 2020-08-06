function [t,ft]=domain(window,sample);
%���������ռ�
% [t,ft]=domain(window,sample);
% ����
% window   -   �ռ�/ʱ�䴰��
% sample    -   ��������Ŀ
%
% ���
% t         -   �ռ�/ʱ�����
% ft        -   �ռ�Ƶ��/ʱ��Ƶ�ʱ���

if(sample <= 1)
    t =  0;
    ft = 0;
else
    if mod(sample,2)==1
        error(['sample should be even number '])
    else
        t = linspace(-window/2,window/2,sample+1);
        t(end) = [];
%         t = fftshift(t);
        ft =[0:(sample/2-1) -sample/2:-1]/window;  
    end
end