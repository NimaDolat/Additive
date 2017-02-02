%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Ackley
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
funcEI = struct('f', 'NegativeEI');
funcMu = struct('f', 'NegIndGPmean');
noise2 = 0.000001; %noise level
numExp = 200; %150
oneExtExp = numExp + 1; %this is because the first round gives you the regret before we choose any points
nsim = 50; %25 or 50
updateIteration = 10;
nObs = 50; %initial observations

%for Ackley since it goes from around 0 to 14
boundPara = [0,5;0,2]; %repmat([0, 1], 2, 1); 2 is the size of parm i.e. scale and bw
InitScale = 2; %sigf2 = 1;
InitBW = 0.5;

realOpt= 14; %Ackley

numUpdate = floor(oneExtExp/updateIteration);
Allscales = NaN(nsim, numUpdate);
Allbws = NaN(nsim, numUpdate);
Allreg=NaN(nsim,oneExtExp);
AllDATA = cell(nsim,1);


load Ackley12InitDATA
AllinitDATA = Ackley12InitDATA;

address = '/home/stats/dolatnin/Phase2/5. Greedy/Data';
FuncName = 'Ackley';

parfor iSim = 1:nsim
    InitDATA = AllinitDATA(((iSim-1)*nObs+1):(iSim*nObs),:);
    [DATA, reg, Scale, BW] = Full(funcEI, funcMu, boundPara, noise2, oneExtExp, updateIteration, realOpt, InitScale, InitBW, InitDATA, FuncName);
    Allscales(iSim,:) = Scale;
    Allbws(iSim,:) = BW;
    AllDATA{iSim}= DATA;
    Allreg(iSim,:) = reg;
end
filename = ['FullBO', FuncName, 'UpFreq', sprintf('%d',updateIteration), '.mat'];
finalName = fullfile(address, filename);
save(finalName,'Allscales', 'Allbws', 'AllDATA', 'Allreg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Powell
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc
funcEI = struct('f', 'NegativeEI');
funcMu = struct('f', 'NegIndGPmean');
noise2 = 0.000001; %noise level
numExp = 200; %150
oneExtExp = numExp + 1; %this is because the first round gives you the regret before we choose any points
nsim = 50; %25 or 50
updateIteration = 10;
nObs = 50; %initial observations

%for Ackley since it goes from around 0 to 14
boundPara = [0,15; 0,5]; %repmat([0, 1], 2, 1); 2 is the size of parm i.e. scale and bw
InitScale = 5; %sigf2 = 1;
InitBW = 1;

realOpt= 450; %Powell

numUpdate = floor(oneExtExp/updateIteration);
Allscales = NaN(nsim, numUpdate);
Allbws = NaN(nsim, numUpdate);
Allreg=NaN(nsim,oneExtExp);
AllDATA = cell(nsim,1);

load Powell12InitDATA
AllinitDATA = Powell12InitDATA;

address = '/home/stats/dolatnin/Phase2/5. Greedy/Data';
FuncName = 'Powell';

parfor iSim = 1:nsim
    InitDATA = AllinitDATA(((iSim-1)*nObs+1):(iSim*nObs),:);
    [DATA, reg, Scale, BW] = Full(funcEI, funcMu, boundPara, noise2, oneExtExp, updateIteration, realOpt, InitScale, InitBW, InitDATA, FuncName);
    Allscales(iSim,:) = Scale;
    Allbws(iSim,:) = BW;
    AllDATA{iSim}= DATA;
    Allreg(iSim,:) = reg;
end
filename = ['FullBO', FuncName, 'UpFreq', sprintf('%d',updateIteration), '.mat'];
finalName = fullfile(address, filename);
save(finalName,'Allscales', 'Allbws', 'AllDATA', 'Allreg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Rastrigin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc
funcEI = struct('f', 'NegativeEI');
funcMu = struct('f', 'NegIndGPmean');
noise2 = 0.000001; %noise level
numExp = 200; %150
oneExtExp = numExp + 1; %this is because the first round gives you the regret before we choose any points
nsim = 50; %25 or 50
updateIteration = 10;
nObs = 50; %initial observations

%for Ackley since it goes from around 0 to 14
boundPara = [0,15;0,5]; %repmat([0, 1], 2, 1); 2 is the size of parm i.e. scale and bw
InitScale = 5; %sigf2 = 1;
InitBW = 1;

realOpt = 285; %Rastrigin

numUpdate = floor(oneExtExp/updateIteration);
Allscales = NaN(nsim, numUpdate);
Allbws = NaN(nsim, numUpdate);
Allreg=NaN(nsim,oneExtExp);
AllDATA = cell(nsim,1);

load Rast12InitDATA
AllinitDATA = Rast12InitDATA;

address = '/home/stats/dolatnin/Phase2/5. Greedy/Data';
FuncName = 'Rastrigin';

parfor iSim = 1:nsim
    InitDATA = AllinitDATA(((iSim-1)*nObs+1):(iSim*nObs),:);
    [DATA, reg, Scale, BW] = Full(funcEI, funcMu, boundPara, noise2, oneExtExp, updateIteration, realOpt, InitScale, InitBW, InitDATA, FuncName);
    Allscales(iSim,:) = Scale;
    Allbws(iSim,:) = BW;
    AllDATA{iSim}= DATA;
    Allreg(iSim,:) = reg;
end
filename = ['FullBO', FuncName, 'UpFreq', sprintf('%d',updateIteration), '.mat'];
finalName = fullfile(address, filename);
save(finalName,'Allscales', 'Allbws', 'AllDATA', 'Allreg')

