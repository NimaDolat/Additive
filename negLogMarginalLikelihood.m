function neglogML = negLogMarginalLikelihood(T, X, partition, parm, noise2)
    scaleneglogML = parm(1);
    bwneglogML = parm(2);
    kAllneglogML = combindedKernel(X, partition, scaleneglogML, bwneglogML);
    nObservationsneglogML = size(X,1);
    noisykAll = kAllneglogML + diag(noise2*ones(nObservationsneglogML,1));
    LneglogML = chol(noisykAll, 'lower');
    alphaneglogML = LneglogML'\(LneglogML\T); 
    neglogML = 0.5*T'*alphaneglogML + sum(log(diag(LneglogML)));
end