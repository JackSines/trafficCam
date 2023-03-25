function[width] = get_width(bb, CB, DB)
%img_bb format =[x,y,width,length]
%img width = 480

x = bb(1);
width = bb(3);
x2 = x + width;
image_midpoint_x = 240;
theta1 = 0.042 * (x2 - image_midpoint_x); %from mid point to right of bb
adj = CB;
opp = (tand(theta1))*adj;

%do this again for left half
theta2 = 0.042 * (image_midpoint_x-x);
opp2 = (tand(theta2))*adj;

width_bottom = opp + opp2;

%completing the same calculations for the top of the bounding box
adj_top = DB;
opp_top = tand(theta1)*adj_top;
opp2_top = tand(theta2)*adj_top;
width_top = opp_top+opp2_top;

%using an average of the 2 to get width for centre of vehicle
width = (width_bottom+width_top)/2;
