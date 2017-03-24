//Ricardo de Sousa Britto
//Questao 4
clear;
clc;
lines(0);

//--------Parâmetros de definição da rede-----------------------------

Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida
interacoes_geral = 100000;//numero total de interações da rede
erro = 0.01;// Erro a ser enconrado pela rede
coeficiente = 0.5;  //coeficiente de aprendizado
classe1 = 60;
classe2 = 10;
classe3 = 10;
classe4 = 10;
classe5 = 10;
//---------------------------------------------------------------------
//---------Variáveis Utilizadas na Implementação da Rede---------------
//entrada da camada oculta, a primeira coluna é referente aos bias
c1=0;
c2=0;
c3=0;
c4=0;
c5=0;
d1 = [1 ;0 ;0 ;0 ;0 ];
d2 = [0 ;1 ;0 ;0 ;0 ];
d3 = [0 ;0 ;1 ;0 ;0 ];
d4 = [0 ;0 ;0 ;1 ;0 ];
d5 = [0 ;0 ;0 ;0 ;1 ];
X1 = [];
X2 = [];
X3 = [];
X4 = [];
X5 = [];
D1 = [];
D2 = [];
D3 = [];
D4 = [];
D5 = [];
for ab = 1:10000000
  x = 2*rand(1,1,'uniform')-1;
  y = 2*rand(1,1,'uniform')-1;
  if (((x^2+y^2)<=1) & (c1<classe1))
    aux1 = [-1 ; x ; y];
    X1 = [X1 aux1];
    D1 = [D1  d1];
    c1 = c1 + 1;
  end
    
  if (((x^2+y^2)>1) & (x>0) & (y>0) & (c2<classe2))
    aux2 = [-1 ; x ; y];
    X2 = [X2 aux2];
    D2 = [D2  d2];
    c2 = c2 + 1;
  end
  
  if (((x^2+y^2)>1) & (x<0) & (y>0) & (c3<classe3))
    aux3 = [-1 ; x ; y];
    X3 = [X3 aux3];
    D3 = [D3  d3];
    c3 = c3 + 1;
  end
  
  if (((x^2+y^2)>1) & (x<0) & (y<0) & (c4<classe4))
    aux4 = [-1 ; x ; y];
    X4 = [X4 aux4];
    D4 = [D4  d4];
    c4 = c4 + 1;
  end
  
  if (((x^2+y^2)>1) & (x>0) & (y<0) & (c5<classe5))
    aux5 = [-1 ; x ; y];
    X5 = [X5 aux5];
    D5 = [D5  d5];
    c5 = c5 + 1;
  end
  if (c1 >= classe1) & (c2 >= classe2) & (c3 >= classe3) & (c4 >= classe4) & (c5 >= classe5)
    break;
  end
end
X = [X1 X2 X3 X4 X5];
//Saídas desejadas da camada de saída

Ds = [D1  D2  D3  D4  D5];
     
//

//pesos da camada oculta, a primeira linha é referente ao peso do bias
tam_x = size(X);
Wo = [];
for i = 1:Qco
  for j = 1:tam_x(1) 
    p_o = 2*rand(1,1,'uniform')-1;
    Wo(j,i) = p_o;
  end 
end
//Peso da camada de Saida, a primeira linha é referente ao peso do bias
Ws = [];
//tam_s = size(Ds);
tam = Qco+1;
for i = 1:Qcs 
  for j = 1:tam 
    p_s = 2*rand(1,1,'uniform')-1;
    Ws(i,j) = p_s;
  end
end      


//valores de saida da camada oculta, que de toda sorte, são os valores de entrada da camada de saida
//sendo que a primeira linha é referente ao bias
Yo = [-1];

Ys = [];//valores de saida da camada de saida
DeltaO = [];//Gradiente local da camada oculta
DeltaS = [];//Gradiente local da camada de saida
Somatorio = [];//Somatorio para cálculo de DeltaO
Vo = 0;//valor da soma ponderada da camada oculta
Vs = 0;//valor da soma ponderada da camada de saida

