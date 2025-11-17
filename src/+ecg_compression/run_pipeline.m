function results = run_pipeline(signalPath, opts)
% Execute the ECG compression pipeline and collect metrics.

arguments
    signalPath (1, :) char
    opts.LinearHistory (1, 1) double {mustBePositive, mustBeInteger} = 4
    opts.QuantizationBits (1, 1) double {mustBePositive, mustBeInteger} = 16
end

signal = ecg_compression.load_signal(signalPath);
quantized = ecg_compression.quantize_signal(signal, opts.QuantizationBits);

[predictors, targets] = ecg_compression.build_regression_matrix(quantized, opts.LinearHistory);
model = fitlm(predictors, targets);
coefficients = model.Coefficients.Estimate;
seedWindow = predictors(1, :)';

predictions = predict(model, predictors);
errorSignal = ecg_compression.compute_prediction_error(quantized, predictions, opts.LinearHistory);
linearPayload = ecg_compression.pack_linear_model(opts.LinearHistory, coefficients, seedWindow, errorSignal);

delta = ecg_compression.delta_modulate(quantized);
delta2 = ecg_compression.delta_modulate(delta);

[dctSignal, fftSignal, dstSignal, transformSignal] = ecg_compression.apply_transforms(quantized);
[dctDelta, fftDelta, dstDelta, transformDelta] = ecg_compression.apply_transforms(delta);
[dctDelta2, fftDelta2, dstDelta2, transformDelta2] = ecg_compression.apply_transforms(delta2);

huffmanSignal = ecg_compression.huffman_encode(quantized);
huffmanDelta = ecg_compression.huffman_encode(delta);
huffmanDelta2 = ecg_compression.huffman_encode(delta2);

bitCounts.signal = compute_bitcount(quantized, opts.QuantizationBits);
bitCounts.delta = compute_bitcount(delta, opts.QuantizationBits);
bitCounts.delta2 = compute_bitcount(delta2, opts.QuantizationBits);
bitCounts.linearModel = compute_bitcount(linearPayload, opts.QuantizationBits);
bitCounts.DCT = compute_bitcount(dctSignal, opts.QuantizationBits);
bitCounts.FFT = compute_bitcount(fftSignal, opts.QuantizationBits);
bitCounts.DST = compute_bitcount(dstSignal, opts.QuantizationBits);
bitCounts.DCTDelta = compute_bitcount(dctDelta, opts.QuantizationBits);
bitCounts.FFTDelta = compute_bitcount(fftDelta, opts.QuantizationBits);
bitCounts.DSTDelta = compute_bitcount(dstDelta, opts.QuantizationBits);
bitCounts.DCTDelta2 = compute_bitcount(dctDelta2, opts.QuantizationBits);
bitCounts.FFTDelta2 = compute_bitcount(fftDelta2, opts.QuantizationBits);
bitCounts.DSTDelta2 = compute_bitcount(dstDelta2, opts.QuantizationBits);
bitCounts.huffman = numel(huffmanSignal);
bitCounts.huffmanDelta = numel(huffmanDelta);
bitCounts.huffmanDelta2 = numel(huffmanDelta2);

numSamples = numel(quantized);
bitsPerSample.signal = bitCounts.signal / numSamples;
bitsPerSample.huffman = bitCounts.huffman / numSamples;
bitsPerSample.huffmanDelta = bitCounts.huffmanDelta / numSamples;
bitsPerSample.huffmanDelta2 = bitCounts.huffmanDelta2 / numSamples;

compression.delta = divide_safe(bitCounts.signal, bitCounts.delta);
compression.delta2 = divide_safe(bitCounts.signal, bitCounts.delta2);
compression.linear = divide_safe(bitCounts.signal, bitCounts.linearModel);
compression.huffman = divide_safe(bitsPerSample.signal, bitsPerSample.huffman);
compression.huffmanDelta = divide_safe(bitsPerSample.signal, bitsPerSample.huffmanDelta);
compression.huffmanDelta2 = divide_safe(bitsPerSample.signal, bitsPerSample.huffmanDelta2);
compression.DCT = divide_safe(bitCounts.signal, bitCounts.DCT);
compression.FFT = divide_safe(bitCounts.signal, bitCounts.FFT);
compression.DST = divide_safe(bitCounts.signal, bitCounts.DST);
compression.deltaDCT = divide_safe(bitCounts.signal, bitCounts.DCTDelta);
compression.deltaFFT = divide_safe(bitCounts.signal, bitCounts.FFTDelta);
compression.deltaDST = divide_safe(bitCounts.signal, bitCounts.DSTDelta);
compression.delta2DCT = divide_safe(bitCounts.signal, bitCounts.DCTDelta2);
compression.delta2FFT = divide_safe(bitCounts.signal, bitCounts.FFTDelta2);
compression.delta2DST = divide_safe(bitCounts.signal, bitCounts.DSTDelta2);

results = struct();
results.parameters = struct('signalPath', signalPath, ...
    'linearHistory', opts.LinearHistory, ...
    'quantizationBits', opts.QuantizationBits);
results.models.linearCoefficients = coefficients;
results.transforms.signal = transformSignal;
results.transforms.delta = transformDelta;
results.transforms.delta2 = transformDelta2;
results.bitCounts = bitCounts;
results.bitsPerSample = bitsPerSample;
results.compressionRates = compression;
end

function count = compute_bitcount(vector, quantizationBits)
if isempty(vector)
    count = 0;
    return;
end

prepared = ecg_compression.prepare_signal_vector(vector, quantizationBits);
avgBits = ecg_compression.average_bits_per_symbol(prepared(:));
count = avgBits * numel(prepared);
end

function ratio = divide_safe(numerator, denominator)
if denominator == 0
    ratio = NaN;
else
    ratio = numerator / denominator;
end
end
