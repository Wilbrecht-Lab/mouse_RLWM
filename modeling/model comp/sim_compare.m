% This script is used to visualize the offline and online simulations of
% different models compared to actual mice data.

% Read in the models of interest

clear 
clc

load('~/Dropbox/Jimmy/RLWM_mice_new/modeling/maximum_likelihood/saved_res/ml_res_male_ns2.mat');
data = data_male_ns2;

rng('default')

%% ab

param_ab = [];
param_ab.alpha = Xfit_ab(:, 1);
param_ab.beta = Xfit_ab(:, 2);

data_ab = online_simulation_compare(data, param_ab);

%% a0b

param_a0b = [];
param_a0b.alpha_positive = Xfit_a0b(:, 1);
param_a0b.beta = Xfit_a0b(:, 2);

data_a0b = online_simulation_compare(data, param_a0b);

%% aab

param_aab = [];
param_aab.alpha_positive = Xfit_aab(:, 1);
param_aab.alpha_negative = Xfit_aab(:, 2);
param_aab.beta = Xfit_aab(:, 3);

data_aab = online_simulation_compare(data, param_aab);

%% abf

param_abf = [];
param_abf.alpha = Xfit_abf(:, 1);
param_abf.beta = Xfit_abf(:, 2);
param_abf.forget = Xfit_abf(:, 3);

data_abf = online_simulation_compare(data, param_abf);

%% a0bf

param_a0bf = [];
param_a0bf.alpha_positive = Xfit_a0bf(:, 1);
param_a0bf.beta = Xfit_a0bf(:, 2);
param_a0bf.forget = Xfit_a0bf(:, 3);

data_a0bf = online_simulation_compare(data, param_a0bf);

%% aabf

param_aabf = [];
param_aabf.alpha_positive = Xfit_aabf(:, 1);
param_aabf.alpha_negative = Xfit_aabf(:, 2);
param_aabf.beta = Xfit_aabf(:, 3);
param_aabf.forget = Xfit_aabf(:, 4);

data_aabf = online_simulation_compare(data, param_aabf);

%% a0bs1

param_a0bs1 = [];
param_a0bs1.alpha_positive = Xfit_a0bs1(:, 1);
param_a0bs1.beta = Xfit_a0bs1(:, 2);
param_a0bs1.s1 = Xfit_a0bs1(:, 3);

data_a0bs1 = online_simulation_compare(data, param_a0bs1);

%% a0bs2

param_a0bs2 = [];
param_a0bs2.alpha_positive = Xfit_a0bs2(:, 1);
param_a0bs2.beta = Xfit_a0bs2(:, 2);
param_a0bs2.s2 = Xfit_a0bs2(:, 3);

data_a0bs2 = online_simulation_compare(data, param_a0bs2);

%% a0bs3

param_a0bs3 = [];
param_a0bs3.alpha_positive = Xfit_a0bs3(:, 1);
param_a0bs3.beta = Xfit_a0bs3(:, 2);
param_a0bs3.s3 = Xfit_a0bs3(:, 3);

data_a0bs3 = online_simulation_compare(data, param_a0bs3);

%% a0bs4

param_a0bs4 = [];
param_a0bs4.alpha_positive = Xfit_a0bs4(:, 1);
param_a0bs4.beta = Xfit_a0bs4(:, 2);
param_a0bs4.s4 = Xfit_a0bs4(:, 3);

data_a0bs4 = online_simulation_compare(data, param_a0bs4);

%% a0bp

param_a0bp = [];
param_a0bp.alpha_positive = Xfit_a0bp(:, 1);
param_a0bp.beta = Xfit_a0bp(:, 2);
param_a0bp.p = Xfit_a0bp(:, 3);

data_a0bp = online_simulation_compare(data, param_a0bp);

%% a0bwm

param_a0bwm = [];
param_a0bwm.alpha_positive = Xfit_a0bwm(:, 1);
param_a0bwm.beta = Xfit_a0bwm(:, 2);
param_a0bwm.wm = Xfit_a0bwm(:, 3);

data_a0bwm = online_simulation_compare(data, param_a0bwm);

%% a0bs24

param_a0bs24 = [];
param_a0bs24.alpha_positive = Xfit_a0bs24(:, 1);
param_a0bs24.beta = Xfit_a0bs24(:, 2);
param_a0bs24.s2 = Xfit_a0bs24(:, 3);
param_a0bs24.s4 = Xfit_a0bs24(:, 4);

data_a0bs24 = online_simulation_compare(data, param_a0bs24);

%% a0s24

