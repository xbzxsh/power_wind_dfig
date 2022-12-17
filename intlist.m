function y = intlist(A,B)
%INTLIST 为列表积分
%   积分形如int(AdB)的列表,返回长度一致的积分列表
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

