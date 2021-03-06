clear all
close all
load("question_6.mat")


figure(1)
plot(generation_100,Prey_100_Me_1,'LineWidth',1.2)
hold
plot(generation_100,Prey_100_Me_2,'LineWidth',1.2)
plot(generation_100,Prey_100_Yiqiao_1,'LineWidth',1.2)
plot(generation_100,Prey_100_Yiqiao_2,'LineWidth',1.2)
plot(generation_100,Prey_1000_Me(1:100),'LineWidth',1.2)
plot(generation_100,Prey_1800_Yiqiao(1:100),'LineWidth',1.2)
plot(generation_100,Prey_3000_Me(1:100),'LineWidth',1.2)
title('Average Fitness Plot of Prey in Generation Count')
legend({'Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7'},'Location','northeast')
xlim([0 100])
ax = gca;
ax.FontSize = 12;
saveas(1,'Prey_100.svg')


figure(2)
plot(generation_100,Predator_100_Me_1,'LineWidth',1.2)
hold
plot(generation_100,Predator_100_Me_2,'LineWidth',1.2)
plot(generation_100,Predator_100_Yiqiao_1,'LineWidth',1.2)
plot(generation_100,Predator_100_Yiqiao_2,'LineWidth',1.2)
plot(generation_100,Predator_1000_Me(1:100),'LineWidth',1.2)
plot(generation_100,Predator_1800_Yiqiao(1:100),'LineWidth',1.2)
plot(generation_100,Predator_3000_Me(1:100),'LineWidth',1.2)
title('Average Fitness Plot of Predator in Generation Count')
legend({'Test 1','Test 2','Test 3','Test 4','Test 5','Test 6','Test 7'},'Location','northwest')
xlim([0 100])
ax = gca;
ax.FontSize = 12;
saveas(2,'Predator_100.svg')

figure(3)
plot(generation_3000,Prey_3000_Me,'LineWidth',1.1)
hold
plot(generation_3000,1./Predator_3000_Me,'LineWidth',1.1)
title(['Prey Average Fitness and Reciprocal of  Average Fitness of Predator'])
legend({'Test 1 Prey','Test 1 Reciprocal of Predator'},'Location','northeast')
xlim([0 3000])
ax = gca;
ax.FontSize = 12;
saveas(3,'Reciprocal_3000.svg')

figure(4)
plot(generation_100,Prey_100_Yiqiao_1,'LineWidth',1.1)
hold
plot(generation_100,1./Predator_100_Yiqiao_1,'LineWidth',1.1)
title(['Prey Average Fitness and Reciprocal of  Average Fitness of Predator'])
legend({'Test 2 Prey','Test 2 Reciprocal of Predator'},'Location','northeast')
xlim([0 100])
ax = gca;
ax.FontSize = 12;

saveas(4,'Reciprocal_100.svg')

figure(5)
plot(generation_3000,Prey_3000_Me,'LineWidth',1.1)
hold
plot(generation_1000,Prey_1000_Me,'LineWidth',1.1)
plot(generation_1800,Prey_1800_Yiqiao,'LineWidth',1.1)
title(['Average Fitness of Different Prey'])
legend({'Prey of Yuheng Huo','Prey of Rui Hou','Prey of Yiqiao Wang'},'Location','northeast')
xlim([0 3000])
ax = gca;
ax.FontSize = 12;
saveas(5,'Prey_All.svg')

figure(6)
plot(generation_3000,Predator_3000_Me,'LineWidth',1.1)
hold
plot(generation_1000,Predator_1000_Me,'LineWidth',1.1)
plot(generation_1800,Predator_1800_Yiqiao,'LineWidth',1.1)
title(['Average Fitness of Different Predator'])
legend({'Predator of Yuheng Huo','Predator of Rui Hou','Predator of Yiqiao Wang'},'Location','northeast')
xlim([0 3000])
ax = gca;
ax.FontSize = 12;
saveas(6,'Predator_All.svg')

figure(7)
subplot(2,1,1);
plot(generation_3000,Prey_3000_Me,'LineWidth',1.1)
title(['Average Fitness of Prey'])
legend({'Prey'},'Location','northeast')
xlim([0 3000])
ylim([0.15 0.8])
xticks([0 700 1900 2400 3000])
xticklabels({'0','700','1900','2400','3000'})
ax = gca;
ax.FontSize = 12;
subplot(2,1,2);
plot(generation_3000,Predator_3000_Me,'LineWidth',1.1)
title(['Average Fitness of Predator'])
legend({'Predator'},'Location','northeast')
xlim([0 3000])
ylim([0.5 12])
xticks([0 700 1900 2400 3000])
xticklabels({'0','700','1900','2400','3000'})
ax = gca;
ax.FontSize = 12;
saveas(7,'Predator_Prey_3000.svg')



% 
% figure(3)
% plot(generation_1000,Prey_1000_Me)
% 
% figure(4)
% plot(generation_1000,Predator_1000_Me)
% 
% figure(5)
% plot(generation_1800,Prey_1800_Yiqiao)
% 
% figure(6)
% plot(generation_1800,Predator_1800_Yiqiao)
% 
% figure(7)
% plot(generation_3000,Prey_3000_Me)
% 
% figure(8)
% plot(generation_3000,Predator_3000_Me)
