%Vehicle detection

function[boundingBox, centroid] = object_detection(img)

%segmenting using k-means clustering
img_lab=rgb2lab(img); %convert to lab colourspace
ab=img_lab(:,:,2:3); %array indexing
ab=im2single(ab); %convert to single class
colours=2; %how many colours we're looking for

%imsegkmeans takes the image and number of colours to segment
labels=imsegkmeans(ab, colours);
mask=labels==1;

figure, imshow(labels, [])
title("Segmented");

%inverse colours
mask=~mask;
figure, imshow(mask)
title("Inverse mask");

%some filtering before labelling
se = strel('disk', 20);
mask_close=imclose(mask, se);

mask_fill=imfill(mask_close, 'holes');
figure, imshow(mask_fill)
title("After connecting close pixels and filling");

%label image
[L]=bwlabel(mask_fill, 4);
rgb=label2rgb(L);
figure,imshow(rgb)
title('Label');
%find largest
largest=bwareafilt(mask_fill, 1);
stats=regionprops(largest, 'BoundingBox', 'Centroid');
centroid=stats.Centroid;


%draw bounding box on original image
figure, imshow(img);
hold on;
rectangle('Position', stats.BoundingBox, 'EdgeColor', 'r');


boundingBox = stats.BoundingBox;


