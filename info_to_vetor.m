function [vetor_info] = info_to_vetor(n,A,X,erro)

len_total=1+length(A)+length(X)+length(erro);
vetor_info=zeros(len_total,1);

vetor_info(1)=n;
vetor_info(2:1+length(A))=A;
vetor_info(2+length(A):2+length(A)+length(X)-1)=X;
vetor_info(len_total-length(erro)+1:len_total)=erro;


end