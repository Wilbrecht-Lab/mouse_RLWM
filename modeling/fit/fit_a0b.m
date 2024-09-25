function [Xfit, ll, BIC, idx] = fit_a0b(stimulus, action, reward, num_iter)

obFunc = @(x) lik_a0b(stimulus, action, reward, x(1), x(2));
X_all = nan(num_iter, 2);
nll_all = nan(num_iter, 1);
LB = [0 0];
UB = [1 20];

for i = 1:num_iter
    X0 = [rand, rand * 20];
    [X_all(i, :), nll_all(i)] = fmincon(obFunc, X0, [], [], [], [], LB, UB);
end

[~, idx] = min(nll_all);
Xfit = X_all(idx, :);
ll = -nll_all(idx);
BIC = length(LB) * log(length(stimulus)) - 2 * ll;