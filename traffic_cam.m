
function traffic_cam(img, img1)

figure, imshow(img)
title("First image"); %load and show image 1

figure, imshow(img1)
title("Second image"); %load and show image 2

img=imgaussfilt(img);
img1=imgaussfilt(img1);

%detect object and get bounding box
[img_bb, img_c] =object_detection(img); %img_bb format =[x,y,width,length]
[img1_bb, img1_c] =object_detection(img1);

%Get length of object

%   img_length requires the size of the object(pixels) and the number of
%   pixels between the object and the bottom of the frame

%   CD (the number of pixels below the object) can be calculated from the
%   image height (640 pixels). 
%   the bottom of the bounding box is img_bb(2) + img_bb(4)
%   so we do 640 - this

[img_length, CB, DB] =get_length(img_bb(4), 640-(img_bb(2) + img_bb(4)));

[img1_length, CB1, DB1]=get_length(img1_bb(4), 640-(img1_bb(2) + img1_bb(4)));


length_avg=(img_length + img1_length)/2; %average length between images


%Check if object is red
is_red =checkRed(img, img_bb);

%Calculate object width
img_width = get_width(img_bb, CB, DB);

img1_width = get_width(img1_bb, CB1, DB1);

width_avg = (img_width+img1_width)/2; 

if width_avg >= 2.5
    is_oversized=1;
else
    is_oversized=0;
end


%Width to length ratio using the 2 averages
img_ratio_avg=width_avg/length_avg;

%Speed
%   need to pass get_length distance travelled (pixels) and the height of
%   centroid in first image

%   distance between the 2 centroids
distance_pixels=abs(diff([img_c(2), img1_c(2)]));

%   height of centroid for first image
img_c_height=640-img_c(2);

%   this now finds the distance travelled in meters
[distance_m, ~, ~] =get_length(distance_pixels, img_c_height);

%   find speed in meters per second (distance/time)
speed_mps=distance_m/0.1;
%   multiply this by 2.23694 (1m/s=2.23694mph)
speed_mph=speed_mps*2.23694;

%speeding?
%   here we set a variable for speed limit so it can be changed if needed
speed_limit_mph=30;

if speed_mph>speed_limit_mph
    is_speeding=1;
else
    is_speeding=0;
end


%output

fprintf('\nCar width: %.2f m', width_avg);
fprintf('\nCar length: %.2f m', length_avg);
fprintf("\nCar width/length ratio: %.2f", img_ratio_avg);

if is_red == 1
    fprintf("\nCar colour: Is the car red? (Y/N) : Y");
else
    fprintf("\nCar colour: Is the car red? (Y/N): N");
end

fprintf('\nCar speed: %.2f MPH', speed_mph);

if is_speeding == 1
    fprintf("\nCar is speeding? (Y/N) : Y");
else
    fprintf("\nCar is speeding? (Y/N) : N");
end

if is_oversized == 1
    fprintf("\nCar is oversized? (Y/N) : Y");
else
    fprintf("\nCar is oversized? (Y/N) : N");
end

exempt = 0;
if is_red==1 && ((0.22 <= img_ratio_avg) && (img_ratio_avg <= 0.38)) %roughly 1:3
    fprintf("\nCar is fire engine? (Y/N) : Y\n");
    fprintf("\nVehicle is exempt from speeding");
    exempt = 1;
else
    fprintf("\nCar is fire engine? (Y/N) : N\n");
end

if (exempt == 0) && ((is_oversized == 1 || is_speeding ==1))
    fprintf("\nVehicle should be stopped");



else
    fprintf("\nNo issues found");
end
