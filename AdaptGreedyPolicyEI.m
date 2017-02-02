function [DATA, reg, NumPartitionComponent, Scale, BW] = AdaptGreedyPolicyEI(funcMu, boundPara, noise2, oneExtExp, updateIteration, realOpt, InitScale, InitBW, InitDATA, FuncName)
X = InitDATA(:,1:(end-1));
dim = size(X,2);
T = InitDATA(:,end);     
GrandOpt = max(T);
optVec = [];
numUpdate = floor(oneExtExp/updateIteration);
Scale = NaN(1,numUpdate);
BW = NaN(1,numUpdate);
NumPartitionComponent = NaN(1,numUpdate);
partition = cell(1,dim);
for parID = 1:dim
    partition{parID} = parID;
end
scale = InitScale;
bw = InitBW;
%output should be a cell with each partition memebers id
for iexp = 1:oneExtExp
    if mod(iexp,updateIteration)==0
        partition = cell(1,dim);
        for parID = 1:dim
            partition{parID} = parID;
        end
        nuFunc = @(parm) negLogMarginalLikelihood(T, X, partition, parm, noise2);
        funcML = struct('f', nuFunc);
        [BestMMLS, parVals] = Direct(funcML, boundPara);
        scale = parVals(1);
        bw = parVals(2);
        partSize = dim;
        while partSize > 1
            totalScenarios = nchoosek(partSize,2);
            mlVals = NaN(1,totalScenarios);
            parVals = NaN(2,totalScenarios);
            allCombos = nchoosek(1:partSize,2);
            enumPartSize = 1:partSize;
            listAllScen = 1:totalScenarios;
            for mlID = listAllScen
                NewPartition = cell(1 , partSize-1);
                NewPartition{1} = [partition{allCombos(mlID,1)}, partition{allCombos(mlID,2)}];
                leftover = enumPartSize(~ismember(enumPartSize,allCombos(mlID,:)));
                restID = 2;
                for left = leftover
                    NewPartition{restID} = partition{left};
                    restID = restID + 1;
                end
                nuFunc = @(parm) negLogMarginalLikelihood(T, X, NewPartition, parm, noise2);
                funcML = struct('f', nuFunc);
                [mlVals(mlID), parVals(:,mlID)] = Direct(funcML, boundPara);
            end
            if min(mlVals) > BestMMLS
                break
            else
                bID = datasample(listAllScen(mlVals == min(mlVals)),1);
                BestMMLS = mlVals(bID);
                NewPartition = cell(1 , partSize-1);
                NewPartition{1} = [partition{allCombos(bID,1)}, partition{allCombos(bID,2)}];
                leftover = enumPartSize(~ismember(enumPartSize,allCombos(bID,:)));
                restID = 2;
                for left = leftover
                    NewPartition{restID} = partition{left};
                    restID = restID + 1;
                end
                partition = NewPartition;
                scale = parVals(1,bID);
                bw = parVals(2,bID);
                partSize = size(partition,2);
            end        
        end
        abal = iexp/updateIteration;
        Scale(abal) = scale;
        BW(abal) =  bw;
        NumPartitionComponent(abal) = partSize;
    end
    %we get the following 3 statement from the MML process above
    xNext = NaN(1, dim);
    xRegret = NaN(1, dim);
    kAll = combindedKernel(X, partition, scale, bw);
    nObservations = size(X,1);
    noisykAll = kAll + diag(noise2*ones(nObservations,1));
    L = chol(noisykAll, 'lower');
    alpha = L'\(L\T);
    numParts = size(partition, 2);
    for partIteration = 1:numParts
        Xind = X(:,partition{partIteration});
        if strcmp(FuncName,'Griewank')
            boundsInd = repmat([-5, 5], size(partition{partIteration},2), 1); %carful with size(id,1)
        elseif strcmp(FuncName,'Ackley')
            boundsInd = repmat([-3, 3], size(partition{partIteration},2), 1); %carful with size(id,1)
        elseif strcmp(FuncName,'Styblinkski')
            boundsInd = repmat([-5, 5], size(partition{partIteration},2), 1); %carful with size(id,1)
        elseif strcmp(FuncName,'Hartmann6')
            boundsInd = repmat([0, 1], size(partition{partIteration},2), 1); %carful with size(id,1)
        end
        
        %should figure out the best observed for each component
        kInd = CovFunc(Xind, Xind, scale, bw); %this is test' because of diRect
        opt = max(kInd*alpha);      

        NegEIfunc = @(test) NegativeEI(test, Xind, scale, bw, L, alpha, opt);
        funcEI = struct('f', NegEIfunc);
        [~, xatminIdEI] = Direct(funcEI, boundsInd);
        
        [~, xatminIdMu] = Direct(funcMu, boundsInd, [], Xind, scale, bw, alpha);
        xNext(partition{partIteration}) = xatminIdEI';
        xRegret(partition{partIteration}) = xatminIdMu';
    end
    if strcmp(FuncName,'Griewank')
        yNew = normrnd(Griewank2(xNext), sqrt(noise2));
        if yNew > GrandOpt
            GrandOpt = yNew;
        end
        yB = Griewank2(xRegret);
        optVec = [optVec, max([optVec, yB])];
        X = [X; xNext];
        T = [T; yNew];
    elseif strcmp(FuncName,'Ackley')
        yNew = normrnd(NegRescaledAckley(xNext), sqrt(noise2));
        if yNew > GrandOpt
            GrandOpt = yNew;
        end
        yB = NegRescaledAckley(xRegret);
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
    elseif strcmp(FuncName,'Hartmann6')
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