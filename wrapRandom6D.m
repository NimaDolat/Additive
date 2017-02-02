%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Ackley6D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
funcMu = struct('f', 'NegIndGPmean');

boundPara = [0,5;0,2]; %repmat([0, 1], 2, 1); 2 is the size of parm i.e. scale and bw
noise2 = 0.000001; %noise level
numExp = 60;
oneExtExp = numExp + 1; %this is because the first round gives you the regret before we choose any points
nsim = 50;
updateIteration = 5;
nObs = 20; %initial observations
InitScale = 1; %sigf2 = 1;
InitBW = 0.25;

realOpt= 10; %Ackley
% realOpt= 8.9104; %Styblinkski
% realOpt = 3.32237; %Hartmann6

numUpdate = floor(oneExtExp/updateIteration);
Allscales = NaN(nsim, numUpdate);
Allbws = NaN(nsim, numUpdate);
Allreg=NaN(nsim,oneExtExp);
AllDATA = cell(nsim,1);


load NegAckleyInitDATA
AllinitDATA = NegAckleyInitDATA;
% load NegStybtangInitDATA
% AllinitDATA = NegStybtangInitDATA;
% load NegHartInitDATA
% AllinitDATA = NegHartInitDATA;

address = 'Z:\phase 2\5. Greedy\Data';
FuncName = 'Ackley';
% FuncName = 'Styblinkski';
% FuncName = 'Hartmann6';

parfor iSim = 1:nsim
    InitDATA = AllinitDATA(((iSim-1)*nObs+1):(iSim*nObs),:);
    [DATA, reg, Scale, BW] = RandomSelection6D(funcMu, boundPara, noise2, oneExtExp, updateIteration, realOpt, InitScale, InitBW, InitDATA, FuncName);
    Allscales(iSim,:) = Scale;
    Allbws(iSim,:) = BW;
    AllDATA{iSim}= DATA;
    Allreg(iSim,:) = reg;
end
filename = ['Rand6D', FuncName, 'UpFreq', sprintf('%d',updateIteration), '.mat'];
finalName = fullfile(address, filename);
save(finalName,'Allscales', 'Allbws', 'AllDATA', 'Allreg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Styblinkski6D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc
funcMu = struct('f', 'NegIndGPmean');

boundPara = [0,5;0,2]; %repmat([0, 1], 2, 1); 2 is the size of parm i.e. scale and bw
noise2 = 0.000001; %noise level
numExp = 60;
oneExtExp = numExp + 1; %this is because the first round gives you the regret before we choose any points
nsim = 50;
updateIteration = 5;
nObs = 20; %initial observations
InitScale = 1; %sigf2 = 1;
InitBW = 0.25;

realOpt= 8.9104; %Styblinkski
% realOpt = 3.32237; %Hartmann6

numUpdate = floor(oneExtExp/updateIteration);
Allscales = NaN(nsim, numUpdate);
Allbws = NaN(nsim, numUpdate);
Allreg=NaN(nsim,oneExtExp);
AllDATA = cell(nsim,1);


load NegStybtangInitDATA
AllinitDATA = NegStybtangInitDATA;
% load NegHartInitDATA
% AllinitDATA = NegHartInitDATA;

address = 'Z:\phase 2\5. Greedy\Data';
FuncName = 'Styblinkski';
% FuncName = 'Hartmann6';
parfor iSim = 1:nsim
    InitDATA = AllinitDATA(((iSim-1)*nObs+1):(iSim*nObs),:);
    [DATA, reg, Scale, BW] = RandomSelection6D(funcMu, boundPara, noise2, oneExtExp, updateIteration, realOpt, InitScale, InitBW, InitDATA, FuncName);
    Allscales(iSim,:) = Scale;
    Allbws(iSim,:) = BW;
    AllDATA{iSim}= DATA;
    Allreg(iSim,:) = reg;
end
filename = ['Rand6D', FuncName, 'UpFreq', sprintf('%d',updateIteration), '.mat'];
finalName = fullfile(address, filename);
save(finalName,'Allscales', 'Allbws', 'AllDATA', 'Allreg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Hartmann6D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;clc
funcMu = struct('f', 'NegIndGPmean');
boundPara = [0,5;0,2]; %repmat([0, 1], 2, 1); 2 is the size of parm i.e. scale and bw
noise2 = 0.000001; %noise level
numExp = 60;
oneExtExp = numExp + 1; %this is because the first round gives you the regret before we choose any points
nsim = 50;
updateIteration = 5;
nObs = 20; %initial observations
InitScale = 1; %sigf2 = 1;
InitBW = 0.25;

realOpt = 3.32237; %Hartmann6

numUpdate = floor(oneExtExp/updateIteration);
Allscales = NaN(nsim, numUpdate);
Allbws = NaN(nsim, numUpdate);
Allreg=NaN(nsim,oneExtExp);
AllDATA = cell(nsim,1);

load NegHartInitDATA
AllinitDATA = NegHartInitDATA;

address = 'Z:\phase 2\5. Greedy\Data';
FuncName = 'Hartmann6';

parfor iSim = 1:nsim
    InitDATA = AllinitDATA(((iSim-1)*nObs+1):(iSim*nObs),:);
    [DATA, reg, Scale, BW] = RandomSelection6D(funcMu, boundPara, noise2, oneExtExp, updateIteration, realOpt, InitScale, InitBW, InitDATA, FuncName);
    Allscales(iSim,:) = Scale;
    Allbws(iSim,:) = BW;
    AllDATA{iSim}= DATA;
    Allreg(iSim,:) = reg;
end
filename = ['Rand6D', FuncName, 'UpFreq', sprintf('%d',updateIteration), '.mat'];
finalName = fullfile(address, filename);
save(finalName,'Allscales', 'Allbws', 'AllDATA', 'Allreg')

nima