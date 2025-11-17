function avgBits = average_bits_per_symbol(symbols)
%AVERAGE_BITS_PER_SYMBOL Estimate the number of bits required per symbol.
%   avgBits = AVERAGE_BITS_PER_SYMBOL(symbols) computes the Shannon entropy
%   of the vector SYMBOLS expressed in bits per symbol. An empty input
%   returns zero to simplify downstream arithmetic.
%
%   This helper is used to calculate the expected storage requirements for
%   the quantized ECG signal and all derived representations.

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
