clc;
clearvars;
addpath('../QuadRelaxation/');
name    =   'case9';
mpc     =   loadcase(sprintf('%s.m',name));
define_constants;
nbus    =   size(mpc.bus,1);
[P,Q]   =   GetPQ(mpc);
alphs   =   [0,1];
amax    =   0;
for it=1:10
Pd      =   mean(alphs)*abs(mpc.bus(:,PD))/mpc.baseMVA;
Qd      =   mean(alphs)*abs(mpc.bus(:,QD))/mpc.baseMVA;
plims   =   [P-Pd,P+Pd];
qlims   =   [Q-Qd,Q+Qd];
opts    =   CheckMoment(mpc,plims,qlims);
if(all(opts>0))
    amax    =   mean(alphs);
    alphs   =   [mean(alphs),max(alphs)];
    save(sprintf('%sres.mat',name),'alphs');
else
    alphs   =   [min(alphs),mean(alphs)];
end
end
