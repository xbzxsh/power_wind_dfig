function y = intlist(A,B)
%INTLIST Ϊ�б����
%   ��������int(AdB)���б�,���س���һ�µĻ����б�
n=length(A);
B1=B(2:end);
B2=B(1:end-1);
dB=B1-B2;
y=zeros(n,1);
y(1)=0;
for i=2:n
    y(i)=y(i-1)+A(i)*dB(i-1);
end
end

%y=cumtrapz(B,A);

