fileID=fopen("EKG_norm.txt","r");
sinal = fscanf(fileID, "%f\n");

%QUANTETIZAÇÃO
audiowrite('EKG_norm.wav', sinal, 250, 'BitsPerSample', 16);
sinal = audioread('EKG_norm.wav');

n_colunas=4;

%MODELO LINEAR
[x,y]=comp(sinal,n_colunas);
model= fitlm(x,y);
A=model.Coefficients{:,1};
X=x(1,:);
y2=predict(model,x);
erro=calc_erro(sinal,y2,n_colunas);
sinal_linear=info_to_vetor(n_colunas,A,X,erro); %[N A(1) .. A(N) X(1) .. x(N) E(N+1) .. E(END)] 

%MODELAÇÃO DELTA
sinal_delta=delta_mod(sinal);
sinal_delta2=delta_mod(sinal_delta);

%OUTPUT
figure('Name','Delta Modulation')
plot(sinal_delta);

%OUTPUT
figure('Name','Linear Model')
plot(sinal_linear);

sinal_linear=sinal_linear(:);

format compact

fprintf('TRANSFORMADAS - SINAL FONTE\n');
[aftercomp_DCT, aftercomp_FFT, aftercomp_DST]=transformadas(sinal);
fprintf('TRANSFORMADAS - SINAL DELTA\n');
[aftercomp_DCT_delta, aftercomp_FFT_delta, aftercomp_DST_delta]=transformadas(sinal_delta);
fprintf('TRANSFORMADAS - SINAL DELTA2\n');
[aftercomp_DCT_delta2, aftercomp_FFT_delta2, aftercomp_DST_delta2]=transformadas(sinal_delta2);
[vetorHUFF] = Huff_Coding(sinal);
[vetorHUFF_delta] = Huff_Coding(sinal_delta);
[vetorHUFF_delta2] = Huff_Coding(sinal_delta2);

%PREPARAR VETOR PARA POR NO FICHEIRO
vetor_sinal = preparar_vetor(sinal); 
vetor_delta = preparar_vetor(sinal_delta); 
vetor_delta2 = preparar_vetor(sinal_delta2); 
vetor_linear = preparar_vetor(sinal_linear); 
vetor_huffman = vetorHUFF;
vetor_huffman_delta = vetorHUFF_delta;
vetor_huffman_delta2 = vetorHUFF_delta2;
vetor_DCT = preparar_vetor(aftercomp_DCT); 
vetor_FFT = preparar_vetor(aftercomp_FFT); 
vetor_DST = preparar_vetor(aftercomp_DST);
vetor_DCT_delta = preparar_vetor(aftercomp_DCT_delta); 
vetor_FFT_delta = preparar_vetor(aftercomp_FFT_delta); 
vetor_DST_delta = preparar_vetor(aftercomp_DST_delta); 
vetor_DCT_delta2 = preparar_vetor(aftercomp_DCT_delta2); 
vetor_FFT_delta2 = preparar_vetor(aftercomp_FFT_delta2); 
vetor_DST_delta2 = preparar_vetor(aftercomp_DST_delta2); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%CALCULAR BITS 
fprintf('**************************Nº DE BITS**************************\n')
num_bits_vetor_sinal = num_med_bits(vetor_sinal)*length(vetor_sinal);
fprintf('Bits do sinal:')
disp(num_bits_vetor_sinal)

num_bits_codificacao_sinal = num_bits_vetor_sinal/length(sinal);
fprintf('Numero de bits de codificaçao do sinal:')
disp(num_bits_codificacao_sinal)

num_bits_vetor_delta = num_med_bits(vetor_delta)*length(vetor_delta);
fprintf('Bits do sinal com codificação delta:')
disp(num_bits_vetor_delta)

num_bits_vetor_delta2 = num_med_bits(vetor_delta2)*length(vetor_delta2);
fprintf('Bits do sinal com codificação delta2:')
disp(num_bits_vetor_delta2)

num_bits_vetor_linear = num_med_bits(vetor_linear)*length(vetor_linear);
fprintf('Bits do sinal com codificação modelo linear:')
disp(num_bits_vetor_linear)

num_bits_vetor_huffman = length(vetor_huffman);
fprintf('Bits do sinal com codificacao huffman:')
disp(num_bits_vetor_huffman)

num_bits_codificacao_huffman = num_bits_vetor_huffman/length(sinal);
fprintf('Numero de bits de codificaçao huffman:')
disp(num_bits_codificacao_huffman)

num_bits_vetor_huffman_delta = length(vetor_huffman_delta);
fprintf('Bits do sinal com codificacao huffman + delta:')
disp(num_bits_vetor_huffman_delta)

