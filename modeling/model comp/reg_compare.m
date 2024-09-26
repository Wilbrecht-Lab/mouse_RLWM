% This script is used to compare the regression results of the mice data
% and model simulations

clear
clc

load('~/Dropbox/Jimmy/RLWM_mice_new/modeling/maximum_likelihood/saved_res/ml_res_male_ns2.mat');
data = data_male_ns2;

rng('default')

%% mice

[regression_coeff_repeat_mice, corr_map_repeat_mice, repeat_proportion_mice] = repeat_nrepeat_common_reg(data, 'mice');
[regression_coeff_reward_mice, corr_map_reward_mice, reward_proportion_mice] = reward_nreward_common_reg(data, 'mice');

%% ab (no perseveration)

param_ab = [];
param_ab.alpha = Xfit_ab(:, 1);
param_ab.beta = Xfit_ab(:, 2);

data_ab = online_simulation_correction(data, param_ab);
repeat_nrepeat_common_reg(data_ab, 'ab');
reward_nreward_common_reg(data_ab, 'ab');

%% a0b (no perseveration)

param_a0b = [];
param_a0b.alpha_positive = Xfit_a0b(:, 1);
param_a0b.beta = Xfit_a0b(:, 2);

data_a0b = online_simulation_correction(data, param_a0b);
repeat_nrepeat_common_reg(data_a0b, 'a0b');
reward_nreward_common_reg(data_a0b, 'a0b');

%% aab (no perseveration)

param_aab = [];
param_aab.alpha_positive = Xfit_aab(:, 1);
param_aab.alpha_negative = Xfit_aab(:, 2);
param_aab.beta = Xfit_aab(:, 3);

data_aab = online_simulation_correction(data, param_aab);
repeat_nrepeat_common_reg(data_aab, 'aab');
reward_nreward_common_reg(data_aab, 'aab');

%% abf (one possibility, but perseveration too little, also graded trial-back effect)

param_abf = [];
param_abf.alpha = Xfit_abf(:, 1);
param_abf.beta = Xfit_abf(:, 2);
param_abf.forget = Xfit_abf(:, 3);

data_abf = online_simulation_correction(data, param_abf);
repeat_nrepeat_common_reg(data_abf, 'abf');
reward_nreward_common_reg(data_abf, 'abf');

%% a0bf (ok for repeating, but not perseverating for non-repeating trials? graded trial-back effect)

param_a0bf = [];
param_a0bf.alpha_positive = Xfit_a0bf(:, 1);
param_a0bf.beta = Xfit_a0bf(:, 2);
param_a0bf.forget = Xfit_a0bf(:, 3);

data_a0bf = online_simulation_correction(data, param_a0bf);
repeat_nrepeat_common_reg(data_a0bf, 'a0bf');
reward_nreward_common_reg(data_a0bf, 'a0bf');

%% aabf (similar to a0bf)

param_aabf = [];
param_aabf.alpha_positive = Xfit_aabf(:, 1);
param_aabf.alpha_negative = Xfit_aabf(:, 2);
param_aabf.beta = Xfit_aabf(:, 3);
param_aabf.forget = Xfit_aabf(:, 4);

data_aabf = online_simulation_correction(data, param_aabf);
repeat_nrepeat_common_reg(data_aabf, 'aabf');
reward_nreward_common_reg(data_aabf, 'aabf');

%% a0bs1 (wrong direction, no 1-trial-back effect)

param_a0bs1 = [];
param_a0bs1.alpha_positive = Xfit_a0bs1(:, 1);
param_a0bs1.beta = Xfit_a0bs1(:, 2);
param_a0bs1.s1 = Xfit_a0bs1(:, 3);

data_a0bs1 = online_simulation_correction(data, param_a0bs1);
repeat_nrepeat_common_reg(data_a0bs1, 'a0bs1');
reward_nreward_common_reg(data_a0bs1, 'a0bs1');

%% a0bs2 (ok for not rewarded non-repeating trials, graded trial-back effect)

param_a0bs2 = [];
param_a0bs2.alpha_positive = Xfit_a0bs2(:, 1);
param_a0bs2.beta = Xfit_a0bs2(:, 2);
param_a0bs2.s2 = Xfit_a0bs2(:, 3);

