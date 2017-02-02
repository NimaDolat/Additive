function [Xs, yVal] = samplingNormal(sampleSize, Xind, boundsInd, L, alpha, scale, bw, noise2)
enough = true;
while enough
    Xs = repmat(boundsInd(:,1)', sampleSize*2, 1) + rand(sampleSize*2,size(boundsInd,1))*diag(boundsInd(:, 2) - boundsInd(:, 1));
    Xs = unique(Xs,'rows');
    if size(Xs,1) > sampleSize
        enough = false;
    end    
end
Xs = Xs(1:sampleSize,:);
IndK = CovFunc(Xs, Xind, scale, bw)';
sampMu = IndK'*alpha;
sampV = L\IndK;
sampK = CovFunc(Xs, Xs, scale, bw) - sampV'*sampV + noise2*eye(size(sampV,2));
sampL = chol(sampK, 'lower');
sampU = normrnd(0, ones(sampleSize,1));
yVal = sampMu + sampL*sampU;
end