param_a0s24 = [];
param_a0s24.alpha_positive = Xfit_a0bs24(:, 1);
param_a0s24.s2 = Xfit_a0bs24(:, 2);
param_a0s24.s4 = Xfit_a0bs24(:, 3);

data_a0s24 = online_simulation_compare(data, param_a0s24);

%% a0es24

param_a0es24 = [];
param_a0es24.alpha_positive = Xfit_a0bs24(:, 1);
param_a0es24.epsilon = Xfit_a0bs24(:, 2);
param_a0es24.s2 = Xfit_a0bs24(:, 3);
param_a0es24.s4 = Xfit_a0bs24(:, 4);

data_a0es24 = online_simulation_compare(data, param_a0es24);

%% abs24

param_abs24 = [];
param_abs24.alpha = Xfit_abs24(:, 1);
param_abs24.beta = Xfit_abs24(:, 2);
param_abs24.s2 = Xfit_abs24(:, 3);
param_abs24.s4 = Xfit_abs24(:, 4);

data_abs24 = online_simulation_compare(data, param_abs24);

%% aabs24

param_aabs24 = [];
param_aabs24.alpha_positive = Xfit_aabs24(:, 1);
param_aabs24.alpha_negative = Xfit_aabs24(:, 2);
param_aabs24.beta = Xfit_aabs24(:, 3);
param_aabs24.s2 = Xfit_aabs24(:, 4);
param_aabs24.s4 = Xfit_aabs24(:, 5);

data_aabs24 = online_simulation_compare(data, param_aabs24);

%% bp

param_bp = [];
param_bp.beta = Xfit_bp(:, 1);
param_bp.p = Xfit_bp(:, 2);

data_bp = online_simulation_compare(data, param_bp);

%% a0bs1_p

param_a0bs1_p = [];
param_a0bs1_p.alpha_positive = Xfit_a0bs1_p(:, 1);
param_a0bs1_p.beta = Xfit_a0bs1_p(:, 2);
param_a0bs1_p.s1 = Xfit_a0bs1_p(:, 3);

data_a0bs1_p = online_simulation_compare_p(data, param_a0bs1_p);

%% a0bs2_p

param_a0bs2_p = [];
param_a0bs2_p.alpha_positive = Xfit_a0bs2_p(:, 1);
param_a0bs2_p.beta = Xfit_a0bs2_p(:, 2);
param_a0bs2_p.s2 = Xfit_a0bs2_p(:, 3);

data_a0bs2_p = online_simulation_compare_p(data, param_a0bs2_p);

%% a0bs3_p

param_a0bs3_p = [];
param_a0bs3_p.alpha_positive = Xfit_a0bs3_p(:, 1);
param_a0bs3_p.beta = Xfit_a0bs3_p(:, 2);
param_a0bs3_p.s3 = Xfit_a0bs3_p(:, 3);

data_a0bs3_p = online_simulation_compare_p(data, param_a0bs3_p);

%% a0bs4_p

param_a0bs4_p = [];
param_a0bs4_p.alpha_positive = Xfit_a0bs4_p(:, 1);
param_a0bs4_p.beta = Xfit_a0bs4_p(:, 2);
param_a0bs4_p.s4 = Xfit_a0bs4_p(:, 3);

data_a0bs4_p = online_simulation_compare_p(data, param_a0bs4_p);

%% a0bs24_p

param_a0bs24_p = [];
param_a0bs24_p.alpha_positive = Xfit_a0bs24_p(:, 1);
param_a0bs24_p.beta = Xfit_a0bs24_p(:, 2);
param_a0bs24_p.s2 = Xfit_a0bs24_p(:, 3);
param_a0bs24_p.s4 = Xfit_a0bs24_p(:, 4);

data_a0bs24_p = online_simulation_compare_p(data, param_a0bs24_p);

%% a0bs124_p

param_a0bs124_p = [];
param_a0bs124_p.alpha_positive = Xfit_a0bs124_p(:, 1);
param_a0bs124_p.beta = Xfit_a0bs124_p(:, 2);
param_a0bs124_p.s1 = Xfit_a0bs124_p(:, 3);
param_a0bs124_p.s2 = Xfit_a0bs124_p(:, 4);
param_a0bs124_p.s4 = Xfit_a0bs124_p(:, 5);

data_a0bs124_p = online_simulation_compare_p(data, param_a0bs124_p);

%% a0bs234_p

param_a0bs234_p = [];
param_a0bs234_p.alpha_positive = Xfit_a0bs234_p(:, 1);
param_a0bs234_p.beta = Xfit_a0bs234_p(:, 2);
param_a0bs234_p.s2 = Xfit_a0bs234_p(:, 3);
param_a0bs234_p.s3 = Xfit_a0bs234_p(:, 4);
param_a0bs234_p.s4 = Xfit_a0bs234_p(:, 5);

