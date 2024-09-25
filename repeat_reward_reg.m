function regression_coeff = repeat_reward_reg(data, filler)
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
            
            rr = 0;
            rn = 0;
            nr = 0;
            nn = 0;
            
            if action_history(trial - 1) > 0 
                if stim_history(trial - 1) == s && reward_history(trial - 1) > 0
                    rr = 1;
                elseif stim_history(trial - 1) == s && reward_history(trial - 1) == 0
                    rn = 1;
                elseif stim_history(trial - 1) ~= s && reward_history(trial - 1) > 0
                    nr = 1;
                elseif stim_history(trial - 1) ~= s && reward_history(trial - 1) == 0
                    nn = 1;
                end
            end
            
            temp_together = [temp_together; rr, rn, nr, nn, ...
                             temp_correct_history(s), r];
            
            % incrememt correct history if correct on this trial
            if r == 1
                temp_correct_history(s) = temp_correct_history(s) + 1;
            end
            
        end
    end 
        
    % zscore everything
    temp_together(:, 1) = zscore(temp_together(:, 1)); % rr
    temp_together(:, 2) = zscore(temp_together(:, 2)); % rn
    temp_together(:, 3) = zscore(temp_together(:, 3)); % nr
    temp_together(:, 4) = zscore(temp_together(:, 4)); % nn
    temp_together(:, 5) = zscore(temp_together(:, 5)); % correct history
   
    together{sess} = temp_together;    
end

% Run the regression

regression_coeff = zeros(num_sess, 6); % 6 means intercept + 5 regressors

for sess = 1:num_sess
    [regression_coeff(sess, :), ~, ~] = glmfit(together{sess}(:, 1:5), together{sess}(:, 6), 'binomial', 'link', 'logit');
end

% visualize the regression coefficients

m_reg = nanmean(regression_coeff);
se_reg = nanse(regression_coeff);

figure1 = figure;
axes1 = axes('Parent',figure1);
superbar(m_reg(2:end), 'E', se_reg(2:end)); % not caring about intercept for now
ylabel('Regression coefficient');
xlim([0.5, 5.5])
set(axes1,'FontSize',10,'XTickLabel',...
    {'','rr','','rn','','nr','','nn','','correct history',''});
set(gca,'TickDir','out');
title(filler);

end