data_a0bs2 = online_simulation_correction(data, param_a0bs2);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs2, 'a0bs2');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs2, 'a0bs2');

%% a0bs3 (wrong direction, no 1-trial-back effect)

param_a0bs3 = [];
param_a0bs3.alpha_positive = Xfit_a0bs3(:, 1);
param_a0bs3.beta = Xfit_a0bs3(:, 2);
param_a0bs3.s3 = Xfit_a0bs3(:, 3);

data_a0bs3 = online_simulation_correction(data, param_a0bs3);
repeat_nrepeat_common_reg(data_a0bs3, 'a0bs3');
reward_nreward_common_reg(data_a0bs3, 'a0bs3');

%% a0bs4 (ok for repeating previously rewarded trials, little 1-trial-back effect)

param_a0bs4 = [];
param_a0bs4.alpha_positive = Xfit_a0bs4(:, 1);
param_a0bs4.beta = Xfit_a0bs4(:, 2);
param_a0bs4.s4 = Xfit_a0bs4(:, 3);

data_a0bs4 = online_simulation_correction(data, param_a0bs4);
repeat_nrepeat_common_reg(data_a0bs4, 'a0bs4');
reward_nreward_common_reg(data_a0bs4, 'a0bs4');

%% a0bp (looks very close to mice regression results, but orders of magnitude for learning too small)

param_a0bp = [];
param_a0bp.alpha_positive = Xfit_a0bp(:, 1);
param_a0bp.beta = Xfit_a0bp(:, 2);
param_a0bp.p = Xfit_a0bp(:, 3);

data_a0bp = online_simulation_correction(data, param_a0bp);
repeat_nrepeat_common_reg(data_a0bp, 'a0bp');
reward_nreward_common_reg(data_a0bp, 'a0bp');

%% a0bwm

param_a0bwm = [];
param_a0bwm.alpha_positive = Xfit_a0bwm(:, 1);
param_a0bwm.beta = Xfit_a0bwm(:, 2);
param_a0bwm.wm = Xfit_a0bwm(:, 3);

data_a0bwm = online_simulation_correction(data, param_a0bwm);
repeat_nrepeat_common_reg(data_a0bwm, 'a0bwm');
reward_nreward_common_reg(data_a0bwm, 'a0bwm');

%% a0bs24 (looks the best so far, but still 2-trial-back not 0)

param_a0bs24 = [];
param_a0bs24.alpha_positive = Xfit_a0bs24(:, 1);
param_a0bs24.beta = Xfit_a0bs24(:, 2);
param_a0bs24.s2 = Xfit_a0bs24(:, 3);
param_a0bs24.s4 = Xfit_a0bs24(:, 4);

% data_a0bs24 = online_simulation_correction(data, param_a0bs24);
data_a0bs24 = online_simulation(data, param_a0bs24);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs24, 'a0bs24');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs24, 'a0bs24');

%% a0bs123

param_a0bs123 = [];
param_a0bs123.alpha_positive = Xfit_a0bs123(:, 1);
param_a0bs123.beta = Xfit_a0bs123(:, 2);
param_a0bs123.s1 = Xfit_a0bs123(:, 3);
param_a0bs123.s2 = Xfit_a0bs123(:, 4);
param_a0bs123.s3 = Xfit_a0bs123(:, 5);

data_a0bs123 = online_simulation_correction(data, param_a0bs123);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs123, 'a0bs123');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs123, 'a0bs123');

%% a0bs124

param_a0bs124 = [];
param_a0bs124.alpha_positive = Xfit_a0bs124(:, 1);
param_a0bs124.beta = Xfit_a0bs124(:, 2);
param_a0bs124.s1 = Xfit_a0bs124(:, 3);
param_a0bs124.s2 = Xfit_a0bs124(:, 4);
param_a0bs124.s4 = Xfit_a0bs124(:, 5);

data_a0bs124 = online_simulation_correction(data, param_a0bs124);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs124, 'a0bs124');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs124, 'a0bs124');

%% a0bs234

