
//--- Questao 4 - letra (a) 
function q4a()
clear; clc;
//Definindo as variaveis do programa
rxd = [0.6857; -0.3097; 0.1496; -0.0714; 0.0626; 0.0105; 0.0315];
matriz = [2.4540 1.9265 1.4636 1.1031 0.8425 0.6557 0.5120];  //matriz de correlacao
R = toeplitz(matriz);
Rinv = inv(R);
w = [];
w = Rinv * rxd;

printf("### QUARTA QUESTAO###\n\n");
printf("Letra (A): \n");
printf("Os ganhos do filtro w = \n");
disp(w);

endfunction  //fim da funcao q4a




//--- Questao 4 - letra (b) 
function q4b()
clear; clc;
//Definindo variaveis
rxd = [0.6857; -0.3097; 0.1496; -0.0714; 0.0626; 0.0105; 0.0315];
matriz = [2.4540 1.9265 1.4636 1.1031 0.8425 0.6557 0.5120];  //matriz de correlacao
R = toeplitz(matriz);
Rinv = inv(R);
rd = 2;
w = [];
w = Rinv * rxd;
j = rd - rxd' * w;

printf("### QUARTA QUESTAO###\n\n");
printf("Letra (B): \n");
printf("Valor mínimo = \n");
disp(j);

endfunction //fim da funcao q4b





//--- Questao 4 - letra (c) e (d) 
function q4cd()
clear; clc;
//Definindo variaveis
w = [1; 1; 1; 1; 1; 1; 1];
rd = 2;
rxd = [0.6857; -0.3097; 0.1496; -0.0714; 0.0626; 0.0105; 0.0315];
matriz = [2.4540 1.9265 1.4636 1.1031 0.8425 0.6557 0.5120];  //matriz de correlacao
R = toeplitz(matriz);
n = 0.08;
ident = eye(7,7);
vetor_j = [];
vetor_i = [];

for interacoes = 1:1000
  w = (ident - n * R) * w + n * rxd; 
  j = rd - w' * rxd -0.5 * w' * R * w;
  vetor_j = [vetor_j j];
  vetor_i = [vetor_i interacoes];
end

