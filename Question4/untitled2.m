Tpulse = 20e-3;
Fs = 10e3;
t = -1:1/Fs:1;
x = rectpuls(t,Tpulse);
rng default

SNR = 53;
y = randn(size(x))*std(x)/db2mag(SNR);

s = x + y;

pulseSNR = snr(x,y)