num_bits_codificacao_huffman_delta = num_bits_vetor_huffman_delta/length(sinal);
fprintf('Numero de bits de codificaçao huffman + delta:')
disp(num_bits_codificacao_huffman_delta)

num_bits_vetor_huffman_delta2 = length(vetor_huffman_delta2);
fprintf('Bits do sinal com codificacao huffman + delta2:')
disp(num_bits_vetor_huffman_delta2)

num_bits_codificacao_huffman_delta2 = num_bits_vetor_huffman_delta2/length(sinal);
fprintf('Numero de bits de codificaçao huffman + delta2:')
disp(num_bits_codificacao_huffman_delta2)

num_bits_vetor_DCT = num_med_bits(vetor_DCT)*length(vetor_DCT);
fprintf('Bits do sinal com codificação DCT:')
disp(num_bits_vetor_DCT)

num_bits_vetor_FFT = num_med_bits(vetor_FFT)*length(vetor_FFT);
fprintf('Bits do sinal com codificação FFT:')
disp(num_bits_vetor_FFT)

num_bits_vetor_DST = num_med_bits(vetor_DST)*length(vetor_DST);
fprintf('Bits do sinal com codificação DST:')
disp(num_bits_vetor_DST)

num_bits_vetor_DCT_delta = num_med_bits(vetor_DCT_delta)*length(vetor_DCT_delta);
fprintf('Bits do sinal com codificação delta + DCT:')
disp(num_bits_vetor_DCT_delta)

num_bits_vetor_FFT_delta = num_med_bits(vetor_FFT_delta)*length(vetor_FFT_delta);
fprintf('Bits do sinal com codificação delta + FFT:')
disp(num_bits_vetor_FFT_delta)

num_bits_vetor_DST_delta = num_med_bits(vetor_DST_delta)*length(vetor_DST_delta);
fprintf('Bits do sinal com codificação delta + DST:')
disp(num_bits_vetor_DST_delta)

num_bits_vetor_DCT_delta2 = num_med_bits(vetor_DCT_delta2)*length(vetor_DCT_delta2);
fprintf('Bits do sinal com codificação delta2 + DCT:')
disp(num_bits_vetor_DCT_delta2)

num_bits_vetor_FFT_delta2 = num_med_bits(vetor_FFT_delta2)*length(vetor_FFT_delta2);
fprintf('Bits do sinal com codificação delta2 + FFT:')
disp(num_bits_vetor_FFT_delta2)

num_bits_vetor_DST_delta2 = num_med_bits(vetor_DST_delta2)*length(vetor_DST_delta2);
fprintf('Bits do sinal com codificação delta2 + DST:')
disp(num_bits_vetor_DST_delta2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('***********************Compression Rate***********************\n')
fprintf('CR delta:')
disp(num_bits_vetor_sinal/num_bits_vetor_delta)

fprintf('CR delta2:')
disp(num_bits_vetor_sinal/num_bits_vetor_delta2)

fprintf('CR modelo linear:')
disp(num_bits_vetor_sinal/num_bits_vetor_linear)

fprintf('CR huffman:')
disp(num_bits_codificacao_sinal/num_bits_codificacao_huffman)

fprintf('CR huffman + delta:')
disp(num_bits_codificacao_sinal/num_bits_codificacao_huffman_delta)

fprintf('CR huffman + delta2:')
disp(num_bits_codificacao_sinal/num_bits_codificacao_huffman_delta2)

fprintf('CR DCT:')
disp(num_bits_vetor_sinal/num_bits_vetor_DCT)

fprintf('CR FFT:')
disp(num_bits_vetor_sinal/num_bits_vetor_FFT)

fprintf('CR DST:')
disp(num_bits_vetor_sinal/num_bits_vetor_DST)

fprintf('CR delta + DCT:')
disp(num_bits_vetor_sinal/num_bits_vetor_DCT_delta)

fprintf('CR delta + FFT:')
disp(num_bits_vetor_sinal/num_bits_vetor_FFT_delta)

fprintf('CR delta + DST:')
disp(num_bits_vetor_sinal/num_bits_vetor_DST_delta)

fprintf('CR delta2 + DCT:')
disp(num_bits_vetor_sinal/num_bits_vetor_DCT_delta2)

fprintf('CR delta2 + FFT:')
disp(num_bits_vetor_sinal/num_bits_vetor_FFT_delta2)

fprintf('CR delta2 + DST:')
disp(num_bits_vetor_sinal/num_bits_vetor_DST_delta2)