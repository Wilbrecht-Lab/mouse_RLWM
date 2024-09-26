function output = simulation_p(data, param, option)

%SIMULATION_P either simulates or calculates the likelihood wrt
%participants' choice or calculates the likelihood wrt correct choice for 1
%set of parameters for all sessions.

% _P means combining stickiness to policy, not Q-value

% There are three main use for this function:
% 1. Calculate model comparison scores: calculate the likelihood of each 
% trial for each session with the 'likelihood' option. 

% 2. Calculate likelihood of correct on each trial: When we compare model
% performance to actual mice performance, one way to do the comparison is,
% on a trial-by-trial bases, what is the likelihood of correct for the
% model vs participants. Thus we call this function with
% 'likelihood_correct' option.

% 3. The main way of comparing model to participant behavior, other than
% just performance, is simulating the model with fitted parameters.
% When we compare simulated data with participant behavior, we call this
% function with the 'simulation' option.

% If used with 'likelihood' or 'likelihood_correct' option, the output is a
% cell array of (num_sess by num_trial) log likelihood.

% If used with 'simulation' option, the output is a data_sim struct,
% containing the exact same information as the usual data struct for real
% mice data, except with simulated data.

% Currently this function can implement the following:
% 1. asymmetric learning rates
% 2. forgetting
% 3. s1, s2, s3, s4
% 4. p = s2 = s4
% 5. wm = s3 = s4
% 6. s = s1 = s2 = s3 = s4

num_sess = length(data.s);
[~, num_state] = size(data.t);

% initialize all parameters to 0

alpha_positive = zeros(1, num_sess);
alpha_negative = zeros(1, num_sess);
beta = param.beta; % all models have beta
forget = zeros(1, num_sess);
s1 = zeros(1, num_sess); % not repeating, previously not rewarded
s2 = zeros(1, num_sess); % not repeating, previously rewarded
s3 = zeros(1, num_sess); % repeating, previously not rewarded
s4 = zeros(1, num_sess); % repeating, previously rewarded

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

% Decide what to compute
if strcmp(option, 'likelihood') == 1
    LLH = cell(1, num_sess); % log likelihood for the 'likelihood' option
elseif strcmp(option, 'likelihood_correct') == 1
    LHC = cell(1, num_sess); % likelihood of correct for the 'likelihood_correct' option
elseif strcmp(option, 'simulation') == 1
    data_sim = data; % the output, data_sim, is the same as data, except with certain parts overwritten with simulated data
    % Specifically, we will re-write action_history, reward_history,
    % correct_history, 
else
    error('Sorry! No such option exists! Option can only be likelihood, likelihood_correct, or simulation');
end

% Start iterating over all sessions

for sess = 1:num_sess
    
    % initialize some variables
    stim_history = data.s{sess};
    action_history = data.a{sess}; % 0 means missing trial
    reward_history = data.r{sess};
    transition = data.t(sess, :); % correct contingency for each state
    num_trial = length(stim_history);
    
    Q = 0.5 * ones(num_state, 2); % Initialize Q-values to have uninformative starting values
    pchoice = [0 0]; % initialize policy
    pre = [0 0]; % keep track of which action was chosen previously
    
    if strcmp(option, 'simulation') == 1
        % we always take the same action as the mice for the first
        % iteration
        seen = zeros(num_state, 1);
    else
        L = nan(1, num_trial); % temporary holder for likelihood
    end
        
    for trial = 1:num_trial
        s = stim_history(trial);
        a = action_history(trial);
        r = reward_history(trial);
        if a > 0 % if not a missing trial
            % Calculate policy based on Q-values
            pchoice(1) = 1 / (1 + exp(beta(sess) * (Q(s, 2) - Q(s, 1))));
            pchoice(2) = 1 - pchoice(1);
            
            % Implement stickiness 
            if trial > 1 && action_history(trial - 1) > 0
                if reward_history(trial - 1) == 0 && stim_history(trial - 1) ~= s
                    pchoice = (1 - s1(sess)) * pchoice + s1(sess) * pre;
                elseif reward_history(trial - 1) > 0 && stim_history(trial - 1) ~= s
                    pchoice = (1 - s2(sess)) * pchoice + s2(sess) * pre;
                elseif reward_history(trial - 1) == 0 && stim_history(trial - 1) == s
                    pchoice = (1 - s3(sess)) * pchoice + s3(sess) * pre;
                elseif reward_history(trial - 1) > 0 && stim_history(trial - 1) == s
                    pchoice = (1 - s4(sess)) * pchoice + s4(sess) * pre;
                end
            end
            
            % Take action
            if strcmp(option, 'simulation') == 1
                if seen(s) == 0
                    a_sim = a; % if first time seeing butterfly s, pick participant's action
                    seen(s) = 1;
                else
                    a_sim = discretesample(pchoice, 1); % otherwise, simulating online
                end
            else
                a_sim = a; % otherwise, just take action according to participant choices for likelihood calculations
            end
            
            % Figure out the correct action (not necessary for the 'likelihood' option)
            if strcmp(option, 'simulation') == 1 || strcmp(option, 'likelihood_correct') == 1
                correct_action = transition(s);
            end
            
            % Decide correct or not (only needed for the 'simulation' option)
            if strcmp(option, 'simulation') == 1
                if a_sim == correct_action
                    r_sim = 1;
                else
                    r_sim = 0;
                end
            else
                % Not simulating, just deliver reward existing in data struct
                r_sim = r;
            end    
            
            % Q-learning
            RPE = r_sim - Q(s, a_sim); % might consider using temp_Q(a_sim) instead for interference
            if RPE > 0
                Q(s, a_sim) = Q(s, a_sim) + alpha_positive(sess) * RPE;
            else
                Q(s, a_sim) = Q(s, a_sim) + alpha_negative(sess) * RPE;
            end
            
            % Implement forgetting
            temp = Q(s, a_sim);
            Q = forget(sess) * 0.5 + (1 - forget(sess)) * Q; % linear combination of current Q-values and uninformative values.
            Q(s, a_sim) = temp; % do not forget the Q-value that was just updated this trial
            
            % update stickiness for next trial (1 for the action just taken, 0 for the other one)
            if (a_sim == 1) 
                pre = [1 0];
            else
                pre = [0 1];
            end
            
            % Update output
            if strcmp(option, 'likelihood') == 1
                L(trial) = log(pchoice(a)); % calculate the log likelihood of the action chosen by the participants
            elseif strcmp(option, 'likelihood_correct') == 1
                L(trial) = pchoice(correct_action); % calculate the probability of correct based on the current policy
            elseif strcmp(option, 'simulation') == 1
                data_sim.a{sess}(trial) = a_sim; % update anything necessary (action, reward) for simulation
                data_sim.r{sess}(trial) = r_sim;
            else
                error('Sorry! No such option exists! Option can only be likelihood, likelihood_correct, or simulation');
            end
        else % missing trial, just reset stickiness
            pre = [0 0];
        end     
    end
    if strcmp(option, 'likelihood') == 1
        LLH{sess} = L;
    elseif strcmp(option, 'likelihood_correct') == 1
        LHC{sess} = L;
    end
end

% Set the output appropriately
if strcmp(option, 'likelihood') == 1
    output = LLH;
elseif strcmp(option, 'likelihood_correct') == 1
    output = LHC;
elseif strcmp(option, 'simulation') == 1
    output = data_sim;
else
    error('Sorry! No such option exists! Option can only be likelihood, likelihood_correct, or simulation');
end

end

