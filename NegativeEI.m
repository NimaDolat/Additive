function NegEI = NegativeEI(test, Xind, scale, bw, L, alpha, opt)
kInd = CovFunc(test', Xind, scale, bw); %this is test' because of diRect
mu = kInd*alpha;
v = L\kInd';
var = scale - v'*v; %here scale is basically k(x*,x*)
if var == 0
    ei = 0;
else
    u = (mu - opt - 0.01*var)/sqrt(var);
    ei = sqrt(var)*(u*normcdf(u)+normpdf(u));
end
NegEI = -ei;%since DIRECT gets the min
end