%**计算相关度
%修改扰动源频率，运行仿真获取原始数据
%使用脚本calEg计算能量函数
%使用fftA计算振荡幅值，并在此脚本中计算比值
%将所得结果列成表格

warning off 
%第一次仿真
DistFreq=[0.5 1:40];

mdl='power_wind_dfig_avg';
blk=sprintf('power_wind_dfig_avg/Wind Farm');
Simulink.SimulationInput(mdl);
in=Simulink.SimulationInput(mdl);

for number=1:length(DistFreq)
    set_param(blk,'Freq',num2str(DistFreq(number)));
    out=sim(in);
    MacsigAchieve(number)=out.Macsig; %仿真原始数据记录
    GridsigAchieve(number)=out.Gridsig;
    Macsig=out.Macsig;
    Gridsig=out.Gridsig;
    calEg;
    Amp(number,:)=[fftA(Eg2,DistFreq(number)) fftA(Eg,DistFreq(number))];
    result(number,:)=[Amp(number,2)/Amp(number,1)];
    fprintf('%2.0f%%...', number/length(DistFreq)*100)
end
fprintf('\n')
