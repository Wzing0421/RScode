% To specify the power of X to be 0 dBW and add noise to produce
% an SNR of 10dB, use:
X = [1,1,-1,1,-1,1,-1,1,-1,1];
Y = awgn(X,0);
Y1 = awgn(X,5);
Y2 = awgn(X,20);

subplot(311);
plot(Y);
subplot(312);
plot(Y1);
subplot(313);
plot(Y2);