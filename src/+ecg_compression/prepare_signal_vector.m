function prepared = prepare_signal_vector(signal, quantizationBits)
% Convert the waveform into quantization bins for entropy math.

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