data_a0bs234_p = online_simulation_compare_p(data, param_a0bs234_p);

%% a0bs1234_p

param_a0bs1234_p = [];
param_a0bs1234_p.alpha_positive = Xfit_a0bs1234_p(:, 1);
param_a0bs1234_p.beta = Xfit_a0bs1234_p(:, 2);
param_a0bs1234_p.s1 = Xfit_a0bs1234_p(:, 3);
param_a0bs1234_p.s2 = Xfit_a0bs1234_p(:, 4);
param_a0bs1234_p.s3 = Xfit_a0bs1234_p(:, 5);
param_a0bs1234_p.s4 = Xfit_a0bs1234_p(:, 6);

data_a0bs1234_p = online_simulation_compare_p(data, param_a0bs1234_p);

%% abs24_p

param_abs24_p = [];
param_abs24_p.alpha = Xfit_abs24_p(:, 1);
param_abs24_p.beta = Xfit_abs24_p(:, 2);
param_abs24_p.s2 = Xfit_abs24_p(:, 3);
param_abs24_p.s4 = Xfit_abs24_p(:, 4);

data_abs24_p = online_simulation_compare_p(data, param_abs24_p);

%% aabs24_p

param_aabs24_p = [];
param_aabs24_p.alpha_positive = Xfit_aabs24_p(:, 1);
param_aabs24_p.alpha_negative = Xfit_aabs24_p(:, 2);
param_aabs24_p.beta = Xfit_aabs24_p(:, 3);
param_aabs24_p.s2 = Xfit_aabs24_p(:, 4);
param_aabs24_p.s4 = Xfit_aabs24_p(:, 5);

data_aabs24_p = online_simulation_compare_p(data, param_aabs24_p);

%% a0bp_p

param_a0bp_p = [];
param_a0bp_p.alpha_positive = Xfit_a0bp_p(:, 1);
param_a0bp_p.beta = Xfit_a0bp_p(:, 2);
param_a0bp_p.p = Xfit_a0bp_p(:, 3);

data_a0bp_p = online_simulation_compare_p(data, param_a0bp_p);

%% a0bs124

param_a0bs124 = [];
param_a0bs124.alpha_positive = Xfit_a0bs124(:, 1);
param_a0bs124.beta = Xfit_a0bs124(:, 2);
param_a0bs124.s1 = Xfit_a0bs124(:, 3);
param_a0bs124.s2 = Xfit_a0bs124(:, 4);
param_a0bs124.s4 = Xfit_a0bs124(:, 5);

data_a0bs124 = online_simulation_compare(data, param_a0bs124);

%% a0bs234

param_a0bs234 = [];
param_a0bs234.alpha_positive = Xfit_a0bs234(:, 1);
param_a0bs234.beta = Xfit_a0bs234(:, 2);
param_a0bs234.s2 = Xfit_a0bs234(:, 3);
param_a0bs234.s3 = Xfit_a0bs234(:, 4);
param_a0bs234.s4 = Xfit_a0bs234(:, 5);

data_a0bs234 = online_simulation_compare(data, param_a0bs234);

%% a0bs1234

param_a0bs1234 = [];
param_a0bs1234.alpha_positive = Xfit_a0bs1234(:, 1);
param_a0bs1234.beta = Xfit_a0bs1234(:, 2);
param_a0bs1234.s1 = Xfit_a0bs1234(:, 3);
param_a0bs1234.s2 = Xfit_a0bs1234(:, 4);
param_a0bs1234.s3 = Xfit_a0bs1234(:, 5);
param_a0bs1234.s4 = Xfit_a0bs1234(:, 6);

data_a0bs1234 = online_simulation_compare(data, param_a0bs1234);

%% a0bs1134 (simulation looks ok)

param_a0bs1134 = [];
param_a0bs1134.alpha_positive = Xfit_a0bs1134(:, 1);
param_a0bs1134.beta = Xfit_a0bs1134(:, 2);
param_a0bs1134.s1 = Xfit_a0bs1134(:, 3);
param_a0bs1134.s2 = -param_a0bs1134.s1;
param_a0bs1134.s3 = Xfit_a0bs1134(:, 4);
param_a0bs1134.s4 = Xfit_a0bs1134(:, 5);

data_a0bs1134 = online_simulation_compare(data, param_a0bs1134);

%% a0bs1214 (simulation looks ok)

