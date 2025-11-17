function code = huffman_encode(signal)
%HUFFMAN_ENCODE Apply MATLAB's huffman coding helper to the signal.
%   code = HUFFMAN_ENCODE(signal) returns a vector containing the encoded
%   bitstream.

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
