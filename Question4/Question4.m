clear all
close all
load("question_4.mat")
rng default

original_pulseSNR = snr((zeros(1,2000)+mean(average(1001:3000)))',average(1001:3000));
fprintf('SNR of original fitness function %7.4f\n', original_pulseSNR)

new_pulseSNR = snr((zeros(1,2000)+mean(average_original(1001:3000)))',average_original(1001:3000));
fprintf('SNR of new fitness function %7.4f\n', new_pulseSNR)

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



figure(2)
plot(generation,average_original)
hold
plot(generation,sensor_05_200)
plot(generation,sensor_2_50)
plot(generation,sensor_3_50)
plot(generation,sensor_4_50)
plot(generation,sensor_4_100)
plot(generation,sensor_4_200)
plot(generation,sensor_6_50)
plot(generation,sensor_8_50)
legend({'Original','Congiuration 1','Congiuration 2','Congiuration 3','Congiuration 4','Congiuration 5','Congiuration 6','Congiuration 7','Congiuration 8'},'Location','northwest')
title('Average Fitness of Different Sensor Configuration')
xlabel('Generation Count') 
ylabel('Fitness Number') 
ax = gca;
ax.FontSize = 12;
xlim([0 3000])
ylim([0 0.01])
saveas(2,'Compare_All_Sensors.svg')

original_pulseSNR = snr((zeros(1,2000)+mean(average(1001:3000)))',average(1001:3000));
fprintf('SNR of original sensor configuration %7.4f\n', original_pulseSNR)

C1_SNR = snr((zeros(1,2000)+mean(sensor_05_200(1001:3000)))',sensor_05_200(1001:3000));
fprintf('SNR of sensor configuration 1 %7.4f\n', C1_SNR)

C2_SNR = snr((zeros(1,2000)+mean(sensor_2_50(1001:3000)))',sensor_2_50(1001:3000));
fprintf('SNR of sensor configuration 2 %7.4f\n', C2_SNR)

C3_SNR = snr((zeros(1,2000)+mean(sensor_3_50(1001:3000)))',sensor_3_50(1001:3000));
fprintf('SNR of sensor configuration 3 %7.4f\n', C3_SNR)

C4_SNR = snr((zeros(1,2000)+mean(sensor_4_50(1001:3000)))',sensor_4_50(1001:3000));
fprintf('SNR of sensor configuration 4 %7.4f\n', C4_SNR)

C5_SNR = snr((zeros(1,2000)+mean(sensor_4_100(1001:3000)))',sensor_4_100(1001:3000));
fprintf('SNR of sensor configuration 5 %7.4f\n', C5_SNR)

C6_SNR = snr((zeros(1,2000)+mean(sensor_4_200(1001:3000)))',sensor_4_200(1001:3000));
fprintf('SNR of sensor configuration 6 %7.4f\n', C6_SNR)

C7_SNR = snr((zeros(1,2000)+mean(sensor_6_50(1001:3000)))',sensor_6_50(1001:3000));
fprintf('SNR of sensor configuration 7 %7.7f\n', C7_SNR)

C8_SNR = snr((zeros(1,2000)+mean(sensor_8_50(1001:3000)))',sensor_8_50(1001:3000));
fprintf('SNR of sensor configuration 8 %7.4f\n', C8_SNR)


fprintf('Mean Value of original sensor configuration %6.4f\n', mean(average_original(1001:3000)))

fprintf('Mean Value of sensor configuration 1 %6.4f\n', mean(sensor_05_200(1001:3000)))
fprintf('Mean Value of sensor configuration 2 %6.4f\n', mean(sensor_2_50(1001:3000)))
fprintf('Mean Value of sensor configuration 3 %6.4f\n', mean(sensor_3_50(1001:3000)))
fprintf('Mean Value of sensor configuration 4 %6.4f\n', mean(sensor_4_50(1001:3000)))
fprintf('Mean Value of sensor configuration 5 %6.4f\n', mean(sensor_4_100(1001:3000)))
fprintf('Mean Value of sensor configuration 6 %6.4f\n', mean(sensor_4_200(1001:3000)))
fprintf('Mean Value of sensor configuration 7 %6.4f\n', mean(sensor_6_50(1001:3000)))
fprintf('Mean Value of sensor configuration 8 %6.4f\n', mean(sensor_8_50(1001:3000)))

