function regression_coeff = repeat_nrepeat_reg(data, filler)
% This function is used to perform repeat/non-repeat regression analysis on
% RLWM mice data. 
% It takes in the data package, and plots the regression analysis figure
% for the entire population. It outputs the regression coefficients if
% needed for age analysis.

% First transform raw data to repeat/non-repeat for the regression

num_sess = length(data.s);
[~, num_state] = size(data.t);
regression_coeff = zeros(2, 3, num_sess); % 2 means repeat vs. nrepeat; 3 means the coeff for intercept, reward and correct history

for sess = 1:num_sess
    repeat_sess = [];
    nrepeat_sess = [];
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
            if (action_history(trial - 1) > 0 && a > 0)
                % check if the previous trial is the same stim
                if (stim_history(trial - 1) == s)
                    repeat_sess = [repeat_sess; reward_history(trial - 1), correct_history(s), r];
                else
                    nrepeat_sess = [nrepeat_sess; reward_history(trial - 1), correct_history(s), r];
                end
            end
        end
        
        % incrememt correct history if correct on this trial
        if r == 1
            correct_history(s) = correct_history(s) + 1;
        end
    end
    % zscore everything
    repeat_sess(:,1) = zscore(repeat_sess(:,1));
    repeat_sess(:,2) = log(repeat_sess(:,2) + 1);
    repeat_sess(:,2) = zscore(repeat_sess(:,2));
    nrepeat_sess(:,1) = zscore(nrepeat_sess(:,1));
    nrepeat_sess(:,2) = log(nrepeat_sess(:,2) + 1);
    nrepeat_sess(:,2) = zscore(nrepeat_sess(:,2));

    % perform regression
    [regression_coeff(1, :, sess), ~, ~] = glmfit(repeat_sess(:,1:2), repeat_sess(:,3), 'binomial', 'link', 'logit');
    [regression_coeff(2, :, sess), ~, ~] = glmfit(nrepeat_sess(:,1:2), nrepeat_sess(:,3), 'binomial', 'link', 'logit');
end

% visualize the regression coefficients

figure; %sgtitle(filler)

C = [.8 .2 .2;
     .2 .8 .2];

subplot(1, 3, 1)

bar_1 = [mean(regression_coeff(1, 1, :)), mean(regression_coeff(2, 1, :))];
errorbar_1 = [std(regression_coeff(1, 1, :)), std(regression_coeff(2, 1, :))] / sqrt(num_sess);

P = nan(2);
[~, P(1, 2)] = ttest(regression_coeff(1, 1, :), regression_coeff(2, 1, :)); P(2, 1) = P(1, 2);

superbar(bar_1, 'E', errorbar_1, 'P', P, 'BarFaceColor', C);
legend('repeat','nrepeat')
title(strcat('Intercept'))
%title(strcat('Intercept (', filler, ')'))

subplot(1, 3, 2)

bar_2 = [mean(regression_coeff(1, 2, :)), mean(regression_coeff(2, 2, :))];
errorbar_2 = [std(regression_coeff(1, 2, :)), std(regression_coeff(2, 2, :))] / sqrt(num_sess);

P = nan(2);
[~, P(1, 2)] = ttest(regression_coeff(1, 2, :), regression_coeff(2, 2, :)); P(2, 1) = P(1, 2);

superbar(bar_2, 'E', errorbar_2, 'P', P, 'BarFaceColor', C);
legend('repeat','nrepeat')
title(strcat('Previously rewarded'))

subplot(1, 3, 3)

bar_3 = [mean(regression_coeff(1, 3, :)), mean(regression_coeff(2, 3, :))];
errorbar_3 = [std(regression_coeff(1, 3, :)), std(regression_coeff(2, 3, :))] / sqrt(num_sess);

P = nan(2);
[~, P(1, 2)] = ttest(regression_coeff(1, 3, :), regression_coeff(2, 3, :)); P(2, 1) = P(1, 2);

superbar(bar_3, 'E', errorbar_3, 'P', P, 'BarFaceColor', C);
legend('repeat','nrepeat')
title(strcat('Correct history'))

end

