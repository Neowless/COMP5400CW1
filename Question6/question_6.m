clear all
close all
load("question_6.mat")


figure(1)
plot(generation_100,Prey_100_Me_1)
hold
plot(generation_100,Prey_100_Me_2)
plot(generation_100,Prey_1000_Me(1:100))


figure(2)
plot(generation_100,Predator_100_Me_1)
hold
plot(generation_100,Predator_100_Me_2)
plot(generation_100,Predator_1000_Me(1:100))

figure(3)
plot(generation_1000,Prey_1000_Me)

figure(4)
plot(generation_1000,Predator_1000_Me)
