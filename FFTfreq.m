% ������õ���������Eg���и���Ҷ�任������񵴷�ֵ���ڵ�Ƶ�ʣ�����Ƶ�ʴ��ķ�ֵ��С��
% Eg14������������ֵ�����������Eg12�����Ӧ������ֵ�����������
% ���ս����������������Eg2����Eg11�ı�ֵ���綨�ġ�
Fs = 1/5e-5;            % Sampling frequency                    
T = 1/Fs;             % Sampling period  

X=Eg2;
X=X-mean(X);
% step=5/Fs+1;    %�Ŷ�ʩ��ʱ��
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