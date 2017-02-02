function combinedK = combindedKernel(X, partition, scale, bw)
NumPart = size(partition, 2);
nObservations = size(X,1);
combinedK = zeros(nObservations,nObservations);
for idcombK = 1:NumPart
    XindcombK = X(:, partition{idcombK});
    combinedK = combinedK + CovFunc(XindcombK, XindcombK, scale, bw);
end
end