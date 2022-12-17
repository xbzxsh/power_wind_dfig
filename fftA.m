function y = fftA(Eg,freq)
%FFTA ������������������FFT,������Ƶ�ʴ�����ֵ��С
%   �˴���ʾ��ϸ˵��
Fs = 1/5e-5;            % Sampling frequency                    
T = 1/Fs;             % Sampling period  
%STEPTIME=5;             %�Ŷ�ʩ��ʱ��

X=Eg;
X=X-mean(X);
%step=STEPTIME*Fs;   
%X=X(step+2:end);

L=length(X);
Y = fft(X);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
N=round(freq*L/Fs+1);
y=P1(N);
%y=P1(N);
% plot(f,P1) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')
end

