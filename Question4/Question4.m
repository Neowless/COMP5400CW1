clear all
close all
load("question_4.mat")
rng default
figure(1)
plot(generation,average,'LineWidth',1.2);
title('Average Fitness Plot of Mice in Generation Count (Modified Fitness Function)')
xlabel('Generation Count') 
ylabel('Fitness Number') 
legend({'Average Fitness'},'Location','northeast')
ax = gca;
ax.FontSize = 12;
xticks([0 150 400 1000  4000])
xticklabels({'0','150','400','1000','4000'})
pulseSNR = snr((zeros(1,3000)+mean(average(1001:4000)))',average(1001:4000))

figure(2)
plot(generation,average,'LineWidth',1.2);
title('Average Fitness Plot of Mice in Generation Count (Modified Fitness Function)')
xlabel('Generation Count') 
ylabel('Fitness Number') 
legend({'Average Fitness'},'Location','northeast')
ax = gca;
ax.FontSize = 12;
xlim([0 1000])
ylim([0 2])

figure(3)
plot(generation,average_original,'LineWidth',1.2);
title('Average Fitness Plot of Mice in Generation Count (Original Fitness Function)')
xlabel('Generation Count') 
ylabel('Fitness Number') 
legend({'Average Fitness'},'Location','northeast')
ax = gca;
ax.FontSize = 12;
xticks([0 150 400 1000  4000])
xticklabels({'0','150','400','1000','4000'})

pulseSNR = snr((zeros(1,3000)+mean(average_original(1001:4000)))',average_original(1001:4000))

figure(4)
plot(generation,average_original,'LineWidth',1.2);
title('Average Fitness Plot of Mice in Generation Count (Original Fitness Function)')
xlabel('Generation Count') 
ylabel('Fitness Number') 
legend({'Average Fitness'},'Location','northeast')
ax = gca;
ax.FontSize = 12;
xlim([0 1000])
ylim([0 0.01])

figure(5)
subplot(2,1,1);
plot(generation,average_original,'LineWidth',1.2);
title('Average Fitness Plot of Original Fitness Function')
xlabel('Generation Count') 
ylabel('Fitness Number') 
legend({'Original Fitness Function'},'Location','northeast')
ax = gca;
ax.FontSize = 12;
xlim([0 1000])
ylim([0 0.01])
subplot(2,1,2);
plot(generation,average,'LineWidth',1.2);
title('Average Fitness Plot of New Fitness Function')
xlabel('Generation Count') 
ylabel('Fitness Number') 
legend({'New Fitness Function'},'Location','northeast')
ax = gca;
ax.FontSize = 12;
xlim([0 1000])
ylim([0 2])
saveas(5,'Converge_Compare.svg')