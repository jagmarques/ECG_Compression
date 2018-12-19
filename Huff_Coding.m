function [vetorHUFF] = Huff_Coding(Y)

    %getting array of unique values
    Z = unique (Y);

    %counting occurences of each element and listing it to a new array
    countElY=histc(Y,Z); %# get the count of elements
    p = countElY/numel(Y); %getting the probability distribution

    [dict,avglen] = huffmandict(Z,p); % Create dictionary.

    vetorHUFF = huffmanenco(Y,dict); % Encode the data.

end