param_a0bs234 = [];
param_a0bs234.alpha_positive = Xfit_a0bs234(:, 1);
param_a0bs234.beta = Xfit_a0bs234(:, 2);
param_a0bs234.s2 = Xfit_a0bs234(:, 3);
param_a0bs234.s3 = Xfit_a0bs234(:, 4);
param_a0bs234.s4 = Xfit_a0bs234(:, 5);

data_a0bs234 = online_simulation_correction(data, param_a0bs234);
repeat_nrepeat_common_reg(data_a0bs234, 'a0bs234');
reward_nreward_common_reg(data_a0bs234, 'a0bs234');

%% a0bs1234

param_a0bs1234 = [];
param_a0bs1234.alpha_positive = Xfit_a0bs1234(:, 1);
param_a0bs1234.beta = Xfit_a0bs1234(:, 2);
param_a0bs1234.s1 = Xfit_a0bs1234(:, 3);
param_a0bs1234.s2 = Xfit_a0bs1234(:, 4);
param_a0bs1234.s3 = Xfit_a0bs1234(:, 5);
param_a0bs1234.s4 = Xfit_a0bs1234(:, 6);

% data_a0bs1234 = online_simulation_correction(data, param_a0bs1234);
data_a0bs1234 = online_simulation(data, param_a0bs1234);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs1234, 'a0bs1234');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs1234, 'a0bs1234');

%% abs24

param_abs24 = [];
param_abs24.alpha = Xfit_abs24(:, 1);
param_abs24.beta = Xfit_abs24(:, 2);
param_abs24.s2 = Xfit_abs24(:, 3);
param_abs24.s4 = Xfit_abs24(:, 4);

data_abs24 = online_simulation_correction(data, param_abs24);
repeat_nrepeat_common_reg(data_abs24, 'abs24');
reward_nreward_common_reg(data_abs24, 'abs24');

%% aabs24

param_aabs24 = [];
param_aabs24.alpha_positive = Xfit_aabs24(:, 1);
param_aabs24.alpha_negative = Xfit_aabs24(:, 2);
param_aabs24.beta = Xfit_aabs24(:, 3);
param_aabs24.s2 = Xfit_aabs24(:, 4);
param_aabs24.s4 = Xfit_aabs24(:, 5);

data_aabs24 = online_simulation_correction(data, param_aabs24);
repeat_nrepeat_common_reg(data_aabs24, 'aabs24');
reward_nreward_common_reg(data_aabs24, 'aabs24');

%% bp

param_bp = [];
param_bp.beta = Xfit_bp(:, 1);
param_bp.p = Xfit_bp(:, 2);

data_bp = online_simulation_correction(data, param_bp);
repeat_nrepeat_common_reg(data_bp, 'bp');
reward_nreward_common_reg(data_bp, 'bp');

%% a0bs1_p

param_a0bs1_p = [];
param_a0bs1_p.alpha_positive = Xfit_a0bs1_p(:, 1);
param_a0bs1_p.beta = Xfit_a0bs1_p(:, 2);
param_a0bs1_p.s1 = Xfit_a0bs1_p(:, 3);

data_a0bs1_p = online_simulation_correction_p(data, param_a0bs1_p);
repeat_nrepeat_common_reg(data_a0bs1_p, 'a0bs1_p');
reward_nreward_common_reg(data_a0bs1_p, 'a0bs1_p');

%% a0bs2_p

param_a0bs2_p = [];
param_a0bs2_p.alpha_positive = Xfit_a0bs2_p(:, 1);
param_a0bs2_p.beta = Xfit_a0bs2_p(:, 2);
param_a0bs2_p.s2 = Xfit_a0bs2_p(:, 3);

data_a0bs2_p = online_simulation_correction_p(data, param_a0bs2_p);
repeat_nrepeat_common_reg(data_a0bs2_p, 'a0bs2_p');
reward_nreward_common_reg(data_a0bs2_p, 'a0bs2_p');

%% a0bs3_p

param_a0bs3_p = [];
param_a0bs3_p.alpha_positive = Xfit_a0bs3_p(:, 1);
param_a0bs3_p.beta = Xfit_a0bs3_p(:, 2);
param_a0bs3_p.s3 = Xfit_a0bs3_p(:, 3);

