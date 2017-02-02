function NegEI = NegativeCombinedEI(test, X, BestPartition, FinalMaxPartSize, scale, bw, L, alpha, GrandOpt)
dimcomb = size(BestPartition,2);
FinalNumPart = ceil(size(BestPartition,2)/FinalMaxPartSize);
muC = 0;
vC = 0;
for combMuiteration = 1:FinalNumPart
    idcombMu = BestPartition((combMuiteration-1)*FinalMaxPartSize+1:min(combMuiteration*FinalMaxPartSize,dimcomb));
%     id = partsId{combKiteration};
    XindcombMu = X(:,idcombMu);
    combinedK = CovFunc(test(idcombMu)', XindcombMu, scale, bw);
    muC = muC + combinedK*alpha;
    v = L\combinedK';
    vC = vC + scale - v'*v; %here scale is basically k(x*,x*)
end
vC = vC + noise2*eye(size(vC,1));
if vC == 0
    ei = 0;
else
    u = (muC - GrandOpt - 0.01*vC)/sqrt(vC);
    ei = sqrt(vC)*(u*normcdf(u)+normpdf(u));
end
NegEI = -ei;%since DIRECT gets the min
end