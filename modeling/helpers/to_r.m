% This script is used to save some variables for using lme4 in R (because
% the results given by MatLab seems to be off in the past). This should be
% done per dataset (male and female, ns2 and ns4).

% We need to store things (to be potentially augmented in the future): age,
% session number, age of the first session, all regression coefficients for
% repeating/nonrepeating analysis, all model parameters for A0B24 and
% A0B24_p.

clear 
clc

load('~/Dropbox/Jimmy/RLWM_mice_new/modeling/maximum_likelihood/saved_res/ml_res_male_ns2.mat');
data = data_male_ns2;

num_sess = length(data.s);

%% regression coefficients

% regression_coeff = repeat_nrepeat_reg(data, 'mice');
% 
% repeat_intercept = squeeze(regression_coeff(1, 1, :));
% repeat_prew = squeeze(regression_coeff(1, 2, :));
% repeat_rl = squeeze(regression_coeff(1, 3, :));
% 
% nrepeat_intercept = squeeze(regression_coeff(2, 1, :));
% nrepeat_prew = squeeze(regression_coeff(2, 2, :));
% nrepeat_rl = squeeze(regression_coeff(2, 3, :));

% [regression_coeff, ~] = anne_reg(data, 'mice');
% intercept = regression_coeff(:, 1);
% one_back = regression_coeff(:, 2);
% one_back_repeat = regression_coeff(:, 3);
% one_back_nrepeat = regression_coeff(:, 4);
% rl = regression_coeff(:, 5);

% [regression_coeff, ~] = reward_nreward_common_reg(data, 'mice');
% intercept = regression_coeff(:, 1);
% one_reward = regression_coeff(:, 2);
% one_back_reward = regression_coeff(:, 3);
% one_back_nreward = regression_coeff(:, 4);
% rl = regression_coeff(:, 5);

%% age and session numbers

[~, ~, animal_idx] = unique(data.animal);
age = data.age;
age_first_sess = nan(num_sess, 1);
sess_num = nan(num_sess, 1); % per mice

for sess = 1:num_sess
    animal = data.animal{sess};
    animal_all_sess_idx = find(strcmp(data.animal, animal) == 1);
    animal_first_sess_idx = animal_all_sess_idx(1);
    age_first_sess(sess) = data.age(animal_first_sess_idx); % get the age of the animal on its first session
    
    sess_num(sess) = find(animal_all_sess_idx == sess); % get the session number (wrt all the sessions the animal completed)
end

%% Include some important regressors

% a0bs24_a = Xfit_a0bs24(:, 1);
% a0bs24_b = Xfit_a0bs24(:, 2);
% a0bs24_s2 = Xfit_a0bs24(:, 3);
% a0bs24_s4 = Xfit_a0bs24(:, 4);
% a0bs24_diff = a0bs24_s4 - a0bs24_s2;
% 
% a0bs1234_a = Xfit_a0bs1234(:, 1);
% a0bs1234_b = Xfit_a0bs1234(:, 2);
% a0bs1234_s1 = Xfit_a0bs1234(:, 3);
% a0bs1234_s2 = Xfit_a0bs1234(:, 4);
% a0bs1234_s3 = Xfit_a0bs1234(:, 5);
% a0bs1234_s4 = Xfit_a0bs1234(:, 6);
% a0bs1234_diff = a0bs1234_s4 - a0bs1234_s2;

a0bs1232_a = Xfit_a0bs1232(:, 1);
a0bs1232_b = Xfit_a0bs1232(:, 2);
a0bs1232_s1 = Xfit_a0bs1232(:, 3);
a0bs1232_s2 = Xfit_a0bs1232(:, 4);
a0bs1232_s3 = Xfit_a0bs1232(:, 5);

%% Check the effect of sex and set size for all 4 datasets (m/f ns2/4)

clear
clc

load('~/Dropbox/Jimmy/RLWM_mice_new/modeling/maximum_likelihood/saved_res/ml_res_all.mat');

[~, ~, animal_idx] = unique(data_all.animal);
num_sess = length(data_all.s);
age = data_all.age;
age_first_sess = nan(num_sess, 1);
sess_num = nan(num_sess, 1); % per mice

for sess = 1:num_sess
    animal = data_all.animal{sess};
    animal_all_sess_idx = find(strcmp(data_all.animal, animal) == 1);
    animal_first_sess_idx = animal_all_sess_idx(1);
    age_first_sess(sess) = data_all.age(animal_first_sess_idx); % get the age of the animal on its first session
    
    sess_num(sess) = find(animal_all_sess_idx == sess); % get the session number (wrt all the sessions the animal completed)
end

%% Check the effect of GDX 

clear
clc

load('~/Dropbox/Jimmy/RLWM_mice_new/modeling/maximum_likelihood/saved_res/ml_res_gdx_all.mat');

[~, ~, animal_idx] = unique(data_all.animal);
num_sess = length(data_all.s);
age = data_all.age;
age_first_sess = nan(num_sess, 1);
sess_num = nan(num_sess, 1); % per mice

for sess = 1:num_sess
    animal = data_all.animal{sess};
    animal_all_sess_idx = find(strcmp(data_all.animal, animal) == 1);
    animal_first_sess_idx = animal_all_sess_idx(1);
    age_first_sess(sess) = data_all.age(animal_first_sess_idx); % get the age of the animal on its first session
    
    sess_num(sess) = find(animal_all_sess_idx == sess); % get the session number (wrt all the sessions the animal completed)
