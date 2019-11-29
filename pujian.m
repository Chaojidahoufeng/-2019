function s = pujian(filename,count)


% ��Ӻ�������
[y, fs]=audioread(filename);
y = y(:,count);
%sound(y,fs);
noise_estimated = y(1:10*fs/1000,1);  %ȡǰ0.01����Ϊ��������ȥ��

fft_y = fft(y);
fft_n = fft(noise_estimated);
E_noise = sum(abs(fft_n)) /length(noise_estimated);
mag_y = abs(fft_y);
phase_y = angle(fft_y);   % ������λ��Ϣ
mag_s = mag_y - E_noise;
mag_s(mag_s<0)=0;
 
% �ָ�
fft_s = mag_s .* exp(1i.*phase_y);
s = ifft(fft_s);
%sound(s,fs);