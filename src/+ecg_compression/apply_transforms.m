function [dctSignal, fftSignal, dstSignal, metrics] = apply_transforms(signal, opts)
% Apply DCT, FFT, and DST heuristics with optional plotting.

arguments
    signal (:, 1) double
    opts.CreatePlots (1, 1) logical = false
end

metrics = struct();
referenceEnergy = sum(signal .^ 2);

[dctSignal, metrics.DCT] = reconstruct_with_threshold( ...
    dct(signal), @idct, 0.22, signal, referenceEnergy, opts.CreatePlots, 'DCT');

[fftSignal, metrics.FFT] = reconstruct_with_threshold( ...
    fft(signal), @(coeffs) real(ifft(coeffs)), 25, signal, referenceEnergy, opts.CreatePlots, 'FFT');

[dstSignal, metrics.DST] = reconstruct_with_threshold( ...
    dst(signal), @idst, 15, signal, referenceEnergy, opts.CreatePlots, 'DST');
end

function [reconstructed, info] = reconstruct_with_threshold(coeffs, inverseFunc, threshold, reference, referenceEnergy, createPlots, label)
filtered = coeffs;
mask = abs(filtered) < threshold;
filtered(mask) = 0;
reconstructed = inverseFunc(filtered);

errorSignal = reference - reconstructed;
prd = sqrt(sum(errorSignal .^ 2) / referenceEnergy);

info = struct('threshold', threshold, 'prd', prd);

if createPlots
    figure('Name', sprintf('%s Compression', label)); %#ok<LFIG>
    plot(reconstructed);
    title(sprintf('%s Compression', label));
    xlabel('Sample');
    ylabel('Amplitude');

    figure('Name', sprintf('%s Error', label)); %#ok<LFIG>
    plot(errorSignal);
    title(sprintf('%s Error', label));
    xlabel('Sample');
    ylabel('Amplitude');
end
end
