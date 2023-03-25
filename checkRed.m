function[isRed] = checkRed(img, boundingBox) %BoundingBox as an input at some point

img_cropped=imcrop(img, boundingBox); %crops image to bounding box

%the below isolates the RGB channels of the image
red=img_cropped(:,:,1);
green=img_cropped(:,:,2);
blue=img_cropped(:,:,3);
figure, imshow(red)
title("Red");
figure, imshow(green)
title("Green");
figure, imshow(blue)
title("Blue");

%calculate mean values for RGB channels
meanRGB=[mean2(red), mean2(green), mean2(blue)];

%from sample images, the colour R channel should be > 200, green < 60, blue
%< 50
isRed = 0;
if (meanRGB(1) >= 200) && (meanRGB(2) < 60) && (meanRGB(3) < 50)
    isRed = 1;
else
end



%if the largest mean value belongs to the red channel, the object is likely
%red

%if max(meanRGB)==meanRGB(1)
%    isRed=1;
%else
%end




