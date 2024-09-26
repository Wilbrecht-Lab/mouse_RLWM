function performance_iter = perf_iter(data)
% This script takes in mice data package and outputs performance per
% iteration for each session (pad the end with NaN).

num_sess = length(data.r);
performance_iter_c = cell(1, num_sess);
num_stim = length(unique(data.s{1})); 

for sess = 1:num_sess
    % extract stim and reward history
    s = data.s{sess};
    r = data.r{sess};
    
    % initialize performance per stim (need cell array because each stim
    % might be shown different number of trials) 
    performance_iter_sess = cell(1, num_stim);
    
    for stim = 1:num_stim
        % obtain the performance for each stimulus
        performance_iter_sess{stim} = r(s == stim);
    end
    % convert the performance for each stim into a matrix
    performance_iter_sess = cell_to_mat(performance_iter_sess);
    
    % average within sess to get 1 learning curve per session
    performance_iter_c{sess} = nanmean(performance_iter_sess);
end

performance_iter = cell_to_mat(performance_iter_c);

end

