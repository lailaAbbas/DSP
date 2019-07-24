%Class 1 represents Close Fingers motion
MF1_C1 =  2.3705e+06;
SF1_C1 =  9.2669e+05;

MF2_C1 =  4.6043e+10;
SF2_C1 =  5.1898e+10;

MF3_C1 =  2.0200e+04;
SF3_C1 =  4.2229e+03;

MF4_C1 =  0.0756;
SF4_C1 =  0.1874;

%Class 2 represents Double Tab motion
MF1_C2 =  8.8256e+05;
SF1_C2 =  3.4773e+05;

MF2_C2 =  3.5813e+09;
SF2_C2 =  2.9320e+09;

MF3_C2 =  6.6107e+03;
SF3_C2 =  3.6105e+03;

MF4_C2 =  0.0699;
SF4_C2 =  0.6582;

%Class 3 represents HandsUp
MF1_C3 =  7.7821e+06;
SF1_C3 =  7.9679e+06;

MF2_C3 =  5.4157e+11;
SF2_C3 =  1.0186e+12;

MF3_C3 =  6.2602e+04;
SF3_C3 =  3.6126e+04;

MF4_C3 =  0.3266;
SF4_C3 =  0.8219;

%Class 4 represents Right Rotation
MF1_C4 =  5.6172e+06;
SF1_C4 =  2.8378e+06;

MF2_C4 =  1.5818e+11;
SF2_C4 =  1.3674e+11;

MF3_C4 =  5.7032e+04;
SF3_C4 =  2.8567e+04;

MF4_C4 =  -2.2388;
SF4_C4 =  2.3220;

%load y after transpose and convolution,notch like in train
y = y';
%First filter notch at 60 HZ
F0= 60 ; Fs = 200 ; Q=35;
W0= 2*F0 /Fs;
Bw = W0 / Q;
n = 4; %degree of notch
[a,b] = iircomb(n,Bw);
y = filter(a,b,y);
YFiltered = conv(y,gausswin(60));
%Obtaining Features
F1 = sum(YFiltered.^2,2);
F2 = sum(YFiltered.^4,2);
%F3
for col = 3:1:length(YFiltered)
equation= ( - YFiltered(1 , col) * YFiltered(1 , col-2) + YFiltered(1 , col-1)^2);
F3Results(col-2) = equation ;
end
F3= sum(F3Results);
%F4
for col = 2:1:length(YFiltered)
equation = (  YFiltered(1 , col) - YFiltered(1 , col-1)) ;
F4Results(col-1) = equation ;
end
F4 = sum(F4Results);

F1_C1_T = normpdf(F1,MF1_C1,SF1_C1);
F2_C1_T = normpdf(F2,MF2_C1,SF2_C1);
F3_C1_T = normpdf(F3,MF3_C1,SF3_C1);
F4_C1_T = normpdf(F4,MF4_C1,SF4_C1);
C1_F = [0.5] * F1_C1_T * F2_C1_T*F3_C1_T*F4_C1_T;

F1_C2_T = normpdf(F1,MF1_C2,SF1_C2);
F2_C2_T = normpdf(F2,MF2_C2,SF2_C2);
F3_C2_T = normpdf(F3,MF3_C2,SF3_C2);
F4_C2_T = normpdf(F4,MF4_C2,SF4_C2);
C2_F = [0.5] * F1_C2_T * F2_C2_T*F3_C2_T*F4_C2_T;

F1_C3_T = normpdf(F1,MF1_C3,SF1_C3);
F2_C3_T = normpdf(F2,MF2_C3,SF2_C3);
F3_C3_T = normpdf(F3,MF3_C3,SF3_C3);
F4_C3_T = normpdf(F4,MF4_C3,SF4_C3);
C3_F = [0.5] * F1_C3_T * F2_C3_T*F3_C3_T*F4_C3_T;

F1_C4_T = normpdf(F1,MF1_C4,SF1_C4);
F2_C4_T = normpdf(F2,MF2_C4,SF2_C4);
F3_C4_T = normpdf(F3,MF3_C4,SF3_C4);
F4_C4_T = normpdf(F4,MF4_C4,SF4_C4);
C4_F = [0.5] * F1_C4_T * F2_C4_T*F3_C4_T*F4_C4_T;

