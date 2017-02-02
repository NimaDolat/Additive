function NegUCB = NegativeUCB(test, Xind, scale, bw, L, alpha, iexp)
kInd = CovFunc(test', Xind, scale, bw); %this is test' because of diRect
mu = kInd*alpha;
v = L\kInd';
var = scale - v'*v; %here scale is basically k(x*,x*)
coeffBeta = 0.2*size(Xind,2)*log(2*iexp);
UCB = mu + coeffBeta*sqrt(var);
NegUCB = -UCB;%since DIRECT gets the min
end