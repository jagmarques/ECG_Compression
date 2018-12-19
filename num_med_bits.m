function [num_medio_bits] = num_med_bits(A)
num_medio_bits=0;
simbolos=unique(A);
len=length(simbolos);
cnts = nan(1, len);


for i=1:length(simbolos)
    n=length(find(A==simbolos(i)));
    cnts(i) = n;
    num_medio_bits = num_medio_bits + (-(n/length(A))*log2(n/length(A)));
end

end

