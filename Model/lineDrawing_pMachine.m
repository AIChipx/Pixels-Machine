% This script can draw Bresenham line on a RGB colored buffer
% you can control color value by changing "color" 
% input vertices must be in row vector format
% only x,y values of input vertices are used 
% line color can be customized

% Extracting (x, y) coordinates
% line drawing data
clc
% disp('Frame buffer resolution is 320x240')
% start_point = input('Start point coordinates= ');
% end_point = input('End point coordinates= ');
start_point = [1 1];
end_point = [400 400];

% line color
color = [0 1 0];

% allocating frame buffer
frame_buffer = zeros(240, 320, 3);

% Extracting (x, y) coordinates
x0 = round(start_point(1));
y0 = round(start_point(2));
x1 = round(end_point(1));
y1 = round(end_point(2));

% The algorithm
% boolean
steep = abs(y1-y0) > abs(x1-x0);
if(steep)
    [x0, y0] = swap(x0, y0);
    [x1, y1] = swap(x1, y1);
end
if(x0 > x1) 
    [x0, x1] = swap(x0, x1);
    [y0, y1] = swap(y0, y1);
end

deltax = x1 - x0;
deltay = abs(y1 - y0);
error = deltax / 2;
y = y0;

if(y0<y1)
    ystep = 1;
else
    ystep = -1;
end

for x=x0:x1
    if(steep)
        frame_buffer(x, y, 1) = color(1);
        frame_buffer(x, y, 2) = color(2);
        frame_buffer(x, y, 3) = color(3);
    else
        frame_buffer(y, x, 1) = color(1);
        frame_buffer(y, x, 2) = color(2);
        frame_buffer(y, x, 3) = color(3);
    end
    
    error = error - deltay;
    if(error < 0)
        y = y + ystep;
        error = error + deltax;
    end
end

figure(351)
imshow(frame_buffer)

