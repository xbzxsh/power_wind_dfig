%% ���Ʋ���
cutseries=1;
figplot=1;

%% ��ȡ�񵴲���
if cutseries==1
    steptime=10;
    endtime=Macsig.Electromagnetic_torque_Te__pu_.TimeInfo.End;
    Macsig.Electromagnetic_torque_Te__pu_=getsampleusingtime(Macsig.Electromagnetic_torque_Te__pu_,steptime,endtime);
    Macsig.idsA=getsampleusingtime(Macsig.idsA,steptime,endtime);
    Macsig.iqsA=getsampleusingtime(Macsig.iqsA,steptime,endtime);
    Macsig.phidrA=getsampleusingtime(Macsig.phidrA,steptime,endtime);
    Macsig.phiqrA=getsampleusingtime(Macsig.phiqrA,steptime,endtime);
    Macsig.Rotor_flux_phir_d__pu_=getsampleusingtime(Macsig.Rotor_flux_phir_d__pu_,steptime,endtime);
    Macsig.Rotor_flux_phir_q__pu_=getsampleusingtime(Macsig.Rotor_flux_phir_q__pu_,steptime,endtime);
    Macsig.Rotor_speed__wm_=getsampleusingtime(Macsig.Rotor_speed__wm_,steptime,endtime);
    Macsig.Stator_flux_phis_d__pu_=getsampleusingtime(Macsig.Stator_flux_phis_d__pu_,steptime,endtime);
    Macsig.Stator_flux_phis_q__pu_=getsampleusingtime(Macsig.Stator_flux_phis_q__pu_,steptime,endtime);
    Macsig.VdrA=getsampleusingtime(Macsig.VdrA,steptime,endtime);
    Macsig.VqrA=getsampleusingtime(Macsig.VqrA,steptime,endtime);

end

%%  �������
Xs=2.5596;
Xss=0.1196;
Rs=0.00706;
Rr=0.005;
Lm=2.9;
Lrr=Lm^2/(Xs-Xss);
T0=Lrr/Rr;
Wr=Macsig.Rotor_speed__wm_.Data;
s=1-Wr;

%% ��������ֵ�����
t=Macsig.Electromagnetic_torque_Te__pu_.Time;
Wm=Macsig.Rotor_speed__wm_.Data;
Te=Macsig.Electromagnetic_torque_Te__pu_.Data;

%�ڶ���������
% iq=Macmeasure.Stator_measurements.Stator_current_is_q__pu_.Data;
% id=Macmeasure.Stator_measurements.Stator_current_is_d__pu_.Data;
% iq=abs(hilbert(iq));
% id=abs(hilbert(id));
% iq=0.5442-0.01084*cos(t*6.283)+0.0003878*sin(t*6.283);
% id=0.5441-0.01104*cos(t*6.283)+0.0003386*sin(t*6.238);
iq=Macsig.iqsA.Data;
id=Macsig.idsA.Data;

Eg2=0.5*Xss.*(iq.^2+id.^2);

%������������ int{Pe*d\dleta}
%--����\delta
phiqr=Macsig.Rotor_flux_phir_q__pu_.Data;
phidr=Macsig.Rotor_flux_phir_d__pu_.Data;
phir=phidr+1j*phiqr;
%----
phiqs=Macsig.Stator_flux_phis_q__pu_.Data;
phids=Macsig.Stator_flux_phis_d__pu_.Data;
phis=phids+1j*phiqs;
%----
delta=angle(phir)-angle(phis);
for i=1:length(delta)
    if delta(i)<0
        delta(i)=delta(i)+2*pi;
    end
end
%--
Pe=Te.*Wm;
Eg3=intlist(Pe,delta);

%��һ��������
% Edd=-Lm/Lrr*phiqr;
% Eqq=Lm/Lrr*phidr;
% Edd=-Lm/Lrr*abs(hilbert(phiqr));
% Eqq=Lm/Lrr*abs(hilbert(phidr));
% 
% Edd=-0.9111-0.004174*cos(t*6.266)+0.003386*sin(t*6.266);
% Eqq=0.9112+0.005309*cos(t*6.301)-0.001594*sin(t*6.301);
Edd=-Lm/Lrr*Macsig.phiqrA.Data;
Eqq=Lm/Lrr*Macsig.phidrA.Data;

%--1 �����ڵ���е�����
Eg11=-0.5*1/(Xs-Xss)*(Eqq.^2+Edd.^2);
%--2 ����ת���ʶ����һ��
Eg12=s.*T0./(Xs-Xss).*(intlist(Eqq,Edd)-intlist(Edd,Eqq));
%--3 ��ɢ����
Eg13=-T0/(Xs-Xss)*(intlist([0;diff(Edd)],Edd))+intlist([0;diff(Eqq)],Eqq);
%--4 �൱�����ŵ�һ��
Vqr=Macsig.VqrA.Data;
Vdr=Macsig.VdrA.Data;
Eg14=-Lm*T0/(Xs-Xss)/Lrr*(intlist(Vqr,Edd)+intlist(Vdr,Eqq));

Eg1=Eg11+Eg12+Eg13+Eg14;

Eg=Eg1+Eg2+Eg3;

%% ����ͼ��
%figplot==1 ����Eg1,Eg2,Eg3
%figplot==2 ����Eg11,Eg12,Eg13,Eg14
if figplot==1
    figure('Name','DFIG������������')
    subplot(3,1,1)
    plot(t,Eg1)
    title('Eg1')
    subplot(3,1,2)
    plot(t,Eg2)
    title('Eg2')
    subplot(3,1,3)
    plot(t,Eg3)
    title('Eg3')
end

if figplot==1
    figure('Name','Eg1��������')
    subplot(2,2,1)
    plot(t,Eg11)
    title('Eg11')
    subplot(2,2,2)
    plot(t,Eg12)
    title('Eg12')
    subplot(2,2,3)
    plot(t,Eg13)
    title('Eg13')
    subplot(2,2,4)
    plot(t,Eg14)
    title('Eg14')
end



%% ����˿��������Ƚ�
GP=Gridsig.SourceP.Data;
GQ=Gridsig.SourceQ.Data;
Gtheta=Gridsig.Thetaij.Data;
GVi=Gridsig.Vi.Data;
GVj=Gridsig.Vj.Data;

for i=1:length(Gtheta)
    if Gtheta(i)>5
        Gtheta(i)=Gtheta(i)-2*pi;
    end
    if Gtheta(i)<-5
        Gtheta(i)=Gtheta(i)+2*pi;
    end
end

En1=intlist(GP,Gtheta);
En2=intlist(GQ,log(GVi));
En=En1+En2;


