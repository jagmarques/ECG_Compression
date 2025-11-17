function errorSignal = compute_prediction_error(signal, prediction, historyLength)
% Return the residual between the waveform and its predictions.

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