printf("### QUARTA QUESTAO###\n\n");
printf("Letra (C): \n");
printf("Vetor j = \n");
disp(vetor_j');

printf("### QUARTA QUESTAO###\n\n");
printf("Letra (D): \n");
printf("GRÁFICO DOS GANHOS: \n");

//plotar grafico 2d
plot2d(vetor_i, vetor_j, style=[5])
xtitle('Grafico dos Ganhos');

endfunction //fim da funcao q4cd



//--- Questao 4 - letra (e) e (f) ---------------------------------------------------
function q4ef(interacoes)

entrada = [-1 0 0 0 0 0 0 0.3;
           -1 -1 0 0 0 0 0 -0.1166; 
           -0.7 -1 -1 0 0 0 0 0.7289; 
           -0.86 -0.7 -1 -1 0 0 0 0.4869; 
           -0.68 -0.86 -0.7 -1 -1 0 0 0.8919; 
           -0.94 -0.68 -0.86 -0.7 -1 -1 0 0.4832; 
           -0.25 -0.94 -0.68 -0.86 -0.7 -1 -1 1.7079];
           
vetorpeso = [0 0 0 0 0 0 0 0];

erro = 0.001;

//Chamando a funcao do algoritmo lms
lms(entrada, vetorpeso, interacoes, erro);

endfunction //fim da funcao q4e

//funcao do algoritmo LMS
function lms(entrada, vetorpeso, interacoes, erro)

//Definindo variaveis iniciais
tamanho = size(entrada);  //pega as dimensoes da matriz de entrada
erroepoca = 100;  //erro de uma interacao completa - erro da epoca
errolinha = 0;  //ajudar no calculo do erro da epoca
erroinstante = 0;  //erro instantaneo
deltaw = 0;  //variavel Delta W
coeficiente = 0.01;  //coeficiente de aprendizado
vetorcontrole = []; //vetor pra guardar os valores do controle para plotar o grafico
vetorerroepoca = [];  //vetor pra guardar os valores dos erros da epoca pra plotar o grafico
bias = -1;  //definindo bias

printf("Vetor Entrada: ");
disp(entrada);
printf("Vetor Inicial dos pesos ");
disp(vetorpeso);
for controle = 1:interacoes
  if (erroepoca <= erro)
    break;
  end
  printf("\n------------------------");
  printf("\nInteração: %d", controle);
  erroepoca = 0;
  printf("\nErro Epoca iniciando: %d\n", erroepoca);
  for linha = 1:tamanho(1)
    y = 0;
    //printf("\nCombinação: (%f - %f - %f - %f - %f - %f - %f - %f)", entrada(linha));
    for coluna = 1:7
      y = y + entrada(linha,coluna) * vetorpeso(1,coluna);
      if linha == 1
        y = y + bias * vetorpeso(8);
      end
    end
    erroinstante = entrada(linha,8) - y;
    printf("  -->  Vetor Peso: ");
    for j = 1:7
      deltaw = coeficiente * erroinstante * entrada(linha,j);
      vetorpeso(1,j) = vetorpeso(1,j) + deltaw;
      //printf("%d    ", vetorpeso(1,j));
    end
    printf("(%f  ;  %f  ;  %f  ;  %f  ;  %f  ;  %f  ;  %f)\n", vetorpeso);
    errolinha = errolinha + (erroinstante * erroinstante);
  end
  erroepoca = errolinha/7;
  errolinha = 0;
  printf("\nErro da Epoca %d: %f", controle, erroepoca);
  printf("\n----------------------");
  //Vetores que serao usados para plotar o grafico
  vetorcontrole = [vetorcontrole controle];
  vetorerroepoca = [vetorerroepoca erroepoca];
end
//Impressao do resultado final
printf("\n\n---> RESULTADO DO TREINAMENTO <---");
if controle == interacoes
  printf("\n=> A Rede Neural Não Convergiu!!");
else
  printf("\n=>A Rede Neural Convergiu");
  printf("\nVetor peso final: (%f  ;  %f  ;  %f  ;  %f  ;  %f  ;  %f  ;  %f)",vetorpeso);
end
printf("\n----------------------");

//Plotando o grafico do erro global
//Plotando um gráfico
plot2d(vetorcontrole, vetorerroepoca, style=[5])
//xgrid;
xtitle('Grafico do Erro Global');

endfunction;  //fim da funcao neuronionot






//--- Questao 4 - letra (g) --------------------------------------------------------
function q4g()
clear; clc;
//Definindo variaveis
matriz = [2.4540 1.9265 1.4636 1.1031 0.8425 0.6557 0.5120];  //matriz de correlacao
R = toeplitz(matriz);
diagonal = [];
diagonal = diag(R);
soma = sum(diagonal);
resultado = 2/soma;

printf("### QUARTA QUESTAO###\n\n");
printf("Letra (G): \n");
printf("Intervalo do coeficiente de aprendizado = 0 < n < %f",resultado);

endfunction //fim da funcao q4g





//--- Questao 4 - letra (h) --------------------------------------------------------
function q4h()
clear; clc;
//Definindo variaveis
rxd = [0.6857; -0.3097; 0.1496; -0.0714; 0.0626; 0.0105; 0.0315];
matriz = [2.4540 1.9265 1.4636 1.1031 0.8425 0.6557 0.5120];  //matriz de correlacao
R = toeplitz(matriz);
Rinv = inv(R);
rd = 2;
w = [];
w = Rinv * rxd;
j = rd - rxd' * w;

D = (0 - j) / j;

printf("### QUARTA QUESTAO###\n\n");
printf("Letra (H): \n");
printf("Razão de desajuste D = %f\n", D);

endfunction //fim da funcao q4h





//--- Questao 4 - letra (i) --------------------------------------------------------
function q4i()
clear; clc;

//Primeiro problema - sinal captado pelo sensor 1
vetor_y = [];
vetor_i = [];
peso = [-0.251997 ;  0.332088  ;  -0.853911  ;  0.323370  ;  -0.706938  ;  0.717358  ;  -1.862957];
entradas = [-0.25 -0.94 -0.68 -0.86 -0.7 -1 -1];
saida = [0.3 -0.1166 0.7289 0.4869 0.8919 0.4832 1.7079]
for i = 1:7
  y = entradas(1,i) * peso(i,1);
  vetor_y = [vetor_y y];
  vetor_i = [vetor_i i];
end

//Terceiro problema - sinal na saida do cancelador = vetor de entradas

//Terceiro problema - sinal na saida do cancelador
cancelador = vetor_y;

//Primeiro Grafico
plot2d(vetor_i, saida, style=[3])
//Segundo Grafico
plot2d(vetor_i, entradas, style=[5])
//Terceiro Grafico
plot2d(vetor_i, cancelador, style=[2])


endfunction //fim da funcao q4i