data_a0bs3_p = online_simulation_correction_p(data, param_a0bs3_p);
repeat_nrepeat_common_reg(data_a0bs3_p, 'a0bs3_p');
reward_nreward_common_reg(data_a0bs3_p, 'a0bs3_p');

%% a0bs4_p

param_a0bs4_p = [];
param_a0bs4_p.alpha_positive = Xfit_a0bs4_p(:, 1);
param_a0bs4_p.beta = Xfit_a0bs4_p(:, 2);
param_a0bs4_p.s4 = Xfit_a0bs4_p(:, 3);

data_a0bs4_p = online_simulation_correction_p(data, param_a0bs4_p);
repeat_nrepeat_common_reg(data_a0bs4_p, 'a0bs4_p');
reward_nreward_common_reg(data_a0bs4_p, 'a0bs4_p');

%% a0bp_p

param_a0bp_p = [];
param_a0bp_p.alpha_positive = Xfit_a0bp_p(:, 1);
param_a0bp_p.beta = Xfit_a0bp_p(:, 2);
param_a0bp_p.p = Xfit_a0bp_p(:, 3);

data_a0bp_p = online_simulation_correction_p(data, param_a0bp_p);
repeat_nrepeat_common_reg(data_a0bp_p, 'a0bp_p');
reward_nreward_common_reg(data_a0bp_p, 'a0bp_p');

%% a0bs24_p (seems to have fix the issue of difference in the reward history regression)

param_a0bs24_p = [];
param_a0bs24_p.alpha_positive = Xfit_a0bs24_p(:, 1);
param_a0bs24_p.beta = Xfit_a0bs24_p(:, 2);
param_a0bs24_p.s2 = Xfit_a0bs24_p(:, 3);
param_a0bs24_p.s4 = Xfit_a0bs24_p(:, 4);

data_a0bs24_p = online_simulation_correction_p(data, param_a0bs24_p);
repeat_nrepeat_common_reg(data_a0bs24_p, 'a0bs24_p');
reward_nreward_common_reg(data_a0bs24_p, 'a0bs24_p');

%% a0bs124_p 

clc
param_a0bs124_p = [];
param_a0bs124_p.alpha_positive = Xfit_a0bs124_p(:, 1);
param_a0bs124_p.beta = Xfit_a0bs124_p(:, 2);
param_a0bs124_p.s1 = Xfit_a0bs124_p(:, 3);
param_a0bs124_p.s2 = Xfit_a0bs124_p(:, 4);
param_a0bs124_p.s4 = Xfit_a0bs124_p(:, 5);

data_a0bs124_p = online_simulation_correction_p(data, param_a0bs124_p);
repeat_nrepeat_common_reg(data_a0bs124_p, 'a0bs124_p');
reward_nreward_common_reg(data_a0bs124_p, 'a0bs124_p');

%% a0bs234_p 

clc
param_a0bs234_p = [];
param_a0bs234_p.alpha_positive = Xfit_a0bs234_p(:, 1);
param_a0bs234_p.beta = Xfit_a0bs234_p(:, 2);
param_a0bs234_p.s2 = Xfit_a0bs234_p(:, 3);
param_a0bs234_p.s3 = Xfit_a0bs234_p(:, 4);
param_a0bs234_p.s4 = Xfit_a0bs234_p(:, 5);

data_a0bs234_p = online_simulation_correction_p(data, param_a0bs234_p);
repeat_nrepeat_common_reg(data_a0bs234_p, 'a0bs234_p');
reward_nreward_common_reg(data_a0bs234_p, 'a0bs234_p');

%% a0bs1234_p 

clc
param_a0bs1234_p = [];
param_a0bs1234_p.alpha_positive = Xfit_a0bs1234_p(:, 1);
param_a0bs1234_p.beta = Xfit_a0bs1234_p(:, 2);
param_a0bs1234_p.s1 = Xfit_a0bs1234_p(:, 3);
param_a0bs1234_p.s2 = Xfit_a0bs1234_p(:, 4);
param_a0bs1234_p.s3 = Xfit_a0bs1234_p(:, 5);
param_a0bs1234_p.s4 = Xfit_a0bs1234_p(:, 6);

