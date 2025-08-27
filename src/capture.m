close all
clear all
clc

img = imread('../img/ref_v2.png');
hImg = imshow(img);

param.size_x = size(img, 2);
param.size_y = size(img, 1);

setappdata(hImg, 'last_x', -1);
setappdata(hImg, 'last_y', -1);


% Create left/right click callbacks
set(hImg, 'ButtonDownFcn', @(src, event) myClick(src, event, hImg, param));

function myClick(src, event, hImg, param)
    
    cp = get(gca, 'CurrentPoint');
    x = cp(1,1); y = cp(1,2);
    
    % Normalise the image coordinates to -1.0 ... 1.0
    u = x/param.size_x; 
    px = -1*(1-u) + u;
    v = y/param.size_y; 
    py = -1*v + (1-v);

    fprintf('shape{end+1} = struct(''instr'', ''point'',  ''x'', %0.3f, ''y'', %0.3f);\n', px, py);
    
    hold on
    plot(x, y, 'ro', 'MarkerSize', 5, 'LineWidth', 2);
    
    if (getappdata(hImg, 'last_x') >= 0)
      line([getappdata(hImg, 'last_x'), x], [getappdata(hImg, 'last_y'), y], 'LineWidth', 2, 'Color', 'black');
    end
    %fprintf('LAST: %0.1f\n', getappdata(hImg, 'last_x'));
    setappdata(hImg, 'last_x', x);
    setappdata(hImg, 'last_y', y);
end
