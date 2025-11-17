# ECG Compression

A cleaned-up MATLAB implementation that showcases several ECG (electrocardiogram) compression techniques: delta modulation, Huffman coding, linear prediction, and frequency-domain transforms (DCT/FFT/DST).
The repository now exposes a single pipeline that loads a signal, evaluates every method, and summarizes the bit requirements and compression ratios.

## Repository layout

```
├── data/                # Sample ECG files (normalized TXT/CSV)
├── docs/                # Reference material
├── src/+ecg_compression # MATLAB package with reusable helpers
└── main.m               # Entry point that executes the full pipeline
```

## Requirements

- MATLAB R2021a or newer
- Statistics and Machine Learning Toolbox (`fitlm`)
- Signal Processing Toolbox (`dct`, `idct`, `dst`, `idst`)
- Communications Toolbox (`huffmandict`, `huffmanenco`)

## Usage

1. Open MATLAB in this repository.
2. Run `main` (or press **Run** inside the editor).
3. Inspect the printed bit counts, per-sample rates, and compression ratios.

The script automatically adds `src/` to the MATLAB path and executes the pipeline against `data/EKG_norm.txt`.
To run a different file, call the function directly:

```matlab
addpath(fullfile(pwd, 'src'));
results = ecg_compression.run_pipeline('path/to/other_signal.csv', ...
    'LinearHistory', 6, ...
    'QuantizationBits', 14);
```

The returned `results` struct exposes:

- `parameters` – configuration used for the run
- `models.linearCoefficients` – regression coefficients for reproduction
- `transforms` – PRD metrics for each transform and signal variant
- `bitCounts` – total bits required by every representation
- `bitsPerSample` – entropy estimates for the original/delta/Huffman variants
- `compressionRates` – convenience ratios (original bits divided by alternative bits)

## Testing and linting

This project currently targets MATLAB scripts without an automated CI harness.
If you add unit tests in the future, prefer MATLAB's `runtests` framework and update this section with the relevant command.
