function prepared = prepare_signal_vector(signal, quantizationBits)
%PREPARE_SIGNAL_VECTOR Normalize the signal for entropy estimation.
%   prepared = PREPARE_SIGNAL_VECTOR(signal, quantizationBits) converts the
%   input SIGNAL into integers representing quantization bins.

arguments
    signal (:, 1) double
    quantizationBits (1, 1) double {mustBePositive, mustBeInteger} = 16
end

step = 2 / (2 ^ quantizationBits);
prepared = zeros(size(signal));

if isempty(signal)
    return;
end

prepared(1) = signal(1);

for idx = 2:numel(signal)
    prepared(idx) = floor((signal(idx - 1) + 1) / step);
end
end
