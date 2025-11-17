function quantized = quantize_signal(signal, bits)
%QUANTIZE_SIGNAL Apply symmetric uniform quantization to the signal.
%   quantized = QUANTIZE_SIGNAL(signal, bits) clamps SIGNAL to [-1, 1],
%   rescales it to BITS resolution, and returns the quantized waveform.

arguments
    signal (:, 1) double
    bits (1, 1) double {mustBeInteger, mustBePositive} = 16
end

if isempty(signal)
    quantized = signal;
    return;
end

maxVal = max(abs(signal));
if maxVal > 1
    normalized = signal / maxVal;
else
    normalized = signal;
end

levels = max(2 ^ (bits - 1) - 1, 1);
quantized = round(normalized * levels) / levels;
end
