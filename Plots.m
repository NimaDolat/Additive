%%%% Adaptive UCB, Adaptive EI, Full EI and Random

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Ackely 6D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
load('Z:\phase 2\5. Greedy\Data\Ackley\FullAdaptiveUCBAckleyUpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'b','LineWidth', 2)
hold on
load('Z:\phase 2\5. Greedy\Data\Ackley\FullAdaptiveEIAckleyUpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'r','LineWidth', 2)
load('Z:\phase 2\5. Greedy\Data\Ackley\Full6DAckleyUpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'k','LineWidth', 2)
load('Z:\phase 2\5. Greedy\Data\Ackley\Rand6DAckleyUpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'--k','LineWidth', 2)
legend('UCB','EI','Full','Random')
set(gca,'FontSize',24)
xlabel('Number of Experiments')
title('6D Ackley (updated every 5 iterations)')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Styblinkski 6D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
load('Z:\phase 2\5. Greedy\Data\Styblinski\FullAdaptiveUCBStyblinkskiUpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'b','LineWidth', 2)
hold on
load('Z:\phase 2\5. Greedy\Data\Styblinski\FullAdaptiveEIStyblinkskiUpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'r','LineWidth', 2)
load('Z:\phase 2\5. Greedy\Data\Styblinski\Full6DStyblinkskiUpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'k','LineWidth', 2)
load('Z:\phase 2\5. Greedy\Data\Styblinski\Rand6DStyblinkskiUpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'--k','LineWidth', 2)
legend('UCB','EI','Full','Random')
set(gca,'FontSize',24)
xlabel('Number of Experiments')
title('6D Styblinski (updated every 5 interations)')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Hartmann 6D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
load('Z:\phase 2\5. Greedy\Data\Hartmann6\FullAdaptiveUCBHartmann6UpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'b','LineWidth', 2)
hold on
load('Z:\phase 2\5. Greedy\Data\Hartmann6\FullAdaptiveEIHartmann6UpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'r','LineWidth', 2)
load('Z:\phase 2\5. Greedy\Data\Hartmann6\Full6DHartmann6UpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'k','LineWidth', 2)
load('Z:\phase 2\5. Greedy\Data\Hartmann6\Rand6DHartmann6UpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'--k','LineWidth', 2)
legend('UCB','EI','Full','Random')
set(gca,'FontSize',24)
xlabel('Number of Experiments')
title('Hartmann6 (updated every 5 interations)')
hold off

%%%% Adaptive EI, Full EI and Random on 12 dimensions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Ackely 12D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
load('Z:\phase 2\5. Greedy\Data\Ackley\FullAdapEI12DAckleyUpFreq25.mat')
AveReg = mean(Allreg);
plot(0:200, AveReg,'r','LineWidth', 2)
hold on
load('Z:\phase 2\5. Greedy\Data\Ackley\Full12DAckleyUpFreq25.mat')
AveReg = mean(Allreg);
plot(0:200, AveReg,'k','LineWidth', 2)
load('Z:\phase 2\5. Greedy\Data\Ackley\Rand12DAckleyUpFreq25.mat')
AveReg = mean(Allreg(1:25,:));
plot(0:200, AveReg,'--k','LineWidth', 2)
legend('EI','Full','Random')
set(gca,'FontSize',24)
xlabel('Number of Experiments')
title('12D Ackley (updated every 25 iterations)')
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Ackely 6D (Observed Regret)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
load('Z:\phase 2\5. Greedy\Data\Ackley\Ackley6DObsReg.mat')
AveReg = mean(AckleyAdaptUCB6D);
plot(0:60, AveReg,'b','LineWidth', 2)
hold on
AveReg = mean(AckleyAdaptEI6D);
plot(0:60, AveReg,'r','LineWidth', 2)
AveReg = mean(AckleyFull6D);
plot(0:60, AveReg,'k','LineWidth', 2)
AveReg = mean(AckleyRandom6D);
plot(0:60, AveReg,'--k','LineWidth', 2)
legend('UCB','EI','Full','Random')
set(gca,'FontSize',24)
xlabel('Number of Experiments')
title('6D Ackley (Obs. Reg)')
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Styblinski 6D (Observed Regret)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
load('Z:\phase 2\5. Greedy\Data\Styblinski\Styblinski6DObsReg.mat')
AveReg = mean(StyblinskiAdaptUCB6D);
plot(0:60, AveReg,'b','LineWidth', 2)
hold on
AveReg = mean(StyblinskiAdaptEI6D);
plot(0:60, AveReg,'r','LineWidth', 2)
AveReg = mean(StyblinskiFull6D);
plot(0:60, AveReg,'k','LineWidth', 2)
AveReg = mean(StyblinskiRandom6D);
plot(0:60, AveReg,'--k','LineWidth', 2)
legend('UCB','EI','Full','Random')
set(gca,'FontSize',24)
xlabel('Number of Experiments')
title('6D Styblinski (Obs. Reg)')
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Hartmann 6D (Observed Regret)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
load('Z:\phase 2\5. Greedy\Data\Hartmann6\Hartmann6DObsReg.mat')
AveReg = mean(HartmannAdaptUCB6D);
plot(0:60, AveReg,'b','LineWidth', 2)
hold on
AveReg = mean(HartmannAdaptEI6D);
plot(0:60, AveReg,'r','LineWidth', 2)
AveReg = mean(HartmannFull6D);
plot(0:60, AveReg,'k','LineWidth', 2)
AveReg = mean(HartmannRandom6D);
plot(0:60, AveReg,'--k','LineWidth', 2)
legend('UCB','EI','Full','Random')
set(gca,'FontSize',24)
xlabel('Number of Experiments')
title('6D Hartmann (Obs. Reg)')
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Ackely 12D (Observed Regret)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
load('Z:\phase 2\5. Greedy\Data\Ackley\Ackley12DObsReg.mat')
AveReg = mean(AckleyAdaptEI12D);
plot(0:200, AveReg,'r','LineWidth', 2)
hold on
AveReg = mean(AckleyFull12D);
plot(0:200, AveReg,'k','LineWidth', 2)
AveReg = mean(AckleyRandom12D);
plot(0:200, AveReg,'--k','LineWidth', 2)
legend('EI','Full','Random')
set(gca,'FontSize',24)
xlabel('Number of Experiments')
title('12D Ackley (Obs. Reg)')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Ackely - Observed Regret vs Mean Maximizer Regret
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
load('Z:\phase 2\5. Greedy\Data\Ackley\FullAdapEI12DAckleyUpFreq25.mat')
AveReg = mean(Allreg);
plot(0:200, AveReg,'r','LineWidth', 2)
hold on
load('Z:\phase 2\5. Greedy\Data\Ackley\Ackley12DObsReg.mat')
AveReg = mean(AckleyAdaptEI12D);
plot(0:200, AveReg,'--r','LineWidth', 2)
load('Z:\phase 2\5. Greedy\Data\Ackley\Full12DAckleyUpFreq25.mat')
AveReg = mean(Allreg);
plot(0:200, AveReg,'k','LineWidth', 2)
AveReg = mean(AckleyFull12D);
plot(0:200, AveReg,'--k','LineWidth', 2)
legend('EI (MM)','EI (Obs)','Full (MM)', 'Full (Obs)')
set(gca,'FontSize',24)
xlabel('Number of Experiments')
title('12D Ackley (Obs vs MeanMaximizer Regret)')
hold off

figure
load('Z:\phase 2\5. Greedy\Data\Ackley\FullAdaptiveEIAckleyUpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'r','LineWidth', 2)
hold on
load('Z:\phase 2\5. Greedy\Data\Ackley\Ackley6DObsReg.mat')
AveReg = mean(AckleyAdaptEI6D);
plot(0:60, AveReg,'--r','LineWidth', 2)
load('Z:\phase 2\5. Greedy\Data\Ackley\Full6DAckleyUpFreq5.mat')
AveReg = mean(Allreg);
plot(0:60, AveReg,'k','LineWidth', 2)
AveReg = mean(AckleyFull6D);
plot(0:60, AveReg,'--k','LineWidth', 2)
legend('EI (MM)','EI (Obs)','Full (MM)', 'Full (Obs)')
set(gca,'FontSize',24)
xlabel('Number of Experiments')
title('6D Ackley (Obs vs MeanMaximizer Regret)')
hold off
