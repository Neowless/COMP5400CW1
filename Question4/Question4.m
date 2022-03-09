clear all
close all
load("question_4.mat")
rng default

original_pulseSNR = snr((zeros(1,3000)+mean(average(1001:4000)))',average(1001:4000));
fprintf('SNR of original fitness function %6.2f\n', original_pulseSNR)

new_pulseSNR = snr((zeros(1,3000)+mean(average_original(1001:4000)))',average_original(1001:4000));
fprintf('SNR of new fitness function %6.2f\n', new_pulseSNR)

figure(1)
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
saveas(1,'Converge_Compare_Functions.svg')