function NegMuInd = NegIndGPmean(test, Xind, scale, bw, alpha)
kInd = CovFunc(test', Xind, scale, bw); %this is test' because of diRect
mu = kInd*alpha;
NegMuInd = -mu; %this is because deRect minimizes
end