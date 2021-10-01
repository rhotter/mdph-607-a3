% MDPH 607
% Assignment 3
% Wen Da Lu

%loading data
load("C:\Users\wenda\Desktop\School\2021 Fall\MDPH 607\mdph607_projection_data_v2.mat")

%Question 1.a
figure(1)
subplot(2,1,1)
image(data1)
subplot(2,1,2)
image(dataset2)

%Question 1.b
data1 = log(blank_scan./dataset1);

I1_lami = iradon(data1, 0:179, 'none');
I1_ramp = iradon(data1, 0:179, 'Ram-Lak');
I1_hann = iradon(data1, 0:179, 'Hann');

I1_lami_HU = 1000*(I1_lami-mu_water)/mu_water;
I1_ramp_HU = 1000*(I1_ramp-mu_water)/mu_water;
I1_hann_HU = 1000*(I1_hann-mu_water)/mu_water;

figure(2)
subplot(1,3,1)
imshow(I1_lami_HU,[])
title('Laminogram')
subplot(1,3,2)
imshow(I1_ramp_HU,[])
title('FBP + ramp filter')
subplot(1,3,3)
imshow(I1_hann_HU,[])
title('FBP + Hann filter')

% In the case of the ramp filter, it seems to be sharper than the Hann
% filter, which is normal, due to the low-pass effect of the Hann filter.
% In the Shepp-Logan phatom, it would seem that the ramp filter would
% perform better.

%Question 1.c
I_reduced_lami = iradon(data1(:,1:3:180), 0:3:179, 'none');
I1_reduced_ramp = iradon(data1(:,1:3:180), 0:3:179, 'Ram-Lak');
I1_reduced_hann = iradon(data1(:,1:3:180), 0:3:179, 'Hann');

figure(3)
subplot(1,3,1)
imshow(I_reduced_lami,[])
title('Laminogram')
subplot(1,3,2)
imshow(I1_reduced_ramp,[])
title('FBP + ramp filter')
subplot(1,3,3)
imshow(I1_reduced_hann,[])
title('FBP + Hann filter')

%Question 1.d
I_third_lami = iradon(data1(:,1:60), 0:59, 'none');
I1_third_ramp = iradon(data1(:,1:60), 0:59, 'Ram-Lak');
I1_third_hann = iradon(data1(:,1:60), 0:59, 'Hann');

figure(4)
subplot(1,3,1)
imshow(I_reduced_lami,[])
title('Laminogram')
subplot(1,3,2)
imshow(I1_reduced_ramp,[])
title('FBP + ramp filter')
subplot(1,3,3)
imshow(I1_reduced_hann,[])
title('FBP + Hann filter')

%Question 1.e
data2 = log(blank_scan./dataset2);

I2_ramp = iradon(data2, 0:179, 'Ram-Lak');
I2_hann = iradon(data2, 0:179, 'Hann');

I2_ramp_HU = 1000*(I2_ramp-mu_water)/mu_water;
I2_hann_HU = 1000*(I2_hann-mu_water)/mu_water;

figure(5)
subplot(1,2,1)
imshow(I2_ramp_HU,[])
title('FBP + ramp filter')
subplot(1,2,2)
imshow(I2_hann_HU,[])
title('FBP + Hann filter')

figure(6)
subplot(2,1,1)
histogram(I1_ramp_HU)
title('Dataset 1 with FBP + ramp filter')
subplot(2,1,2)
histogram(I2_ramp_HU)
title('Dataset 2 with FBP + ramp filter')

figure(7)
subplot(2,1,1)
histogram(I1_hann_HU)
title('Dataset 1 with FBP + Hann filter')
subplot(2,1,2)
histogram(I2_hann_HU)
title('Dataset 2 with FBP + Hann filter')

%Dataset 2 seems to have much more noise present that dataset 1. This is
%very apparent when comparing figure 2 and figure 5. When looking at the
%histogram, the ramp filter has a single distribution, whereas the Hann
%filter has two distribution on dataset 2, one would be for the background 
%and the other would be for Shepp-Logan structure. The ramp filter 
%therefore does not discrimate the noise as easily as the Hann filter.

