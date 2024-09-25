function nll = lik_aabs1232(stimulus, action, reward, alpha_positive, alpha_negative, beta, s1, s2, s3)
% s1: not repeating, not previously rewarded
% s2: not repeating, previously rewarded
% s3: repeating, not previously rewarded
% s4: repeating, previously rewarded

s4 = s2;

num_trial = length(stimulus);
num_state = length(unique(stimulus));

% initialize Q function
Q = 0.5 * ones(num_state, 2); % always 2 actions
p = [0 0]; % initialize policy
pre = [0 0]; % keep track of which action was chosen previously
nll = 0;

for trial = 1:num_trial
    if action(trial) > 0 % action = 0 means missing  
    
        s = stimulus(trial);
        a = action(trial);
        r = reward(trial);
        
        temp_Q = Q(s, :);
        % compose Q-value with stickiness
        if trial > 1
            if reward(trial - 1) > 0 % previously rewarded
                if stimulus(trial - 1) ~= s
                    temp_Q = temp_Q + s2 * pre;
                elseif stimulus(trial - 1) == s
                    temp_Q = temp_Q + s4 * pre;
                end
            else % not previously rewarded
                if stimulus(trial - 1) ~= s
                    temp_Q = temp_Q + s1 * pre;
                elseif stimulus(trial - 1) == s
                    temp_Q = temp_Q + s3 * pre;
                end
            end
        end
        
        % compute choice probabilities
        p(1) = 1 / (1 + exp(beta * (temp_Q(2) - temp_Q(1))));
        p(2) = 1 - p(1);

        % Q-learning
        RPE = r - Q(s, a);
        if RPE > 0
            Q(s, a) = Q(s, a) + alpha_positive * RPE;
        else
            Q(s, a) = Q(s, a) + alpha_negative * RPE;
        end
        
        % update stickiness (1 for the action just taken, 0 for the other one)
        if (a == 1) 
            pre = [1 0];
        else
            pre = [0 1];
        end
        
        %update likelihood
        nll = nll - log(p(a));
    else % for a missing trial, just reset S
        pre = [0 0];     
    end
end