function index = discretesample(p, n)
    % Sample n times from a discrete distribution given by p
    % p: a probability vector (must sum to 1)
    % n: the number of samples

    % Cumulative sum
    edges = [0 cumsum(p(:)')];
    
    % Random samples
    samples = rand(1, n);
    
    % Assign the sample to the correct bin
    [~, index] = histc(samples, edges);
end