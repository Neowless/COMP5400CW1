clear all
close all
load("question_4.mat")
figure(1)
subplot(2,1,1);
plot(generation,average,'LineWidth',1.2);
title('Average Fitness Plot of Mice in Generation Count (Modified Fitness Function)')
xlabel('Generation Count') 
ylabel('Fitness Number') 
legend({'Average Fitness'},'Location','northeast')
ax = gca;
ax.FontSize = 12;
xticks([0 150 400 1000  4000])
xticklabels({'0','150','400','1000','4000'})
subplot(2,1,2)
plot(generation,best,'LineWidth',1.2);
title('Best Fitness Plot of Mice in Generation Count (Modified Fitness Function)')
xlabel('Generation Count') 
ylabel('Fitness Number') 
legend({'Best Fitness'},'Location','northeast')
ax = gca;
ax.FontSize = 12;
xticks([0 150 400 1000 4000])
xticklabels({'0','150','400','1000','4000'})
saveas(1,'0-4000.svg')
figure(2)
subplot(2,1,1);
plot(generation,average,'LineWidth',1.2);
title('Average Fitness Plot of Mice in Generation Count (Modified Fitness Function)')
xlabel('Generation Count') 
ylabel('Fitness Number') 
legend({'Average Fitness'},'Location','northeast')
ax = gca;
ax.FontSize = 12;
xlim([0 400])
ylim([0 2])
subplot(2,1,2)
plot(generation,best,'LineWidth',1.2);
title('Best Fitness Plot of Mice in Generation Count (Modified Fitness Function)')
xlabel('Generation Count') 
ylabel('Fitness Number') 
legend({'Best Fitness'},'Location','northeast')
ax = gca;
ax.FontSize = 12;
xlim([0 400])
ylim([0 5.5])
saveas(1,'0-400.svg')