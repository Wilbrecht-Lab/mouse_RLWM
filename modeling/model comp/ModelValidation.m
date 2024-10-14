%% a0bs1232 (simulation looks ok)
clear 
clc

condition = 'female_ns2';
load(['~/Dropbox/Jimmy/RLWM_mice_new/modeling/maximum_likelihood/saved_res/ml_res_',...
    condition,'.mat']);

rng('default')
%data = data_male_ns2;

eval(['data = data_',condition]);
param_a0bs1232 = [];
param_a0bs1232.alpha_positive = Xfit_a0bs1232(:, 1);
param_a0bs1232.beta = Xfit_a0bs1232(:, 2);
param_a0bs1232.s1 = Xfit_a0bs1232(:, 3);
param_a0bs1232.s2 = Xfit_a0bs1232(:, 4);
param_a0bs1232.s3 = Xfit_a0bs1232(:, 5);
param_a0bs1232.s4 = param_a0bs1232.s2;

data_a0bs1232 = online_simulation_compare_binned(data, param_a0bs1232);
set(gca,'fontsize',14)
xlabel('trial number per odor')
ylabel('P(Correct)')
ylim([.4 .8])
xlim([20 160])
title(condition)
