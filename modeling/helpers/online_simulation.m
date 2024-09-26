function data_sim = online_simulation(data, param)
% This function is used for debugging purposes: There might be some error
% with the simulation script written in simulation.m for the mice data, so
% I am trying to write an independent script to 

num_sess = length(data.s);
[~, num_state] = size(data.t);

% initialize all parameters to 0

alpha_positive = zeros(num_sess, 1);
alpha_negative = zeros(num_sess, 1);
beta = 20 * ones(num_sess, 1); % a0s24 has beta fixed at 20
forget = zeros(num_sess, 1);
s1 = zeros(num_sess, 1); % not repeating, previously not rewarded
s2 = zeros(num_sess, 1); % not repeating, previously rewarded
s3 = zeros(num_sess, 1); % repeating, previously not rewarded
s4 = zeros(num_sess, 1); % repeating, previously rewarded

% resolve learning rate

if isfield(param, 'alpha') % symmetric learning rates
    alpha_positive = param.alpha;
    alpha_negative = param.alpha;
end

if isfield(param, 'alpha_positive')
    alpha_positive = param.alpha_positive;
end

if isfield(param, 'alpha_negative')
    alpha_negative = param.alpha_negative;
end

% resolve beta

if isfield(param, 'beta')
    beta = param.beta;
end

% resolve forgetting

if isfield(param, 'forget')
    forget = param.forget;
end

% resolve stickiness

if isfield(param, 's1')
    s1 = s1 + param.s1;
end

if isfield(param, 's2')
    s2 = s2 + param.s2;
end

if isfield(param, 's3')
    s3 = s3 + param.s3;
end

if isfield(param, 's4')
    s4 = s4 + param.s4;
end

if isfield(param, 'p')
    s2 = s2 + param.p;
    s4 = s4 + param.p;
end

if isfield(param, 'wm')
    s3 = s3 + param.wm;
    s4 = s4 + param.wm;
end

if isfield(param, 's')
    s1 = s1 + param.s;
    s2 = s2 + param.s;
    s3 = s3 + param.s;
    s4 = s4 + param.s;
end

data_sim = data;

for sess = 1:num_sess
    % initiate some variables
    action_history = data.a{sess}; % 0 means missing trial
    num_trial = length(action_history);
    
    % implement correction trial by randomly creating a new odor sequence
    schedule = new_odor_schedule(num_state); % routine wrote by Lung-Hao for generating random initial odor sequence
    temp_stim = schedule(1:num_trial);
    [unique_stim, ~, stim_history_sim] = unique(temp_stim); % get the new stim_history
    transition = zeros(1, num_state); % need to update transition as well
    for state = 1:num_state
        if unique_stim(state) == 3 || unique_stim(state) == 6 || unique_stim(state) == 8
            transition(state) = 1; % correct action is 1
        else
            transition(state) = 2;
        end
    end
        
    action_history_sim = nan(1, num_trial);
    reward_history_sim = nan(1, num_trial);
    
    Q = 0.5 * ones(num_state, 2);
    pchoice = [0 0];
    pre = [0 0];
    seen = zeros(num_state, 1);
    
    for trial = 1:num_trial
        if action_history(trial) > 0 % not a missing trial
            stim = stim_history_sim(trial); % calling it stim to avoid messing with param.s
            temp_Q = Q(stim, :);
            
            if trial > 1 && action_history(trial - 1) > 0 % if prev trial not missing either, implement stickiness
                if reward_history_sim(trial - 1) == 0 && stim_history_sim(trial - 1) ~= stim
                    temp_Q = temp_Q + s1(sess) * pre;
                elseif reward_history_sim(trial - 1) == 1 && stim_history_sim(trial - 1) ~= stim
                    temp_Q = temp_Q + s2(sess) * pre;
                elseif reward_history_sim(trial - 1) == 0 && stim_history_sim(trial - 1) == stim
                    temp_Q = temp_Q + s3(sess) * pre;
                elseif reward_history_sim(trial - 1) == 1 && stim_history_sim(trial - 1) == stim
                    temp_Q = temp_Q + s4(sess) * pre;
                end
            end
    
            % Calculate policy based on Q-values
            pchoice(1) = 1 / (1 + exp(beta(sess) * (temp_Q(2) - temp_Q(1))));
            pchoice(2) = 1 - pchoice(1);
            
            % take action
            if seen(stim) == 0
                a_sim = action_history(trial); % if first time seeing odor stim, pick mouse's action
                seen(stim) = 1;
            else
                a_sim = discretesample(pchoice, 1); % otherwise, simulating online
            end
            action_history_sim(trial) = a_sim; % record online simulated action
            
            % decide reward
            correct_action = transition(stim);
            if a_sim == correct_action
                r_sim = 1;
            else
                r_sim = 0;
            end
            reward_history_sim(trial) = r_sim;
            
            % Q-learning
            RPE = r_sim - Q(stim, a_sim); % might consider using temp_Q(a_sim) instead for interference of WM and RL
            if RPE > 0
                Q(stim, a_sim) = Q(stim, a_sim) + alpha_positive(sess) * RPE;
            else
                Q(stim, a_sim) = Q(stim, a_sim) + alpha_negative(sess) * RPE;
            end
            
            % Implement forgetting
            temp = Q(stim, a_sim);
            Q = forget(sess) * 0.5 + (1 - forget(sess)) * Q; % linear combination of current Q-values and uninformative values.
            Q(stim, a_sim) = temp; % do not forget the Q-value that was just updated this trial
            
            % update stickiness for next trial (1 for the action just taken, 0 for the other one)
            if (a_sim == 1) 
                pre = [1 0];
            else
                pre = [0 1];
            end
        else % missing trial, just reset stickiness
            pre = [0 0];
            action_history_sim(trial) = 0; % action = 0 indicates missing trial
            reward_history_sim(trial) = 0;
        end  
    end
    % end of session, update output
    data_sim.s{sess} = stim_history_sim;
    data_sim.a{sess} = action_history_sim;
    data_sim.r{sess} = reward_history_sim; 
end    


end