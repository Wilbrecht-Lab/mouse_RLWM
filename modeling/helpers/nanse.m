function se = nanse(m)

% This script implements nan-version of standard error calculation

[~, ncol] = size(m);
se = zeros(1, ncol);

for col = 1:ncol
    temp = m(:, col);
    temp = temp(~isnan(temp));
    se(col) = std(temp) / sqrt(length(temp));
end

