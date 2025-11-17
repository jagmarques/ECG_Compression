function code = huffman_encode(signal)
% Encode the waveform with MATLAB's Huffman helper.

arguments
    signal (:, 1) double
end

if isempty(signal)
    code = [];
    return;
end

symbols = unique(signal);
counts = histc(signal, symbols); %#ok<HISTC>
probabilities = counts / numel(signal);

[dict, ~] = huffmandict(symbols, probabilities); %#ok<HUFFMAN>
code = huffmanenco(signal, dict);
end
