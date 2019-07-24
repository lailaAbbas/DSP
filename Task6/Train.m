load('TrainCloseFingers.mat')
load('TrainDoubleTab.mat')
load('TrainHandsUp.mat')
load('TrainRightRotation.mat')

TrainCloseFingers = TrainCloseFingers';
TrainDoubleTab = TrainDoubleTab';
TrainHandsUp = TrainHandsUp';
TrainRightRotation = TrainRightRotation';

CloseFingersFiltered = ones (6,(718+59));
DoubleTabFiltered = ones (6,(752+59));
HandsUpFiltered = ones (6,(880+59));
RightRotationFiltered = ones (6,(888+59));

%First filter notch at 60 HZ
F0= 60 ; Fs = 200 ; Q=35;
W0= 2*F0 /Fs;
Bw = W0 / Q;
n = 4; %degree of notch
[a,b] = iircomb(n,Bw);
TrainCloseFingers = filter(a,b,TrainCloseFingers);
TrainDoubleTab = filter(a,b,TrainDoubleTab);
TrainHandsUp = filter(a,b,TrainHandsUp);
TrainRightRotation = filter(a,b,TrainRightRotation);

%Apply Gauss for Smoothing
for i = 1:1:6
CloseFingersFiltered(i,:) = conv(TrainCloseFingers(i,:),gausswin(60));
DoubleTabFiltered(i,:) = conv(gausswin(60),TrainDoubleTab(i,:));
HandsUpFiltered(i,:) = conv(gausswin(60),TrainHandsUp(i,:));
RightRotationFiltered(i,:) = conv(gausswin(60),TrainRightRotation(i,:));
end

%F1 represent energy, M represent mean, S represent standard deviation
%F1_C1 given class, C1 represents CloseFingers
F1_C1 = sum(CloseFingersFiltered.^2,2);
MF1_C1 = mean(F1_C1) %mean = sum of column cells/n
SF1_C1 = std(F1_C1) %std =root( sum(x-mean)^2/(n-1))

%F2_C1
%Second feature fourth power
F2_C1 = sum(CloseFingersFiltered.^4,2);
MF2_C1 = mean(F2_C1)
SF2_C1 = std(F2_C1)


%F3_C1
%feature 3 represents Non linear energy ---sum (-x(i)x(i-2)+x(i-1)^2))
row_length= size(CloseFingersFiltered , 1);
coloumn_length= size(CloseFingersFiltered , 2) ;
for row = 1:row_length
for col = 3:coloumn_length
equation= ( - CloseFingersFiltered(row , col) * CloseFingersFiltered(row , col-2) + CloseFingersFiltered(row , col-1)^2) ;
C1_results(col-2) = equation ;
end
Nonlinear_Energy_C1(row)= sum(C1_results);
end
F3_C1 = Nonlinear_Energy_C1';
MF3_C1 = mean(F3_C1)
SF3_C1 = std(F3_C1)
%F4_C1
%F4 represents curve length sum(x(i)-x(i-1))
row_length = size(CloseFingersFiltered , 1);
coloumn_length = size(CloseFingersFiltered , 2) ;
for row = 1:row_length
for col = 2:coloumn_length
equation = (  CloseFingersFiltered(row , col) - CloseFingersFiltered(row , col-1)) ;
C1_results(col-1) = equation ;
end
curve_length_C1(row) = sum(C1_results);
end
F4_C1 = curve_length_C1';
MF4_C1 = mean(F4_C1)
SF4_C1 = std(F4_C1)

%C2 represents DoubleTab
%F1_C2 given class
F1_C2 = sum(DoubleTabFiltered.^2,2);
MF1_C2 = mean(F1_C2) %mean = sum of column cells/n
SF1_C2 = std(F1_C2) %std =root( sum(x-mean)^2/(n-1))

%F2_C2
F2_C2 = sum(DoubleTabFiltered.^4,2);
MF2_C2 = mean(F2_C2)
SF2_C2 = std(F2_C2)