data_a0bs1234_p = online_simulation_correction_p(data, param_a0bs1234_p);
repeat_nrepeat_common_reg(data_a0bs1234_p, 'a0bs1234_p');
reward_nreward_common_reg(data_a0bs1234_p, 'a0bs1234_p');

%% abs24_p

param_abs24_p = [];
param_abs24_p.alpha = Xfit_abs24_p(:, 1);
param_abs24_p.beta = Xfit_abs24_p(:, 2);
param_abs24_p.s2 = Xfit_abs24_p(:, 3);
param_abs24_p.s4 = Xfit_abs24_p(:, 4);

data_abs24_p = online_simulation_correction_p(data, param_abs24_p);
repeat_nrepeat_common_reg(data_abs24_p, 'abs24_p');
reward_nreward_common_reg(data_abs24_p, 'abs24_p');

%% aabs24_p

param_aabs24_p = [];
param_aabs24_p.alpha_positive = Xfit_aabs24_p(:, 1);
param_aabs24_p.alpha_negative = Xfit_aabs24_p(:, 2);
param_aabs24_p.beta = Xfit_aabs24_p(:, 3);
param_aabs24_p.s2 = Xfit_aabs24_p(:, 4);
param_aabs24_p.s4 = Xfit_aabs24_p(:, 5);

data_aabs24_p = online_simulation_correction_p(data, param_aabs24_p);
repeat_nrepeat_common_reg(data_aabs24_p, 'aabs24_p');
reward_nreward_common_reg(data_aabs24_p, 'aabs24_p');

%% a0bs1134

param_a0bs1134 = [];
param_a0bs1134.alpha_positive = Xfit_a0bs1134(:, 1);
param_a0bs1134.beta = Xfit_a0bs1134(:, 2);
param_a0bs1134.s1 = Xfit_a0bs1134(:, 3);
param_a0bs1134.s2 = -param_a0bs1134.s1;
param_a0bs1134.s3 = Xfit_a0bs1134(:, 4);
param_a0bs1134.s4 = Xfit_a0bs1134(:, 5);

% data_a0bs1134 = online_simulation_correction(data, param_a0bs1134);
data_a0bs1134 = online_simulation(data, param_a0bs1134);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs1134, 'a0bs1134');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs1134, 'a0bs1134');

%% a0bs1214

param_a0bs1214 = [];
param_a0bs1214.alpha_positive = Xfit_a0bs1214(:, 1);
param_a0bs1214.beta = Xfit_a0bs1214(:, 2);
param_a0bs1214.s1 = Xfit_a0bs1214(:, 3);
param_a0bs1214.s2 = Xfit_a0bs1214(:, 4);
param_a0bs1214.s3 = -param_a0bs1214.s1;
param_a0bs1214.s4 = Xfit_a0bs1214(:, 5);

% data_a0bs1214 = online_simulation_correction(data, param_a0bs1214);
data_a0bs1214 = online_simulation(data, param_a0bs1214);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs1214, 'a0bs1214');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs1214, 'a0bs1214');

%% a0bs1231

param_a0bs1231 = [];
param_a0bs1231.alpha_positive = Xfit_a0bs1231(:, 1);
param_a0bs1231.beta = Xfit_a0bs1231(:, 2);
param_a0bs1231.s1 = Xfit_a0bs1231(:, 3);
param_a0bs1231.s2 = Xfit_a0bs1231(:, 4);
param_a0bs1231.s3 = Xfit_a0bs1231(:, 5);
param_a0bs1231.s4 = -param_a0bs1231.s1;

% data_a0bs1231 = online_simulation_correction(data, param_a0bs1231);
data_a0bs1231 = online_simulation(data, param_a0bs1231);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs1231, 'a0bs1231');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs1231, 'a0bs1231');

%% a0bs1224

param_a0bs1224 = [];
param_a0bs1224.alpha_positive = Xfit_a0bs1224(:, 1);
param_a0bs1224.beta = Xfit_a0bs1224(:, 2);
param_a0bs1224.s1 = Xfit_a0bs1224(:, 3);
param_a0bs1224.s2 = Xfit_a0bs1224(:, 4);
param_a0bs1224.s3 = param_a0bs1224.s2;
param_a0bs1224.s4 = Xfit_a0bs1224(:, 5);

