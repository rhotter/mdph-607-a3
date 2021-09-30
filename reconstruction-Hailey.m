%part a
plot_sinogram(dataset1)
figure;
plot_sinogram(dataset2)

%parts b,c,d
figure;
n1='dataset1';
unfiltered_backprojection(dataset1, blank_scan, mu_water, string(n1))
figure;
n2='dataset2';
unfiltered_backprojection(dataset2, blank_scan, mu_water, string(n2))

figure;
n1='dataset1';
ramp_fbp(dataset1, blank_scan, mu_water, string(n1))
figure;
n2='dataset2';
ramp_fbp(dataset2, blank_scan, mu_water, string(n2))

figure;
n1='dataset1';
hann_fbp(dataset1, blank_scan, mu_water, string(n1))
figure;
n2='dataset2';
hann_fbp(dataset2, blank_scan, mu_water, string(n2))


%part e
n1='dataset1';
plot_histogram(dataset1, dataset2, blank_scan, mu_water)



%part a: plot sinograms for the two datasets
function plot_sinogram(M)
imagesc(M)
colormap(hot)
colorbar
xlabel('Parallel Rotation Angle - \theta (degrees)'); 
ylabel('Parallel Sensor Position - x\prime (pixels)');
end


%parts b,c,d: plot the unfiltered backprojection in HU
function unfiltered_backprojection(M,N,O,P)
X = N./M; 
Y = log(X); %find m(s)
I_b = iradon(Y,0:179,'linear','none'); %inverse radon transform with no filter to recover mu
HU1=1000*(I_b-O)/O; %find HU to plot image
imagesc(HU1)%plot image
title('Part B: Unfiltered backprojection for ' + P)

figure;
Z = Y(:,1:3:end); %reduce number of projections: choose every three projections
I_c = iradon(Z,0:3:179,'linear','none');
HU2=1000*(I_c-O)/O;
imagesc(HU2)
title('Part C: Reduced Unfiltered backprojection for ' + P)

figure;
Z = Y(:,1:end/3); %reduce the range of angles to 1/3
I_d = iradon(Z,0:59,'linear','none');
HU3=1000*(I_d-O)/O;
imagesc(HU3)
title('Part D: 1/3 angle Unfiltered backprojection for ' + P)
end


%parts b,c,d: plot the ramp filtered backprojection in HU
function ramp_fbp(M,N,O,P)
X = N./M;
Y = log(X);
I = iradon(Y,0:179,'linear','Ram-lak');
HU=1000*(I-O)/O;
imagesc(HU)
title('Part B: Ramp filtered backprojection for ' + P)

figure;
Z = Y(:,1:3:end);
I_c = iradon(Z,0:3:179,'linear','Ram-Lak');
HU2=1000*(I_c-O)/O;
imagesc(HU2)
title('Part C: Reduced Ramp filtered backprojection for ' + P)

figure;
Z = Y(:,1:end/3);
I_d = iradon(Z,0:59,'linear','Ram-Lak');
HU3=1000*(I_d-O)/O;
imagesc(HU3)
title('Part D: 1/3 angle Ramp filtered backprojection for ' + P)
end


%parts b,c,d: plot the Hann filtered backprojection in HU
function hann_fbp(M,N,O,P)
X = N./M;
Y = log(X);
I = iradon(Y,0:179,'linear','Hann');
HU=1000*(I-O)/O;
imagesc(HU)
title('Part B: Hann filtered backprojection for ' + P)

figure;
Z = Y(:,1:3:end);
I_c = iradon(Z,0:3:179,'linear','Hann');
HU2=1000*(I_c-O)/O;
imagesc(HU2)
title('Part C: Reduced Hann filtered backprojection for ' + P)

figure;
Z = Y(:,1:end/3);
I_d = iradon(Z,0:59,'linear','Hann');
HU3=1000*(I_d-O)/O;
imagesc(HU3)
title('Part D: 1/3 angle Hann filtered backprojection for ' + P)
end

%part e: plot histograms of the HU values to compare dataset1 and dataset2
function plot_histogram(M1,M2,N,O)
figure;
%dataset1 m(s)
X1 = N./M1;
Y1 = log(X1);
%dataset2 m(s)
X2 = N./M2;
Y2 = log(X2);

%plot HU values with Ramp filter
I1 = iradon(Y1,0:179,'linear','Ram-Lak');
I2 = iradon(Y2,0:179,'linear','Ram-Lak');
HU1=1000*(I1-O)/O;
HU2=1000*(I2-O)/O;
histogram(HU1)
hold on;
histogram(HU2)
title('Ramp filtered histogram comparison')

%plot HU values with hann filter
figure;
I1 = iradon(Y1,0:179,'linear','Hann');
I2 = iradon(Y2,0:179,'linear','Hann');
HU1=1000*(I1-O)/O;
HU2=1000*(I2-O)/O;
histogram(HU1)
hold on;
histogram(HU2)
title('Hann filtered histogram conparison')
end
