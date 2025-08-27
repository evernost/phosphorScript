close all
clear all
clc



% -----------------------------------------------------------------------------
% SETTINGS
% -----------------------------------------------------------------------------
fs = 48000;
fCarrier = 440;
duration = 10.0;
amp = 1.0;

nPts = round(duration*fs);
t = (0:(nPts-1))'/fs;

s = amp*[sin(2*pi*fCarrier*t), sin(2*pi*fCarrier*t)];
audiowrite('calibration.wav', s, fs)

s = amp*[sin(2*pi*fCarrier*t), 0.5*sin(2*pi*fCarrier*t)];
audiowrite('calibration_LR.wav', s, fs)


