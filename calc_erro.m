function [erro] = calc_erro(sinal, y2, pos_inicial)

erro = zeros(length(sinal)-pos_inicial,1);
i=1;

while(i<length(sinal)-pos_inicial+1)
    erro(i)=sinal(pos_inicial+i)-y2(i);
    
    i=i+1;
end

%sinal=[12 32 13 42 57 56 27 48 91 10];