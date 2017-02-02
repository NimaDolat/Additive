function [DATA, reg, partitionSizes, Scale, BW] = RandomNextPointPolicy(funcMu, boundPara, noise2, oneExtExp, updateIteration, realOpt, InitScale, InitBW, InitDATA, Func)
X = InitDATA(:,1:(end-1));
dim = size(X,2);
all = 1:dim;
T = InitDATA(:,end);     
GrandOpt = max(T);
optVec = [];
numUpdate = floor(oneExtExp/updateIteration);
scale = InitScale;
bw = InitBW;
Scale = NaN(1,numUpdate);
BW = NaN(1,numUpdate);
partitionSizes = NaN(1,numUpdate);
BestPartition = all;
FinalMaxPartSize = 1;
%output should be a cell with each partition memebers id
for iexp = 1:oneExtExp
    if mod(iexp,updateIteration)==0
        BestMMLS = inf;
        for maxPartSize = 1:dim
            NumPart = ceil(dim/maxPartSize);
            leftover = all;
            %figuring out all possible partitions
            if (maxPartSize == 1) || (NumPart == 1)
                AllScenarios = leftover;
            else
                B = all(2:end);
                biggerMatrix = combnk(B,(maxPartSize-1));
                biggerMatrix = [repmat(all(1),size(biggerMatrix,1),1),biggerMatrix];
                for partID = 2:NumPart
                    numScenario = size(biggerMatrix,1);
                    AllScenarios = [];
                    for scenID = 1: numScenario                        
                        leftover = all(~ismember(all, biggerMatrix(scenID,:)));
                        if size(leftover,2) > maxPartSize
                            B = leftover(leftover~=min(leftover));
                            matrixAnnex = combnk(B,(maxPartSize-1));
                            matrixAnnex = [repmat(min(leftover),size(matrixAnnex,1),1),matrixAnnex];
                        else
                            matrixAnnex = leftover;
                        end
                        newChunk = [repmat(biggerMatrix(scenID,:),size(matrixAnnex,1),1),matrixAnnex];
                        AllScenarios = [AllScenarios; newChunk];
                    end
                    biggerMatrix = AllScenarios;
                end
            end
            %finding the scenario with the highets MML
            mlVals = NaN(1,size(AllScenarios,1));
            parVals = NaN(2,size(AllScenarios,1)); %2 is the size of parm i.e. scale and bw
            totalScenarios = size(AllScenarios,1);
            for mlID = 1:totalScenarios
                partsId = AllScenarios(mlID,:);
                nuFunc = @(parm) negLogMarginalLikelihood(T, X, partsId, maxPartSize, parm, noise2);
                funcML = struct('f', nuFunc);
                [mlVals(mlID), parVals(:,mlID)] = Direct(funcML, boundPara);
            end
            if min(mlVals) > BestMMLS
                break
            else
                [BestMMLS, bID] = min(mlVals);
                BestPartition = AllScenarios(bID,:);
                FinalMaxPartSize = maxPartSize;
                scale = parVals(1,bID);
                bw = parVals(2,bID);
            end
        end
        abal = iexp/updateIteration;
        Scale(abal) = scale;
        BW(abal) =  bw;
        partitionSizes(abal) = FinalMaxPartSize;
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
        [~, xatminIdMu] = Direct(funcMu, boundsInd, [], Xind, scale, bw, alpha);
        xNext(id) = (boundsInd(:,1)+(boundsInd(:,2)-boundsInd(:,1)).*rand(size(id,2),1))';
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