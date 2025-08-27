close all
clear all
clc


% -----------------------------------------------------------------------------
% SETTINGS
% -----------------------------------------------------------------------------
param.fs = 48000;
param.fCarrier = 1000;
param.lineTime = 0.005;
param.jumpTime = 0.0005;
param.interpMode = 'lin';



% -----------------------------------------------------------------------------
% MAIN SCRIPT
% -----------------------------------------------------------------------------
shape = {};

shape{end+1} = struct('instr', 'point',  'x', -0.2, 'y',  0.8);
shape{end+1} = struct('instr', 'point',  'x', -0.1, 'y', -0.8);
shape{end+1} = struct('instr', 'point',  'x', -0.3, 'y', -0.8);
shape{end+1} = struct('instr', 'point',  'x', -0.2, 'y',  0.8);
shape{end+1} = struct('instr', 'jumpTo', 'x',  0.2, 'y', -0.8);
shape{end+1} = struct('instr', 'point',  'x',  0.2, 'y',  0.8);
shape{end+1} = struct('instr', 'point',  'x',  0.4, 'y',  0.8);
shape{end+1} = struct('instr', 'point',  'x',  0.4, 'y', -0.8);
shape{end+1} = struct('instr', 'point',  'x',  0.2, 'y', -0.8);

output = [];
for i = 1:numel(shape)
  if (i == 1)
    x = shape{i}.x;
    y = shape{i}.y;
  else
    
    if strcmp(shape{i}.instr, 'point')
      [lineSignal_x, lineSignal_y] = lineVector(x, shape{i}.x, y, shape{i}.y, param);
      output = [output; [lineSignal_x, lineSignal_y]];
      
      x = shape{i}.x;
      y = shape{i}.y;
    elseif strcmp(shape{i}.instr, 'jumpTo')
      param2 = param;
      param2.lineTime = param.jumpTime;
      [lineSignal_x, lineSignal_y] = lineVector(x, shape{i}.x, y, shape{i}.y, param2);
      output = [output; [lineSignal_x, lineSignal_y]];
        
      x = shape{i}.x;
      y = shape{i}.y;
    end
  end
end

plot(output(:,1), output(:,2))
xlim([-1.2 1.2])
ylim([-1.2 1.2])
grid on

nPts = length(output(:,1));
t = (0:(nPts-1))'/param.fs;

fprintf('[INFO] Signal duration (1 cycle): %0.2fs\n', nPts/param.fs);

subplot(2,1,1)
plot(output(:,1), output(:,2))

subplot(2,1,2)
plot(t,output)
ylim([-1.2 1.2])
legend('x channel', 'y channel')
xlabel('Time (s)')



y = repmat(output, 100, 1);
audiowrite('output.wav', y, param.fs)
