function s = pujian(filename,count)


% 添加含噪语音
[y, fs]=audioread(filename);
y = y(:,count);
%sound(y,fs);
noise_estimated = y(1:10*fs/1000,1);  %取前0.01秒做为噪声进行去噪

fft_y = fft(y);
fft_n = fft(noise_estimated);
E_noise = sum(abs(fft_n)) /length(noise_estimated);
mag_y = abs(fft_y);
phase_y = angle(fft_y);   % 保留相位信息
mag_s = mag_y - E_noise;
mag_s(mag_s<0)=0;
 
% 恢复
fft_s = mag_s .* exp(1i.*phase_y);
s = ifft(fft_s);
%sound(s,fs);