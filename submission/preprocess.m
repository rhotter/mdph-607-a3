function data = preprocess(dataset)
% turn intensity values to m values which are linear in mu
data = log(dataset(1,1) ./ dataset);
end
