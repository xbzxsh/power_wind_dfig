%**������ض�
%�޸��Ŷ�ԴƵ�ʣ����з����ȡԭʼ����
%ʹ�ýű�calEg������������
%ʹ��fftA�����񵴷�ֵ�����ڴ˽ű��м����ֵ
%�����ý���гɱ��

warning off 
%��һ�η���
DistFreq=[0.5 1:40];

mdl='power_wind_dfig_avg';
blk=sprintf('power_wind_dfig_avg/Wind Farm');
Simulink.SimulationInput(mdl);
in=Simulink.SimulationInput(mdl);

for number=1:length(DistFreq)
    set_param(blk,'Freq',num2str(DistFreq(number)));
    out=sim(in);
    MacsigAchieve(number)=out.Macsig; %����ԭʼ���ݼ�¼
    GridsigAchieve(number)=out.Gridsig;
    Macsig=out.Macsig;
    Gridsig=out.Gridsig;
    calEg;
    Amp(number,:)=[fftA(Eg2,DistFreq(number)) fftA(Eg,DistFreq(number))];
    result(number,:)=[Amp(number,2)/Amp(number,1)];
    fprintf('%2.0f%%...', number/length(DistFreq)*100)
end
fprintf('\n')
