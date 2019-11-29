clear;
clc;

distance = 0.1;
speed = 343;

fileFolder=fullfile('./train/');
dirOutput=dir(fullfile(fileFolder,'*.wav'));
files={dirOutput.name};
cos_angle = zeros(length(files),1);
angle = cos_angle;
for i = 1:length(files)
    [sound, fs] = audioread(strcat('train/',files{i}));
    sound_1 = sound(:,1);
    sound_2 = sound(:,2);
    plot(sound_2)
    
    %% 降噪方法1：积分
%     sound_left = zeros(length(sound_1),1);
%     sound_right = sound_left;
%     for count1 = 1:length(sound_1)
%         sound_left(count1)=sum(sound_1(1:count1));
%         sound_right(count1)=sum(sound_2(1:count1));
%     end

    %% 降噪方法2：OMLSA
    

    sound_left  = denoise(strcat('train/',files{i}),1);
    sound_right  = denoise(strcat('train/',files{i}),2);
    huxiangguan = xcorr(sound_left,sound_right);
    index_max_huxiangguan = find(huxiangguan == max(huxiangguan));
    delta_tau = (size(sound,1)-index_max_huxiangguan)/fs; %delta_tau: the differential time between A and B source_to_microphone
    cos_angle(i) = delta_tau*speed / distance;
    angle(i) = acosd( cos_angle(i) );
end

plot(sound_left(:))
    


