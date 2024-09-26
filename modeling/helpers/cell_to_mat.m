function m = cell_to_mat(c)

% This function transforms a cell array to matrix, and pad the end with
% NaNs.
  
maxsize = max(cellfun(@numel, c));
fcn = @(x) [x nan(1, maxsize - numel(x))];
m = cellfun(fcn, c, 'UniformOutput', false);
m = vertcat(m{:});

end