//tamanho = size(X);  //pega as dimensoes da matriz de entrada
erroepoca = 100;  //erro de uma interacao completa - erro da epoca
errolinha = 0;  //ajudar no calculo do erro da epoca
erroQ = [];  //erro instantaneo
vetorcontrole = []; //vetor pra guardar os valores do controle para plotar o grafico
vetorerroepoca = [];  //vetor pra guardar os valores dos erros da epoca pra plotar o grafico
validacao = [];// vetor que armazena os valores validados da rede
linhaO = 0;
Woa = Wo';
//Wsa = Ws';

//------------------------------------------------------------------------------------------------------------------------
//----------------Implementação da computação pra frente------------------------------------------------------------------  
  
 for interacoes = 1:interacoes_geral
 if (erroepoca <= erro)
    break;
  end
 erroepoca = 0;
 erroQ=0;
  for  i = 1:tam_x(2)    
    Woa = Wo';
    Wsa = Ws;
    //inicio da camada oculta
    Qco1 = Qco;
    for j = 1:Qco1 //numero de neuronios da camada oculta     
         Vo = Woa(j,:) * X(:,i);                
         Yo(j+1) = 1/(1+(exp(-Vo)));
         
    end//fim da camada oculta
    Qcs1 = Qcs;
    for h = 1:Qcs1//numero de neuronios da camada de saida 
        Vs = Wsa(h,:) * Yo(:,1);//inicio da camada de saída
        Ys = 1/(1+(exp(-Vs)));
        errolinha = Ds(h,i) - Ys;
        erroQ = erroQ + (errolinha^2)/2;
        DeltaS(h) = errolinha * Ys * (1-Ys);               
    
        Qco2 = Qco + 1;
        for o = 1:Qco2//numero de neuronios na camada oculta + bias
            Ws(h,o) = Ws(h,o) + coeficiente * DeltaS(h) * Yo(o);
        end         
    end   
//-----------------------------------------------------------------------------------------------------------------------------
//----------------Implementação da retropropagação-----------------------------------------------------------------------------
    Qco3 = Qco;
    Qcs2 = Qcs;
    
    for z = 1:Qco3
      Somatorio = 0;
      for g = 1:Qcs2
        Somatorio = Somatorio + DeltaS(g) * Ws(g,z+1);
      end
      DeltaO(z) =  Yo(z+1) * (1-Yo(z+1)) * Somatorio;
    end
    Qco4 = Qco;
    for m = 1:Qco4//numero de neuronios na camada oculta
        Qco5 = tam_x(1);
        for n = 1:Qco5//numero de neuronios na camada oculta + bias
            Wo(n,m) = Wo(n,m) + coeficiente * DeltaO(m) * X(n,i);
        end         
    end
    
  end   
 
 //-------------------------------------------------------------------
 erroepoca = erroQ;
 //--------------------------------------------------------------------------------------------------------------------------------
 //----------------Impressão do Gráfico--------------------------------------------------------------------------------------------
 vetorerroepoca = [vetorerroepoca erroQ];
 vetorcontrole  = [vetorcontrole interacoes];
  printf("Interação [%d] = %f\n",interacoes,erroQ);
end
 
 //----------------------------Validação-----------------------------
 for  i = 1:tam_x(2)    
    Woa = Wo';
    Wsa = Ws;
    Qco1 = Qco;
    for j = 1:Qco1 //numero de neuronios da camada oculta     
         Vo = Woa(j,:) * X(:,i);                
         Yo(j+1) = 1/(1+(exp(-Vo)));
         
    end
    Qcs1 = Qcs;
    for h = 1:Qcs1//numero de neuronios da camada de saida 
        Vs = Wsa(h,:) * Yo(:,1);
        validacao(h,i) = 1/(1+(exp(-Vs)));
                                   
    end   
 end
 subplot(1,2,1);
 plot2d(vetorcontrole, vetorerroepoca, style=[5]);
 subplot(1,2,2);
 for i = 1:Qcs
   plot2d( 1:tam_x(2), Ds(i,:), style=[10]);
   plot2d( 1:tam_x(2), validacao(i,:), style=[5]);
 end
 
