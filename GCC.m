%% ���廥�����ʱ���ӳ�
% generalized cross correlation 
% TDOA 
clear all; clc; close all;
angle = zeros(1,14);
speed = 343;
distance = 0.1;
delta = 10;
right_ans = [   8.8000000e+01
   3.0000000e+01
   1.7600000e+02
   1.2800000e+02
   9.0000000e+01
   8.4000000e+01
   1.0000000e+01
   1.2200000e+02
   7.0000000e+00
   1.2000000e+01
   9.3000000e+01
   1.7000000e+01
   1.4700000e+02
   1.4700000e+02];
for id = 1:14
%     [Input, Fs] = audioread(['./train/',num2str(id),'.wav']);   %��ʹ�ý��뷽��
%     x1 = Input(:,1);
%     x2 = Input(:,2);
%     x1 = resample(x1, 100, 1);
%     x2 = resample(x2, 100, 1);
%     Fs = Fs*100;

%     [~, Fs] = audioread(['./train/',num2str(id),'.wav']);  %ʹ���׼�������
%     x1 = pujian(['./train/',num2str(id),'.wav'],1);
%     x2 = pujian(['./train/',num2str(id),'.wav'],2);
%     x1 = resample(x1, 100, 1);
%     x2 = resample(x2, 100, 1);
%     Fs = Fs*100;
    
    [~, Fs] = audioread(['./train/',num2str(id),'.wav']);  %ʹ�ø߼���������
    x1 = denoise(['./train/',num2str(id),'.wav'],1);
    x2 = denoise(['./train/',num2str(id),'.wav'],2);
    x1 = resample(x1, 100, 1);
    x2 = resample(x2, 100, 1);
    Fs = Fs*100;
    N = length(x1);  %����
    n = 0:N-1;
    t=n/Fs;   %ʱ������
%     subplot(211);
%     plot(t,x1,'r');
%     hold on;
%     plot(t,x2,':');
%     legend('x1�ź�', 'x2�ź�');
%     xlabel('ʱ��/s');ylabel('x1(t) x2(t)');
%     title('ԭʼ�ź�');grid on;
%     hold off
    % ����غ��� 1 
    X1=fft(x1,2*N-1);
    X2=fft(x2,2*N-1);
    Sxy=X1.*conj(X2);
    Cxy=fftshift(ifft(Sxy));
%     subplot(212);
%     t1=(0:2*N-2)/Fs;    
%     plot(t1,Cxy,'b');
%     title('����غ���');xlabel('ʱ��/s');ylabel('Rx1x2(t)');grid on
    [~,location]=max(Cxy);%������ֵmax,�����ֵ���ڵ�λ�ã��ڼ��У�location;
    d=location-N;
    Delay=d/Fs;              %���ʱ���ӳ�
    cos_angle = Delay*speed/distance;
    angle(id) = acosd(cos_angle);
    angle(id)
end
% for id = 1:14  %����
%     if(imag(angle(id))>0)
%         angle(id) = delta;
%     elseif(imag(angle(id))<0)
%         angle(id) = 180-delta;
%     end
% end
error = real(angle) - right_ans';
mean(abs(error));