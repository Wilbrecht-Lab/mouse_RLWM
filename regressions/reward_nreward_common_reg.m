function [regression_coeff, regression_SE, regression_tStat, regression_pValue, regression_modelcomparison, corr_map, reward_proportion] = reward_nreward_common_reg(data, filler)
% This script is used to implement behavioral regression.
% The main idea is to combine the separate regression I had for repeating
% and non-repeating trials to have a common intercept. There are two
% different ways to implement this:

% The first way:
% 1. reg1 if repeating: 1 if previously rewarded, -1 if previously
% non-rewarded, 0 if non-repeating.
% 2. reg2 if non-repeating: 1 if previously rewarded, -1 if previously
% non-rewarded, 0 if repeating.
% 3. correct history
% 4. consider reg3 and reg4 for 2-trial-back

% The second way: essentially flip repeat and reward

% This script is the second way.

num_sess = length(data.s);
[~, num_state] = size(data.t);
regression_coeff = zeros(num_sess, 5); % 5 means the coeff for intercept, one-reward, reg1, reg2 and correct history
regression_SE = zeros(num_sess, 5);
regression_tStat = zeros(num_sess,5);
regression_pValue = zeros(num_sess,5);
regression_modelcomparison = zeros(num_sess,4); % AIC, AICc, BIC, CAIC
corr_map = zeros(num_sess, 4, 4);
reward_proportion = zeros(num_sess, 1);

for sess = 1:num_sess
    reg_sess = [];
    correct_history = zeros(1, num_state); % keep track how many rewards have gotton so far

    stim_history = data.s{sess};
    action_history = data.a{sess};
    reward_history = data.r{sess};
    num_trial = length(stim_history);
    
    for trial = 1:num_trial
        s = stim_history(trial);
        a = action_history(trial);
        r = reward_history(trial);
        
        % check whether repeating or non-repeating
        if (trial > 1)  
            % check if the current or previous trial is a missing trial
            if action_history(trial - 1) > 0 && a > 0
                one_reward = 0;
                one_back_reward = 0;
                one_back_nreward = 0;
                
                if reward_history(trial - 1) == 1 % this means previously rewarded
                    one_reward = 1;
                    if stim_history(trial - 1) == s % repeating
                        one_back_reward = 1;
                    else 
                        one_back_reward = -1; % not repeating
                    end
                elseif reward_history(trial - 1) == 0 % non previously rewarded
                    if stim_history(trial - 1) == s % repeating
                        one_back_nreward = 1;
                    else
                        one_back_nreward = -1; % not repeating
                    end
                else
                    error('Something wrong for reward nreward regression')
                end
                
                reg_sess = [reg_sess; one_reward, one_back_reward, one_back_nreward, correct_history(s), r];
            end
        end
        
        % incrememt correct history if correct on this trial
        if r == 1
            correct_history(s) = correct_history(s) + 1; % note that we only increment correct history after updating data_sess, so that we use data before the current trial to predict reward on the current trial
        end
    end
    reward_proportion(sess) = sum(reg_sess(:, 1)) / size(reg_sess, 1);
    % zscore one_reward
    reg_sess(:, 1) = zscore(reg_sess(:, 1));
    % zscore correct_history
    reg_sess(:, 4) = log(reg_sess(:, 4) + 1); % log transform correct history (more satiated as the session progresses)
    reg_sess(:, 4) = zscore(reg_sess(:, 4));
    
    % perform regression
%     [regression_coeff(sess, :), ~, ~] = glmfit(reg_sess(:, 1:4), reg_sess(:, 5), 'binomial', 'link', 'logit');
    corr_map(sess, :, :) = corr(reg_sess(:, 1:4));
    mdl = fitglm(reg_sess(:,1:4), reg_sess(:,5),'Distribution','binomial') ;
    regression_coeff(sess,:) = mdl.Coefficients.Estimate';
    regression_SE(sess,:) = mdl.Coefficients.SE';
    regression_tStat(sess,:) = mdl.Coefficients.tStat';
    regression_pValue(sess,:) = mdl.Coefficients.pValue';
    regression_modelcomparison(sess,1) = mdl.ModelCriterion.AIC;
    regression_modelcomparison(sess,2) = mdl.ModelCriterion.AICc;
    regression_modelcomparison(sess,3) = mdl.ModelCriterion.BIC;
    regression_modelcomparison(sess,4) = mdl.ModelCriterion.CAIC;

end

% regression_coeff(abs(regression_coeff) > 5) = nan; % remove outliers
% 
% m = nanmean(regression_coeff);
% se = nanse(regression_coeff);
% 
% figure1 = figure;
% axes1 = axes('Parent',figure1);
% superbar(m, 'E', se);
% title(filler);
% xlim([0.5, numel(m) + 0.5])
% ylim([-1, 1.6])
% 
% set(axes1,'FontSize',10,'XTickLabel',...
%     {'','intercept','','reward','','reward-repeat','','nreward-repeat','','correct history'});
