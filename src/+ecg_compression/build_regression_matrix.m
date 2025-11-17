function [predictors, targets] = build_regression_matrix(signal, historyLength)
%BUILD_REGRESSION_MATRIX Assemble lagged samples for linear prediction.
%   [predictors, targets] = BUILD_REGRESSION_MATRIX(signal, historyLength)
%   creates a matrix where each row of PREDICTORS contains HISTORYLENGTH
%   consecutive samples of SIGNAL. TARGETS contains the value that follows
%   each row, enabling standard linear regression training.

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
