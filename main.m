%% ECG Compression Demo Entry Point
% This script bootstraps MATLAB with the local src/ directory and executes
% the orchestrated pipeline using the bundled sample signal.

projectRoot = fileparts(mfilename('fullpath'));
addpath(fullfile(projectRoot, 'src'));

defaultSignal = fullfile(projectRoot, 'data', 'EKG_norm.txt');
if ~isfile(defaultSignal)
    error('Sample signal not found at %s', defaultSignal);
end

results = ecg_compression.run_pipeline(defaultSignal);

fprintf('Processed signal: %s\n', results.parameters.signalPath);

fprintf('\nBit counts (bits):\n');
disp(results.bitCounts);

fprintf('Bits per sample:\n');
disp(results.bitsPerSample);

fprintf('Compression rates (higher is better):\n');
disp(results.compressionRates);
