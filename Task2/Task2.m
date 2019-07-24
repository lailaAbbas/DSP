Image1 = imread('C:\Users\leelopedian\Desktop\DSP2\Apple.jpg');
Image1 = imresize(Image1,[200 200]);
Image1 = rgb2gray(Image1);
F1 = fft2(Image1);
Mag1 =abs(F1); Theta1 = angle(F1);

Image2 = imread('C:\Users\leelopedian\Desktop\DSP2\Cone.jpg');
Image2 = imresize(Image2,[200 200]);
Image2 = rgb2gray(Image2);
F2 = fft2(Image2);
Mag2 =abs(F2); Theta2 = angle(F2);

FHyprid1 = Mag1.*exp(i*Theta2);
ImHyprid1 = ifft2(FHyprid1);
ImHyprid1 = uint8(ImHyprid1);  %to change from double to uint 8 to be able to used as pixel

FHyprid2 = Mag2.*exp(i*Theta1);
ImHyprid2 = ifft2(FHyprid2);
ImHyprid2 = uint8(ImHyprid2);  %to change from double to uint 8 to be able to used as pixel

figure(1); imshow(Image1);
figure(2); imshow(Image2);
figure(3); imshow(ImHyprid1);
figure(4); imshow(ImHyprid2);
