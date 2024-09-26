% This script is used to combine the results of all four datasets together
% In particular, we only consider the winning model of all four datasets:
% A0BS1232.

clear
clc

% We also add two columns to the data package: sex and ns

% Each time we load a new dataset, we concatenate the params and the data
% package

load('~/Dropbox/Jimmy/RLWM_mice_new/modeling/maximum_likelihood/saved_res/ml_res_male_ns2.mat');
params = Xfit_a0bs1232;

[reg_repeat, ~, ~] = repeat_nrepeat_common_reg(data, 'mice');
[reg_reward, ~, ~] = reward_nreward_common_reg(data, 'mice');
reg_trial_back = trial_back_reg(data, 'mice');

perf = perf_iter(data);
mean_perf = nanmean(perf(:, 1:200), 2);

% Add sex and ns

num_sess = length(data.s);
data.sex = ones(num_sess, 1); % 1 = male
data.ns = ones(num_sess, 1); % 1 = ns2

data.t = [data.t, zeros(num_sess, 2)]; % need to pad the transition (i.e. data.t with 2 columns of 0) for ns2
data_all = data; % concatenate data

%% Repeat for the other 3 datasets

load('~/Dropbox/Jimmy/RLWM_mice_new/modeling/maximum_likelihood/saved_res/ml_res_male_ns4.mat');
params = [params; Xfit_a0bs1232];

[temp_reg_repeat, ~, ~] = repeat_nrepeat_common_reg(data, 'mice');
[temp_reg_reward, ~, ~] = reward_nreward_common_reg(data, 'mice');
temp_reg_trial_back = trial_back_reg(data, 'mice');
reg_repeat = [reg_repeat; temp_reg_repeat];
reg_reward = [reg_reward; temp_reg_reward];
reg_trial_back = [reg_trial_back; temp_reg_trial_back];

temp_perf = perf_iter(data);
temp_mean_perf = nanmean(temp_perf(:, 1:200), 2);
mean_perf = [mean_perf; temp_mean_perf];

num_sess = length(data.s);
data.sex = ones(num_sess, 1); % 1 = male
data.ns = 2 * ones(num_sess, 1); % 2 = ns4
data_all.s = [data_all.s; data.s]; % concatenate data
data_all.a = [data_all.a; data.a];
data_all.r = [data_all.r; data.r];
data_all.rt = [data_all.rt; data.rt];
data_all.t = [data_all.t; data.t];
data_all.animal = [data_all.animal; data.animal];
data_all.age = [data_all.age; data.age];
data_all.correction = [data_all.correction; data.correction];
data_all.sex = [data_all.sex; data.sex];
data_all.ns = [data_all.ns; data.ns];

load('~/Dropbox/Jimmy/RLWM_mice_new/modeling/maximum_likelihood/saved_res/ml_res_female_ns2.mat');
params = [params; Xfit_a0bs1232];

[temp_reg_repeat, ~, ~] = repeat_nrepeat_common_reg(data, 'mice');
[temp_reg_reward, ~, ~] = reward_nreward_common_reg(data, 'mice');
temp_reg_trial_back = trial_back_reg(data, 'mice');
reg_repeat = [reg_repeat; temp_reg_repeat];
reg_reward = [reg_reward; temp_reg_reward];
reg_trial_back = [reg_trial_back; temp_reg_trial_back];

temp_perf = perf_iter(data);
temp_mean_perf = nanmean(temp_perf(:, 1:200), 2);
mean_perf = [mean_perf; temp_mean_perf];

num_sess = length(data.s);
data.sex = 2 * ones(num_sess, 1); % 2 = female
data.ns = ones(num_sess, 1); % 1 = ns2
data.t = [data.t, zeros(num_sess, 2)]; % need to pad the transition (i.e. data.t with 2 columns of 0) for ns2
data_all.s = [data_all.s; data.s]; % concatenate data
data_all.a = [data_all.a; data.a];
data_all.r = [data_all.r; data.r];
data_all.rt = [data_all.rt; data.rt];
data_all.t = [data_all.t; data.t];
data_all.animal = [data_all.animal; data.animal];
data_all.age = [data_all.age; data.age];
data_all.correction = [data_all.correction; data.correction];
data_all.sex = [data_all.sex; data.sex];
data_all.ns = [data_all.ns; data.ns];

load('~/Dropbox/Jimmy/RLWM_mice_new/modeling/maximum_likelihood/saved_res/ml_res_female_ns4.mat');
params = [params; Xfit_a0bs1232];

[temp_reg_repeat, ~, ~] = repeat_nrepeat_common_reg(data, 'mice');
[temp_reg_reward, ~, ~] = reward_nreward_common_reg(data, 'mice');
temp_reg_trial_back = trial_back_reg(data, 'mice');
reg_repeat = [reg_repeat; temp_reg_repeat];
reg_reward = [reg_reward; temp_reg_reward];
reg_trial_back = [reg_trial_back; temp_reg_trial_back];

temp_perf = perf_iter(data);
temp_mean_perf = nanmean(temp_perf(:, 1:200), 2);
mean_perf = [mean_perf; temp_mean_perf];

num_sess = length(data.s);
data.sex = 2 * ones(num_sess, 1); % 2 = female
data.ns = 2 * ones(num_sess, 1); % 2 = ns4
data_all.s = [data_all.s; data.s]; % concatenate data
data_all.a = [data_all.a; data.a];
data_all.r = [data_all.r; data.r];
data_all.rt = [data_all.rt; data.rt];
data_all.t = [data_all.t; data.t];
data_all.animal = [data_all.animal; data.animal];
data_all.age = [data_all.age; data.age];
data_all.correction = [data_all.correction; data.correction];
data_all.sex = [data_all.sex; data.sex];
data_all.ns = [data_all.ns; data.ns];

%% Save data_all and params

savefile = '~/Dropbox/Jimmy/RLWM_mice_new/modeling/maximum_likelihood/saved_res/ml_res_all.mat';
save(savefile, 'data_all', 'params', 'reg_repeat', 'reg_reward', 'reg_trial_back', 'mean_perf');



