function avgBits = average_bits_per_symbol(symbols)
% Estimate the Shannon entropy of the provided symbol vector.

arguments
    symbols (:, 1) double
end

if isempty(symbols)
    avgBits = 0;
    return;
end

% Identify unique elements while preserving the original order to keep the
% mapping stable.
[~, ~, idx] = unique(symbols, 'stable');
counts = accumarray(idx, 1);
probabilities = counts / numel(symbols);

% Ignore zero-probability entries (should not occur but keeps log2 safe).
nonZero = probabilities > 0;
avgBits = -sum(probabilities(nonZero) .* log2(probabilities(nonZero)));
end
