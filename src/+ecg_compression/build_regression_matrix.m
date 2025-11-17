function [predictors, targets] = build_regression_matrix(signal, historyLength)
% Assemble lagged samples so a linear model can learn future values.

arguments
    signal (:, 1) double
    historyLength (1, 1) double {mustBePositive, mustBeInteger}
end

numRows = numel(signal) - historyLength;
if numRows <= 0
    error('ecg_compression:build_regression_matrix:ShortSignal', ...
        'Signal must contain more samples than the history length (%d).', historyLength);
end
predictors = zeros(numRows, historyLength);
targets = zeros(numRows, 1);

for row = 1:numRows
    predictors(row, :) = signal(row:row + historyLength - 1)';
    targets(row) = signal(row + historyLength);
end
end
