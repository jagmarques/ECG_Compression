function [vetor_preparado] = preparar_vetor(vetor)
    vetor_preparado=vetor(1);
    step=2/(2^16);

    for i=2:length(vetor)
    	vetor_preparado(i)=floor((vetor(i-1)+1)/step);
    end
end