param_a0bs1214 = [];
param_a0bs1214.alpha_positive = Xfit_a0bs1214(:, 1);
param_a0bs1214.beta = Xfit_a0bs1214(:, 2);
param_a0bs1214.s1 = Xfit_a0bs1214(:, 3);
param_a0bs1214.s2 = Xfit_a0bs1214(:, 4);
param_a0bs1214.s3 = -param_a0bs1214.s1;
param_a0bs1214.s4 = Xfit_a0bs1214(:, 5);

data_a0bs1214 = online_simulation_compare(data, param_a0bs1214);

%% a0bs1231 (simulation looks ok)

param_a0bs1231 = [];
param_a0bs1231.alpha_positive = Xfit_a0bs1231(:, 1);
param_a0bs1231.beta = Xfit_a0bs1231(:, 2);
param_a0bs1231.s1 = Xfit_a0bs1231(:, 3);
param_a0bs1231.s2 = Xfit_a0bs1231(:, 4);
param_a0bs1231.s3 = Xfit_a0bs1231(:, 5);
param_a0bs1231.s4 = -param_a0bs1231.s1;

data_a0bs1231 = online_simulation_compare(data, param_a0bs1231);

%% a0bs1224 (simulation looks ok)

param_a0bs1224 = [];
param_a0bs1224.alpha_positive = Xfit_a0bs1224(:, 1);
param_a0bs1224.beta = Xfit_a0bs1224(:, 2);
param_a0bs1224.s1 = Xfit_a0bs1224(:, 3);
param_a0bs1224.s2 = Xfit_a0bs1224(:, 4);
param_a0bs1224.s3 = param_a0bs1224.s2;
param_a0bs1224.s4 = Xfit_a0bs1224(:, 5);

data_a0bs1224 = online_simulation_compare(data, param_a0bs1224);

%% a0bs1232 (simulation looks ok)

param_a0bs1232 = [];
param_a0bs1232.alpha_positive = Xfit_a0bs1232(:, 1);
param_a0bs1232.beta = Xfit_a0bs1232(:, 2);
param_a0bs1232.s1 = Xfit_a0bs1232(:, 3);
param_a0bs1232.s2 = Xfit_a0bs1232(:, 4);
param_a0bs1232.s3 = Xfit_a0bs1232(:, 5);
param_a0bs1232.s4 = param_a0bs1232.s2;

data_a0bs1232 = online_simulation_compare(data, param_a0bs1232);
set(gca,'fontsize',14)
xlabel('trial number')
ylabel('P(Correct)')
%% a0bs1233 (simulation looks ok)

param_a0bs1233 = [];
param_a0bs1233.alpha_positive = Xfit_a0bs1233(:, 1);
param_a0bs1233.beta = Xfit_a0bs1233(:, 2);
param_a0bs1233.s1 = Xfit_a0bs1233(:, 3);
param_a0bs1233.s2 = Xfit_a0bs1233(:, 4);
param_a0bs1233.s3 = Xfit_a0bs1233(:, 5);
param_a0bs1233.s4 = param_a0bs1233.s3;

data_a0bs1233 = online_simulation_compare(data, param_a0bs1233);

%% a0bs1222

param_a0bs1222 = [];
param_a0bs1222.alpha_positive = Xfit_a0bs1222(:, 1);
param_a0bs1222.beta = Xfit_a0bs1222(:, 2);
param_a0bs1222.s1 = Xfit_a0bs1222(:, 3);
param_a0bs1222.s2 = Xfit_a0bs1222(:, 4);
param_a0bs1222.s3 = param_a0bs1222.s2;
param_a0bs1222.s4 = param_a0bs1222.s2;

data_a0bs1222 = online_simulation_compare(data, param_a0bs1222);

%% a0bs1202

param_a0bs1202 = [];
param_a0bs1202.alpha_positive = Xfit_a0bs1202(:, 1);
param_a0bs1202.beta = Xfit_a0bs1202(:, 2);
param_a0bs1202.s1 = Xfit_a0bs1202(:, 3);
param_a0bs1202.s2 = Xfit_a0bs1202(:, 4);
param_a0bs1202.s3 = zeros(num_sess, 1);
param_a0bs1202.s4 = param_a0bs1202.s2;

data_a0bs1202 = online_simulation_compare(data, param_a0bs1202);

%% a0bs0232

param_a0bs0232 = [];
param_a0bs0232.alpha_positive = Xfit_a0bs0232(:, 1);
param_a0bs0232.beta = Xfit_a0bs0232(:, 2);
param_a0bs0232.s1 = zeros(num_sess, 1);
param_a0bs0232.s2 = Xfit_a0bs0232(:, 3);
param_a0bs0232.s3 = Xfit_a0bs0232(:, 4);
param_a0bs0232.s4 = param_a0bs0232.s2;

data_a0bs0232 = online_simulation_compare(data, param_a0bs0232);









