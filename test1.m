% Clear All Veriable
clc; clear; close all; warning off all;

%% Read Image And Crope IT
main_image = imread('p1.png');
RGB = imcrop(main_image);
close all;
%%
I = RGB;

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.000;
channel1Max = 221.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.000;
channel2Max = 255.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.000;
channel3Max = 216.000;

% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;


%%
bw4 = bwareaopen(BW,0);
figure, imshow(RGB);
%%
imbwaa=flip(bw4 ,1); %# vertical flip 
[ k ] = thinning( imbwaa );
%%
ld=0.0483;%dengan mm 600dpi
target1R = 0 ;
matches1 = k == target1R ;
[x1, y1] = find(matches1);
 
DATA =[y1, x1];
sementara = unique(DATA,'rows');

lsementara = length(sementara);
jj = 1;

%%
