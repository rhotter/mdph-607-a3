function image_hu = to_HU(image, mu_water)
% convert to Hounsfield units
image_hu = 1000*(image - mu_water)/mu_water;
end

