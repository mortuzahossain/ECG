clc; clear; close all; warning off all;

main_image = imread('p1.png');
RGB = imcrop(main_image);
close all;

I = RGB;

channel1Min = 0.000;
channel1Max = 221.000;

channel2Min = 0.000;
channel2Max = 255.000;

channel3Min = 0.000;
channel3Max = 216.000;

sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

maskedRGBImage = RGB;
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
bw4 = bwareaopen(BW,0);
figure, imshow(RGB);

imbwaa=flip(bw4 ,1);
[ k ] = thinning( imbwaa );

ld=0.0483;
target1R = 0 ;
matches1 = k == target1R ;
[x1, y1] = find(matches1);
 
DATA =[y1, x1];
sementara = unique(DATA,'rows');

lsementara = length(sementara);
jj = 1;

for ii = 1 : lsementara
    if ii > 1
        if sementara(ii, 1) == sementara(ii - 1, 1)
            continue
        end
    end
    if ii < lsementara
        if sementara(ii, 1) == sementara(ii + 1, 1)
            sementara2(jj,1) = sementara(ii, 1);
            sementara2(jj,2) = max(sementara(ii, 2),sementara(ii + 1, 2));
        else
            sementara2(jj, 1) = sementara(ii, 1);
            sementara2(jj, 2) = sementara(ii, 2);
        end
    else
            sementara2(jj, 1) = sementara(ii, 1);
            sementara2(jj, 2) = sementara(ii, 2);
    end
    jj = jj + 1;
end

data=sementara2(:,2);
data=(data)*ld;
maksim=max(data);
minim=min(data);
media=median((data));
data=data-media;
TG=maksim-minim;
fs=23;
%fs=1%400;%figure(3)
figure, plot([0:length(data)-1]/fs,data);
grid on
PJ=length(data)/fs;
xlabel('Periode (mm)');
ylabel('Amplitude (mm)');
datacursormode on 

csvwrite('data/p2/V6.dat',data);


