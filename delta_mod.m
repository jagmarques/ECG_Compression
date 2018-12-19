function [delta_mod] = delta_mod(vetor) 
    delta_mod=zeros(length(vetor)-1,1);
    
    for i=1:length(vetor)-1
        delta_mod(i)=vetor(i+1)-vetor(i);
    end
end