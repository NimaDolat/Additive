
for ii = 1:50
    AllDATA{ii}(:,end) = AllDATA{ii}(:,end) - 4;
end
Allreg = Allreg - 4;
save('Rand12DAckleyUpFreq25.mat','Allscales', 'Allbws', 'AllDATA', 'Allreg')
%%%%%%%taking care of 6D Ackely
numExp = 60;
oneExtExp = numExp + 1;
nObs = 20;
nSim = 50;
ObsMax = NaN(nSim,oneExtExp);
for jj = 1:nSim
    best = max(AllDATA{jj}(1:nObs,end));
    ObsMax(jj,1) = best;
    for ii = 1:numExp
        best = max(best,AllDATA{jj}(nObs+ii,end));
        ObsMax(jj,ii+1) = best;
    end
end
actualBest = 10;
ObsReg = actualBest - ObsMax;

AckleyFull6D = ObsReg;
AckleyAdaptEI6D = ObsReg;
AckleyAdaptUCB6D = ObsReg;
AckleyRandom6D = ObsReg;
    
save('Ackley6DObsReg.mat','AckleyFull6D','AckleyAdaptEI6D','AckleyAdaptUCB6D','AckleyRandom6D')

%%%%%%taking care of 12D Ackely
numExp = 200;
oneExtExp = numExp + 1;
nObs = 50;
nSim = 25;
ObsMax = NaN(nSim,oneExtExp);
for jj = 1:nSim
    best = max(AllDATA{jj}(1:nObs,end));
    ObsMax(jj,1) = best;
    for ii = 1:numExp
        best = max(best,AllDATA{jj}(nObs+ii,end));
        ObsMax(jj,ii+1) = best;
    end
end
actualBest = 14;
ObsReg = actualBest - ObsMax;

AckleyFull12D = ObsReg;
AckleyAdaptEI12D = ObsReg;
AckleyRandom12D = ObsReg;
    
save('Ackley12DObsReg.mat','AckleyFull12D','AckleyAdaptEI12D','AckleyRandom12D')

%%%%%%%taking care of 6D Hartmann
numExp = 60;
oneExtExp = numExp + 1;
nObs = 20;
nSim = 50;
ObsMax = NaN(nSim,oneExtExp);
for jj = 1:nSim
    best = max(AllDATA{jj}(1:nObs,end));
    ObsMax(jj,1) = best;
    for ii = 1:numExp
        best = max(best,AllDATA{jj}(nObs+ii,end));
        ObsMax(jj,ii+1) = best;
    end
end
actualBest = 3.32237;
ObsReg = actualBest - ObsMax;

HartmannFull6D = ObsReg;
HartmannAdaptEI6D = ObsReg;
HartmannAdaptUCB6D = ObsReg;
HartmannRandom6D = ObsReg;
    
save('Hartmann6DObsReg.mat','HartmannFull6D','HartmannAdaptEI6D','HartmannAdaptUCB6D','HartmannRandom6D')

%%%%%%%taking care of 6D Styblinski
numExp = 60;
oneExtExp = numExp + 1;
nObs = 20;
nSim = 50;
ObsMax = NaN(nSim,oneExtExp);
for jj = 1:nSim
    best = max(AllDATA{jj}(1:nObs,end));
    ObsMax(jj,1) = best;
    for ii = 1:numExp
        best = max(best,AllDATA{jj}(nObs+ii,end));
        ObsMax(jj,ii+1) = best;
    end
end
actualBest = 8.9104;
ObsReg = actualBest - ObsMax;

StyblinskiFull6D = ObsReg;
StyblinskiAdaptEI6D = ObsReg;
StyblinskiAdaptUCB6D = ObsReg;
StyblinskiRandom6D = ObsReg;
    
save('Styblinski6DObsReg.mat','StyblinskiFull6D','StyblinskiAdaptEI6D','StyblinskiAdaptUCB6D','StyblinskiRandom6D')