function [DATA, reg, Scale, BW] = FixedPartitionPolicy(funcEI, funcMu, boundPara, noise2, oneExtExp, updateIteration, realOpt, BestPartition, FinalMaxPartSize, InitScale, InitBW, InitDATA, Func)
X = InitDATA(:,1:(end-1));
dim = size(X,2);
T = InitDATA(:,end);     
GrandOpt = max(T);
optVec = [];
numUpdate = floor(oneExtExp/updateIteration);
scale = InitScale;
bw = InitBW;
Scale = NaN(1,numUpdate);
BW = NaN(1,numUpdate);
%output should be a cell with each partition memebers id
for iexp = 1:oneExtExp
    if mod(iexp,updateIteration)==0
        nuFunc = @(parm) negLogMarginalLikelihood(T, X, BestPartition, dim, parm, noise2);
        funcML = struct('f', nuFunc);
        [~, parVals] = Direct(funcML, boundPara);
        scale = parVals(1);
        bw = parVals(2);
        abal = iexp/updateIteration;
        Scale(abal) = scale;
        BW(abal) =  bw;
    end
    %we get the following 3 statement from the MML process above
    xNext = NaN(1, dim);
    xRegret = NaN(1, dim);
    kAll = combindedKernel(X, BestPartition, FinalMaxPartSize, scale, bw);
    nObservations = size(X,1);
    noisykAll = kAll + diag(noise2*ones(nObservations,1));
    L = chol(noisykAll, 'lower');
    alpha = L'\(L\T);
    FinalNumPart = ceil(size(BestPartition,2)/FinalMaxPartSize);
    for partIteration = 1:FinalNumPart
        id = BestPartition((partIteration-1)*FinalMaxPartSize+1:min(partIteration*FinalMaxPartSize,dim));
        Xind = X(:,id);
        if strcmp(Func,'Griewank')
            boundsInd = repmat([-5, 5], size(id,2), 1); %carful with size(id,1)
        elseif strcmp(Func,'Ackley')
            boundsInd = repmat([-3, 3], size(id,2), 1); %carful with size(id,1)
        elseif strcmp(Func,'Styblinkski')
            boundsInd = repmat([-5, 5], size(id,2), 1); %carful with size(id,1)
        elseif strcmp(Func,'Hartmann6')
            boundsInd = repmat([0, 1], size(id,2), 1); %carful with size(id,1)
        end
        [~, xatminIdEI] = Direct(funcEI, boundsInd, [], Xind, scale, bw, L, alpha, GrandOpt);
        [~, xatminIdMu] = Direct(funcMu, boundsInd, [], Xind, scale, bw, alpha);
        xNext(id) = xatminIdEI';
        xRegret(id) = xatminIdMu';
    end
    if strcmp(Func,'Griewank')
        yNew = normrnd(Griewank2(xNext), sqrt(noise2));
        if yNew > GrandOpt
            GrandOpt = yNew;
        end
        yB = Griewank2(xRegret);
        optVec = [optVec, max([optVec, yB])];
        X = [X; xNext];
        T = [T; yNew];
    elseif strcmp(Func,'Ackley')
        yNew = normrnd(NegRescaledAckley(xNext), sqrt(noise2));
        if yNew > GrandOpt
            GrandOpt = yNew;
        end
        yB = NegRescaledAckley(xRegret);
        optVec = [optVec, max([optVec, yB])];
        X = [X; xNext];
        T = [T; yNew];
    elseif strcmp(Func,'Styblinkski')
        yNew = normrnd(NegScaledStybinski(xNext), sqrt(noise2));
        if yNew > GrandOpt
            GrandOpt = yNew;
        end
        yB = NegScaledStybinski(xRegret);
        optVec = [optVec, max([optVec, yB])];
        X = [X; xNext];
        T = [T; yNew];
    elseif strcmp(Func,'Hartmann6')
        yNew = normrnd(NegHart6(xNext), sqrt(noise2));
        if yNew > GrandOpt
            GrandOpt = yNew;
        end
        yB = NegHart6(xRegret);
        optVec = [optVec, max([optVec, yB])];
        X = [X; xNext];
        T = [T; yNew];
    end    
end
reg = realOpt - optVec;
DATA = [X,T];
end

