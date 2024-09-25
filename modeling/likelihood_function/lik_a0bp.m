function nll = lik_a0bp(stimulus, action, reward, alpha_positive, beta, pers)

num_trial = length(stimulus);
num_state = length(unique(stimulus));

% initialize Q function
Q = 0.5 * ones(num_state, 2); % always 2 actions
p = [0 0]; % initialize policy
P = [0 0]; % keep track of which action was rewarded previously
nll = 0;

for trial = 1:num_trial
    if action(trial) > 0 % action = 0 means missing  
    
        s = stimulus(trial);
        a = action(trial);
        r = reward(trial);
        
        % decide if use perseveration (only use when rewarded in the previous trial)
        P_indicator = 0;
        if trial > 1 % need to be not at the beginning of a session
            if reward(trial-1) > 0 % only perseverate when previous trial was rewarded
                P_indicator = 1;
            end
        end
        
        % compose Q-value with perseveration
        temp_Q = Q(s, :) + P_indicator * pers * P;
        
        % compute choice probabilities
        p(1) = 1 / (1 + exp(beta * (temp_Q(2) - temp_Q(1))));
        p(2) = 1 - p(1);

        % Q-learning
        RPE = r - Q(s, a);
        if RPE > 0
            Q(s, a) = Q(s, a) + alpha_positive * RPE;
        end
        
        % update perseveration (1 for the action just taken, 0 for the other one)
        if (r == 1)
            if (a == 1) 
                P = [1 0];
            else
                p = [0 1];
            end
        else % if not rewarded the current trial, no need to perseverate in the next trial
            P = [0 0];
        end
        %update likelihood
        nll = nll - log(p(a));
    else % for a missing trial, just reset P
        P = [0 0];     
    end
end