function errorSignal = compute_prediction_error(signal, prediction, historyLength)
%COMPUTE_PREDICTION_ERROR Calculate the residual after regression.
%   errorSignal = COMPUTE_PREDICTION_ERROR(signal, prediction, historyLength)
%   returns the difference between SIGNAL and its predicted values,
%   accounting for the lag introduced by HISTORYLENGTH samples.

arguments
    signal (:, 1) double
    prediction (:, 1) double
    historyLength (1, 1) double {mustBePositive, mustBeInteger}
end

numSamples = numel(signal) - historyLength;
errorSignal = zeros(numSamples, 1);
for idx = 1:numSamples
    errorSignal(idx) = signal(historyLength + idx) - prediction(idx);
end
end
