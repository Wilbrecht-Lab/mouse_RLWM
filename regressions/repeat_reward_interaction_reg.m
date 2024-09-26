function [regression_coeff, regression_SE, regression_tStat, regression_pValue, regression_modelcomparison] = repeat_reward_interaction_reg(data, filler)
% This function is used to perform repeat_reward regression analysis on
% RLWM mice data. 
% It takes in the data package, and plots the regression analysis figure
% for the entire population. It outputs the regression coefficients if
% needed for age analysis.

% First transform the data package into a format ready for regression

num_sess = length(data.s);
[~, num_state] = size(data.t);
together = cell(1, num_sess);

for sess = 1:num_sess
    temp_together = [];
    temp_correct_history = zeros(1, num_state);
    stim_history = data.s{sess};
    action_history = data.a{sess};
    reward_history = data.r{sess};
    num_trial = length(stim_history);
          
    for trial = 1:num_trial
        s = stim_history(trial); % stim of current trial
        a = action_history(trial);
        r = reward_history(trial);

        if (trial > 1 && a > 0) % at least have 1 trial back and not a missing trial
            
            pre_reward = 0;
            repeat = 0;

            % repeat  
            if stim_history(trial - 1) == s && action_history(trial - 1) > 0 
                % This means it is a repeating trial
                repeat = 1;
            end
            
            % previously rewarded or not
            if reward_history(trial - 1) > 0 && action_history(trial - 1) > 0 
                pre_reward = 1;
            end
            
            temp_together = [temp_together; repeat, pre_reward, ...
                             temp_correct_history(s), r];
                         
            % incrememt correct history if correct on this trial
            if r == 1
                temp_correct_history(s) = temp_correct_history(s) + 1;
            end
            
        end
    end 
        
    % zscore everything
    temp_together(:, 1) = zscore(temp_together(:, 1)); % repeat
    temp_together(:, 2) = zscore(temp_together(:, 2)); % prev_reward
    temp_together(:, 3) = log(temp_together(:, 3) +1);
    temp_together(:, 3) = zscore(temp_together(:, 3)); % correct_history
   
    together{sess} = temp_together;    
end

% Run the regression

regression_coeff = zeros(num_sess, 5); % 5 means intercept, repeat, pre-reward, correct history, and interaction of repeat and reward
regression_SE = zeros(num_sess, 5);
regression_tStat = zeros(num_sess,5);
regression_pValue = zeros(num_sess,5);
regression_modelcomparison = zeros(num_sess,4); % AIC, AICc, BIC, CAIC

for sess = 1:num_sess
%     [regression_coeff(sess, :), ~, ~] = glmfit([together{sess}(:, 1:3), together{sess}(:, 1) .* together{sess}(:, 2)], together{sess}(:, 4), 'binomial', 'link', 'logit');
    mdl = fitglm([together{sess}(:, 1:3), together{sess}(:, 1) .* together{sess}(:, 2)], together{sess}(:, 4),'Distribution','binomial') ;
    regression_coeff(sess,:) = mdl.Coefficients.Estimate';
    regression_SE(sess,:) = mdl.Coefficients.SE';
    regression_tStat(sess,:) = mdl.Coefficients.tStat';
    regression_pValue(sess,:) = mdl.Coefficients.pValue';
    regression_modelcomparison(sess,1) = mdl.ModelCriterion.AIC;
    regression_modelcomparison(sess,2) = mdl.ModelCriterion.AICc;
    regression_modelcomparison(sess,3) = mdl.ModelCriterion.BIC;
    regression_modelcomparison(sess,4) = mdl.ModelCriterion.CAIC;
end

% visualize the regression coefficients

% m_reg = nanmean(regression_coeff);
% se_reg = nanse(regression_coeff);
% 
% figure1 = figure;
% axes1 = axes('Parent',figure1);
% superbar(m_reg(2:end), 'E', se_reg(2:end)); % not caring about intercept for now
% ylabel('Regression coefficient');
% xlim([0.5, 4.5])
% set(axes1,'FontSize',10,'XTickLabel',...
%     {'','repeat','','pre reward','','correct history','','interaction', ''});
% set(gca,'TickDir','out');
% title(filler);

end

