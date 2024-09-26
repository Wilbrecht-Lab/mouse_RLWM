% This script is for generate and recover of mice data
% Let's first start with a0bs24, the base model of all winning models

%% Load data

clear 
clc

load('Z:/Juliana/RL+WM Paper/Jimmy Dropbox/modeling/maximum_likelihood/saved_res/ml_res_male_ns2.mat');
%load('C:\Users\xiali\Dropbox\Jimmy\RLWM_mice_new\modeling\maximum_likelihood\saved_res\ml_res_male_ns2.mat');
data = data_male_ns2;

rng('default')

%% Generate

% a0bs24
param_a0bs24 = [];
param_a0bs24.alpha_positive = Xfit_a0bs24(:, 1);
param_a0bs24.beta = Xfit_a0bs24(:, 2);
param_a0bs24.s2 = Xfit_a0bs24(:, 3);
param_a0bs24.s4 = Xfit_a0bs24(:, 4);

data_a0bs24 = online_simulation_correction(data, param_a0bs24);

% a0bs1234
param_a0bs1234 = [];
param_a0bs1234.alpha_positive = Xfit_a0bs1234(:, 1);
param_a0bs1234.beta = Xfit_a0bs1234(:, 2);
param_a0bs1234.s1 = Xfit_a0bs1234(:, 3);
param_a0bs1234.s2 = Xfit_a0bs1234(:, 4);
param_a0bs1234.s3 = Xfit_a0bs1234(:, 5);
param_a0bs1234.s4 = Xfit_a0bs1234(:, 6);

data_a0bs1234 = online_simulation_correction(data, param_a0bs1234);

%% Recover

% a0bs24
Xfit_a0bs24_recover = nan(num_sess, 4);
ll_a0bs24_recover = nan(num_sess, 1);
BIC_a0bs24_recover = nan(num_sess, 1);
idx_a0bs24_recover = nan(num_sess, 1);

% a0bs1234
Xfit_a0bs1234_recover = nan(num_sess, 6);
ll_a0bs1234_recover = nan(num_sess, 1);
BIC_a0bs1234_recover = nan(num_sess, 1);
idx_a0bs1234_recover = nan(num_sess, 1);

for sess = 1:num_sess
    [Xfit_a0bs24_recover(sess, :), ll_a0bs24_recover(sess), BIC_a0bs24_recover(sess), idx_a0bs24_recover(sess)] = fit_a0bs24(data_a0bs24.s{sess}, data_a0bs24.a{sess}, data_a0bs24.r{sess}, num_iter);
    [Xfit_a0bs1234_recover(sess, :), ll_a0bs1234_recover(sess), BIC_a0bs1234_recover(sess), idx_a0bs1234_recover(sess)] = fit_a0bs1234(data_a0bs1234.s{sess}, data_a0bs1234.a{sess}, data_a0bs1234.r{sess}, num_iter);
end

