function [Xfit, ll, BIC, idx] = fit_a0bs1234(stimulus, action, reward, num_iter)

obFunc = @(x) lik_a0bs1234(stimulus, action, reward, x(1), x(2), x(3), x(4), x(5), x(6));
X_all = nan(num_iter, 6);
nll_all = nan(num_iter, 1);
LB = [0 0 -1 -1 -1 -1];
UB = [1 20 1 1 1 1];

for i = 1:num_iter
    X0 = [rand, rand * 20, rand * 2 - 1, rand * 2 - 1, rand * 2 - 1, rand * 2 - 1];
    [X_all(i, :), nll_all(i)] = fmincon(obFunc, X0, [], [], [], [], LB, UB);
end

[~, idx] = min(nll_all);
Xfit = X_all(idx, :);
ll = -nll_all(idx);
BIC = length(LB) * log(length(stimulus)) - 2 * ll;