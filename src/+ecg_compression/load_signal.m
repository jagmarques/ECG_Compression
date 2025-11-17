function signal = load_signal(filePath)
%LOAD_SIGNAL Load a normalized ECG signal from disk.
%   signal = LOAD_SIGNAL(filePath) reads a column vector from either a text
%   or CSV file. Missing values are removed automatically.

arguments
    filePath (1, :) char
end

if ~isfile(filePath)
    error('ecg_compression:load_signal:MissingFile', ...
        'Signal file "%s" not found.', filePath);
end

[~, ~, ext] = fileparts(filePath);
ext = lower(ext);

switch ext
    case '.txt'
        data = readmatrix(filePath, 'FileType', 'text');
    case '.csv'
        data = readmatrix(filePath);
    otherwise
        error('ecg_compression:load_signal:UnsupportedFormat', ...
            'Only .txt and .csv inputs are supported.');
end

signal = data(:);
signal = signal(~isnan(signal));
end