%F3_C2
row_length= size(DoubleTabFiltered , 1);
coloumn_length= size(DoubleTabFiltered , 2) ;
for row = 1:row_length
for col = 3:coloumn_length
equation= ( -DoubleTabFiltered(row , col) * DoubleTabFiltered(row , col-2) + DoubleTabFiltered(row , col-1)^2) ;
C2_results(col-2) = equation ;
end
Nonlinear_Energy_C2(row)= sum(C2_results);
end
F3_C2 = Nonlinear_Energy_C2';
MF3_C2 = mean(F3_C2)
SF3_C2 = std(F3_C2)
%F4_C2
row_length = size(DoubleTabFiltered , 1);
coloumn_length = size(DoubleTabFiltered , 2) ;
for row = 1:row_length
for col = 2:coloumn_length
equation = ( DoubleTabFiltered(row , col) - DoubleTabFiltered(row , col-1)) ;
C2_results(col-1) = equation ;
end
curve_length_C2(row) = sum(C2_results);
end
F4_C2 = curve_length_C2';
MF4_C2 = mean(F4_C2)
SF4_C2 = std(F4_C2)

%C3 represents HandsUP
%F1 represent energy, M represent mean, S represent standard deviation
%F1_C3 given class
F1_C3 = sum(HandsUpFiltered.^2,2);
MF1_C3 = mean(F1_C3) %mean = sum of column cells/n
SF1_C3 = std(F1_C3) %std =root( sum(x-mean)^2/(n-1))

%F2_C3
F2_C3 = sum(HandsUpFiltered.^4,2);
MF2_C3 = mean(F2_C3)
SF2_C3 = std(F2_C3)

%F3_C3
row_length= size(HandsUpFiltered , 1);
coloumn_length= size(HandsUpFiltered , 2) ;
for row = 1:row_length
for col = 3:coloumn_length
equation= ( - HandsUpFiltered(row , col) *HandsUpFiltered(row , col-2) + HandsUpFiltered(row , col-1)^2) ;
C3_results(col-2) = equation ;
end
Nonlinear_Energy_C3(row)= sum(C3_results);
end
F3_C3 = Nonlinear_Energy_C3';
MF3_C3 = mean(F3_C3)
SF3_C3 = std(F3_C3)
%F4_C3
row_length = size(HandsUpFiltered , 1);
coloumn_length = size(HandsUpFiltered , 2) ;
for row = 1:row_length
for col = 2:coloumn_length
equation = ( HandsUpFiltered(row , col) - HandsUpFiltered(row , col-1)) ;
C3_results(col-1) = equation ;
end
curve_length_C3(row) = sum(C3_results);
end
F4_C3 = curve_length_C3';
MF4_C3 = mean(F4_C3)
SF4_C3 = std(F4_C3)

%F1 represent energy, M represent mean, S represent standard deviation
%F1_C4 given class, C4 represents RightRotation
F1_C4 = sum(RightRotationFiltered.^2,2);
MF1_C4 = mean(F1_C4) %mean = sum of column cells/n
SF1_C4 = std(F1_C4) %std =root( sum(x-mean)^2/(n-1))

%F2_C4
F2_C4 = sum(RightRotationFiltered.^4,2);
MF2_C4 = mean(F2_C4)
SF2_C4 = std(F2_C4)

%F3_C4
row_length= size(RightRotationFiltered , 1);
coloumn_length= size(RightRotationFiltered , 2) ;
for row = 1:row_length
for col = 3:coloumn_length
equation= ( - RightRotationFiltered(row , col) *RightRotationFiltered(row , col-2) + RightRotationFiltered(row , col-1)^2) ;
C4_results(col-2) = equation ;
end
Nonlinear_Energy_C4(row)= sum(C4_results);
end
F3_C4 = Nonlinear_Energy_C4';
MF3_C4 = mean(F3_C4)
SF3_C4 = std(F3_C4)
%F4_C4
row_length = size(RightRotationFiltered , 1);
coloumn_length = size(RightRotationFiltered , 2) ;
for row = 1:row_length
for col = 2:coloumn_length
equation = ( RightRotationFiltered(row , col) - RightRotationFiltered(row , col-1)) ;
C4_results(col-1) = equation ;
end
curve_length_C4(row) = sum(C4_results);
end
F4_C4 = curve_length_C4';
MF4_C4 = mean(F4_C4)
SF4_C4 = std(F4_C4)