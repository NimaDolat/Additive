function [DATA, reg, Scale, BW] = Full(funcEI, funcMu, boundPara, noise2, oneExtExp, updateIteration, realOpt, InitScale, InitBW, InitDATA, FuncName)
X = InitDATA(:,1:(end-1));
dim = size(X,2);
T = InitDATA(:,end);     
GrandOpt = max(T);
optVec = [];
numUpdate = floor(oneExtExp/updateIteration);
partition = cell(1,1);
partition{1} = 1:dim;
scale = InitScale;
bw = InitBW;
Scale = NaN(1,numUpdate);
BW = NaN(1,numUpdate);
%output should be a cell with each partition memebers id
for iexp = 1:oneExtExp
    if mod(iexp,updateIteration)==0
        nuFunc = @(parm) negLogMarginalLikelihood(T, X, partition, parm, noise2);
        funcML = struct('f', nuFunc);
        [~, parVals] = Direct(funcML, boundPara);
        scale = parVals(1);
        bw = parVals(2);
        abal = iexp/updateIteration;
        Scale(abal) = scale;
        BW(abal) =  bw;
    end
    %we get the following 3 statement from the MML process above
    kAll = combindedKernel(X, partition, scale, bw);
    nObservations = size(X,1);
    noisykAll = kAll + diag(noise2*ones(nObservations,1));
    L = chol(noisykAll, 'lower');
    alpha = L'\(L\T);
    if strcmp(FuncName,'Rastrigin')
        boundsInd = repmat([-3, 4], dim, 1); %carful with size(id,1)
    elseif strcmp(FuncName,'Ackley')
        boundsInd = repmat([-4, 5], dim, 1); %carful with size(id,1)
    elseif strcmp(FuncName,'Styblinkski')
        boundsInd = repmat([-5, 5], dim, 1); %carful with size(id,1)
    elseif strcmp(FuncName,'Powell')
        boundsInd = repmat([-0.5, 1], dim, 1); %carful with size(id,1)
    end
    [~, xatminIdEI] = Direct(funcEI, boundsInd, [], X, scale, bw, L, alpha, GrandOpt);
    [~, xatminIdMu] = Direct(funcMu, boundsInd, [], X, scale, bw, alpha);
    xNext = xatminIdEI';
    xRegret = xatminIdMu';
    if strcmp(FuncName,'Rastrigin')
        yNew = normrnd(NegRast(xNext), sqrt(noise2));
        if yNew > GrandOpt
            GrandOpt = yNew;
        end
        yB = NegRast(xRegret);
        optVec = [optVec, max([optVec, yB])];
        X = [X; xNext];
        T = [T; yNew];
    elseif strcmp(FuncName,'Ackley')
        yNew = normrnd(NegAckley12(xNext), sqrt(noise2));
        if yNew > GrandOpt
            GrandOpt = yNew;
        end
        yB = NegAckley12(xRegret);
        optVec = [optVec, max([optVec, yB])];
        X = [X; xNext];
        T = [T; yNew];
    elseif strcmp(FuncName,'Styblinkski')
        yNew = normrnd(NegScaledStybinski(xNext), sqrt(noise2));
        if yNew > GrandOpt
            GrandOpt = yNew;
        end
        yB = NegScaledStybinski(xRegret);
        optVec = [optVec, max([optVec, yB])];
        X = [X; xNext];
        T = [T; yNew];
    elseif strcmp(FuncName,'Powell')
        yNew = normrnd(NegPowell(xNext), sqrt(noise2));
        if yNew > GrandOpt
            GrandOpt = yNew;
        end
        yB = NegPowell(xRegret);
        optVec = [optVec, max([optVec, yB])];
        X = [X; xNext];
        T = [T; yNew];
    end    
end
reg = realOpt - optVec;
DATA = [X,T];
end