end

[reg_repeat, ~, ~] = repeat_nrepeat_common_reg(data_all, 'mice');
[reg_reward, ~, ~] = reward_nreward_common_reg(data_all, 'mice');
reg_trial_back = trial_back_reg(data_all, 'mice');

perf = perf_iter(data_all);
mean_perf = nanmean(perf(:, 1:200), 2);

%% Write out csv

% T = array2table([animal_idx, age, age_first_sess, sess_num, repeat_intercept, ...
%     repeat_prew, repeat_rl, nrepeat_intercept, nrepeat_prew, nrepeat_rl, alpha_positive, beta, s2, s4, diff]);
% T.Properties.VariableNames = {'animal_idx', 'age', 'age_first_sess', 'sess_num', 'repeat_intercept', ...
%     'repeat_prew', 'repeat_rl', 'nrepeat_intercept', 'nrepeat_prew', 'nrepeat_rl', 'alpha_positive', 'beta', 's2', 's4', 'diff'};
% %writetable(T, '~/Dropbox/Jimmy/RLWM_mice_new/data/male_ns2_age_regression.csv');
% %writetable(T, '~/Dropbox/Jimmy/RLWM_mice_new/data/female_ns2_age_regression.csv');
% %writetable(T, '~/Dropbox/Jimmy/RLWM_mice_new/data/male_ns4_age_regression.csv');
% writetable(T, '~/Dropbox/Jimmy/RLWM_mice_new/data/female_ns4_age_regression.csv');

% T = array2table([animal_idx, age, age_first_sess, sess_num, intercept, ...
%     one_back, one_back_repeat, one_back_nrepeat, rl]);  
% T.Properties.VariableNames = {'animal_idx', 'age', 'age_first_sess', 'sess_num', 'intercept', ...
%     'one_back','one_back_repeat', 'one_back_nrepeat', 'rl'};
% writetable(T, '~/Dropbox/Jimmy/RLWM_mice_new/data/male_ns2_age_anne_repeat_regression.csv');

% T = array2table([animal_idx, age, age_first_sess, sess_num, intercept, ...
%     one_reward, one_back_reward, one_back_nreward, rl]); 
% T.Properties.VariableNames = {'animal_idx', 'age', 'age_first_sess', 'sess_num', 'intercept', ...
%     'one_reward', 'one_back_reward', 'one_back_nreward', 'rl'};
% writetable(T, '~/Dropbox/Jimmy/RLWM_mice_new/data/male_ns2_age_anne_reward_regression.csv');

% T = array2table([animal_idx, age, age_first_sess, sess_num, a0bs24_a, ...
%     a0bs24_b, a0bs24_s2, a0bs24_s4, a0bs24_diff, a0bs1234_a, a0bs1234_b, ...
%     a0bs1234_s1, a0bs1234_s2, a0bs1234_s3, a0bs1234_s4, a0bs1234_diff]);

% T = array2table([animal_idx, age, age_first_sess, sess_num, a0bs1232_a, ...
%     a0bs1232_b, a0bs1232_s1, a0bs1232_s2, a0bs1232_s3]);
% T.Properties.VariableNames = {'animal_idx', 'age', 'age_first_sess', 'sess_num', 'a0bs1232_a', ...
%     'a0bs1232_b', 'a0bs1232_s1', 'a0bs1232_s2', 'a0bs1232_s3'};
% writetable(T, '~/Dropbox/Jimmy/RLWM_mice_new/data/male_ns2_age_a0bs1232.csv');

% T = array2table([animal_idx, age, age_first_sess, sess_num, mean_perf, ...
%     reg_trial_back, reg_repeat, reg_reward, params, data_all.sex, data_all.ns]);
% T.Properties.VariableNames = {'animal_idx', 'age', 'age_first_sess', 'sess_num', 'perf', ...
%     'reg_trial_intercept', 'reg_trial_oneback', 'reg_trial_twoback', 'reg_trial_rl', ...
%     'reg_repeat_intercept', 'reg_repeat_main', 'reg_repeat_reward', 'reg_nrepeat_reward', 'reg_repeat_rl', ...
%     'reg_reward_intercept', 'reg_reward_main', 'reg_reward_repeat', 'reg_nreward_repeat', 'reg_reward_rl', ...
%     'alpha_positive', 'beta', 's1', 's2', 's3', 'sex', 'ns'};
% writetable(T, '~/Dropbox/Jimmy/RLWM_mice_new/data/all_age_regression.csv');

T = array2table([animal_idx, age, age_first_sess, sess_num, mean_perf, ...
    reg_trial_back, reg_repeat, reg_reward, params, data_all.condition, data_all.ns]);
T.Properties.VariableNames = {'animal_idx', 'age', 'age_first_sess', 'sess_num', 'perf', ...
    'reg_trial_intercept', 'reg_trial_oneback', 'reg_trial_twoback', 'reg_trial_rl', ...
    'reg_repeat_intercept', 'reg_repeat_main', 'reg_repeat_reward', 'reg_nrepeat_reward', 'reg_repeat_rl', ...
    'reg_reward_intercept', 'reg_reward_main', 'reg_reward_repeat', 'reg_nreward_repeat', 'reg_reward_rl', ...
    'alpha_positive', 'beta', 's1', 's2', 's3', 'gdx', 'ns'};
writetable(T, '~/Dropbox/Jimmy/RLWM_mice_new/data/gdx_all_age_regression.csv');

    
    
    
    