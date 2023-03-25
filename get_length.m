function[CD, CB, DB] = get_length(CD_pixels, AC_pixels)
%returns CB and DB as they are used in width calculation
%CD represents the length of the vehicle

%CD = length of vehicle in pixels
%AC = number of pixels below vehicle
%trig calculation for length of vehicle
%please see report for an explanation on how this was calculated

CAB=136.56;
CBD=CD_pixels*0.042;
ABC=AC_pixels*0.042;
ACB=180-CAB-ABC;
BCD=180-ACB;
CDB=180-CBD-BCD;

AB = (7*(tand(46.46)))/(sind(46.56));
AC = (AB/sind(ACB))*sind(ABC);
CB = (AC/sind(ABC))*sind(CAB);
DB = (CB/sind(CDB)) * sind(BCD);
CD = (DB/sind(BCD)) * sind(CBD);


