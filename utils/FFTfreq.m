% 对所求得的能量函数Eg进行傅里叶变换，求得振荡峰值所在的频率，及该频率处的幅值大小。
% Eg14代表变流器部分的能量函数，Eg12代表感应电机部分的能量函数。
% 最终结果是用上述二者与Eg2或者Eg11的比值来界定的。
Fs = 1/5e-5;            % Sampling frequency                    
T = 1/Fs;             % Sampling period  

X=Eg2;
X=X-mean(X);
% step=5/Fs+1;    %扰动施加时间
% X=X(step:end);

L=length(X);
Y = fft(X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,smooth(P1)) 
%title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('{\it f}  (Hz)')
ylabel('{\it A}_2''')