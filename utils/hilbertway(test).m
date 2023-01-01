%用希尔伯特变换解调制
%效果不是很好 边缘效应严重
m1=abs(hilbert(phiqr));
plot(m1)