% data_a0bs1224 = online_simulation_correction(data, param_a0bs1224);
data_a0bs1224 = online_simulation(data, param_a0bs1224);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs1224, 'a0bs1224');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs1224, 'a0bs1224');

%% a0bs1232

param_a0bs1232 = [];
param_a0bs1232.alpha_positive = Xfit_a0bs1232(:, 1);
param_a0bs1232.beta = Xfit_a0bs1232(:, 2);
param_a0bs1232.s1 = Xfit_a0bs1232(:, 3);
param_a0bs1232.s2 = Xfit_a0bs1232(:, 4);
param_a0bs1232.s3 = Xfit_a0bs1232(:, 5);
param_a0bs1232.s4 = param_a0bs1232.s2;

% data_a0bs1232 = online_simulation_correction(data, param_a0bs1232);
data_a0bs1232 = online_simulation(data, param_a0bs1232);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs1232, 'a0bs1232');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs1232, 'a0bs1232');

%% a0bs1233

param_a0bs1233 = [];
param_a0bs1233.alpha_positive = Xfit_a0bs1233(:, 1);
param_a0bs1233.beta = Xfit_a0bs1233(:, 2);
param_a0bs1233.s1 = Xfit_a0bs1233(:, 3);
param_a0bs1233.s2 = Xfit_a0bs1233(:, 4);
param_a0bs1233.s3 = Xfit_a0bs1233(:, 5);
param_a0bs1233.s4 = param_a0bs1233.s3;

% data_a0bs1233 = online_simulation_correction(data, param_a0bs1233);
data_a0bs1233 = online_simulation(data, param_a0bs1233);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs1233, 'a0bs1233');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs1233, 'a0bs1233');

%% a0bs1222

param_a0bs1222 = [];
param_a0bs1222.alpha_positive = Xfit_a0bs1222(:, 1);
param_a0bs1222.beta = Xfit_a0bs1222(:, 2);
param_a0bs1222.s1 = Xfit_a0bs1222(:, 3);
param_a0bs1222.s2 = Xfit_a0bs1222(:, 4);
param_a0bs1222.s3 = param_a0bs1222.s2;
param_a0bs1222.s4 = param_a0bs1222.s2;

data_a0bs1222 = online_simulation_correction(data, param_a0bs1222);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs1222, 'a0bs1222');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs1222, 'a0bs1222');

%% a0bs1202

param_a0bs1202 = [];
param_a0bs1202.alpha_positive = Xfit_a0bs1202(:, 1);
param_a0bs1202.beta = Xfit_a0bs1202(:, 2);
param_a0bs1202.s1 = Xfit_a0bs1202(:, 3);
param_a0bs1202.s2 = Xfit_a0bs1202(:, 4);
param_a0bs1202.s3 = zeros(num_sess, 1);
param_a0bs1202.s4 = param_a0bs1202.s2;

% data_a0bs1202 = online_simulation_correction(data, param_a0bs1202);
data_a0bs1202 = online_simulation(data, param_a0bs1202);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs1202, 'a0bs1202');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs1202, 'a0bs1202');

%% a0bs0232

param_a0bs0232 = [];
param_a0bs0232.alpha_positive = Xfit_a0bs0232(:, 1);
param_a0bs0232.beta = Xfit_a0bs0232(:, 2);
param_a0bs0232.s1 = zeros(num_sess, 1);
param_a0bs0232.s2 = Xfit_a0bs0232(:, 3);
param_a0bs0232.s3 = Xfit_a0bs0232(:, 4);
param_a0bs0232.s4 = param_a0bs0232.s2;

% data_a0bs0232 = online_simulation_correction(data, param_a0bs0232);
data_a0bs0232 = online_simulation(data, param_a0bs0232);
[regression_coeff_repeat_sim, corr_map_repeat_sim, repeat_proportion_sim] = repeat_nrepeat_common_reg(data_a0bs0232, 'a0bs0232');
[regression_coeff_reward_sim, corr_map_reward_sim, reward_proportion_sim] = reward_nreward_common_reg(data_a0bs0232, 'a0bs0232');

