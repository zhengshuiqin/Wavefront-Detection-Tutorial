function I1= nmlz(I0,varargin)
% ��һ��
% I1= nmlz(I0,'key1',value1,'key2',value2,...)
% ����
% I0    -   ����
% key   -   �� (�ַ���)����ȡ'min' �� 'max'
% value -   ֵ
%
% ���
% I2    -   ��һ�����

mn = 0; % default min
mx = 1; % default max

for index_var =1:2:length(varargin)
    key = varargin{index_var};
    switch key
        case 'min'
            mn = varargin{index_var+1};
        case 'max'
            mx = varargin{index_var+1};
        otherwise
            error(['undefine key : ',key])
    end
end
Imax = max(I0(:));
Imin = min(I0(:));
I1 = (I0-Imin)./(Imax-Imin).*(mx-mn)+mn;