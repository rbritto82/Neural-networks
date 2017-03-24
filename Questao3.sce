//Ricardo de Sousa Britto
//Questao 3
clear;
clc;
lines(0);

//--------Parâmetros de definição da rede de especialista da C1-----------------------------

Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida
interacoes_geral = 1000;//numero total de interações da rede
erro = 0.004;// Erro a ser enconrado pela rede
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
Dc1 = [];
Dc2 = [];
Dc3 = [];
Dc4 = [];
Dc5 = [];
for ab = 1:10000000
  x = 2*rand(1,1,'uniform')-1;
  y = 2*rand(1,1,'uniform')-1;
  if (((x^2+y^2)<=1) & (c1<classe1))
    aux1 = [-1 ; x ; y];
    X1 = [X1 aux1];
    D1 = [D1  d1];
    Dc1 = [Dc1  d1];
    Dc2 = [Dc2  d2];
    Dc3 = [Dc3  d3];
    Dc4 = [Dc4  d4];
    Dc5 = [Dc5  d5];
    c1 = c1 + 1;
  end
    
  if (((x^2+y^2)>1) & (x>0) & (y>0) & (c2<classe2))
    aux2 = [-1 ; x ; y];
    X2 = [X2 aux2];
    D2 = [D2  d2];
    Dc1 = [Dc1  d1];
    Dc2 = [Dc2  d2];
    Dc3 = [Dc3  d3];
    Dc4 = [Dc4  d4];
    Dc5 = [Dc5  d5];
    c2 = c2 + 1;
  end
  
  if (((x^2+y^2)>1) & (x<0) & (y>0) & (c3<classe3))
    aux3 = [-1 ; x ; y];
    X3 = [X3 aux3];
    D3 = [D3  d3];
    Dc1 = [Dc1  d1];
    Dc2 = [Dc2  d2];
    Dc3 = [Dc3  d3];
    Dc4 = [Dc4  d4];
    Dc5 = [Dc5  d5];
    c3 = c3 + 1;
  end
  
  if (((x^2+y^2)>1) & (x<0) & (y<0) & (c4<classe4))
    aux4 = [-1 ; x ; y];
    X4 = [X4 aux4];
    D4 = [D4  d4];
    Dc1 = [Dc1  d1];
    Dc2 = [Dc2  d2];
    Dc3 = [Dc3  d3];
    Dc4 = [Dc4  d4];
    Dc5 = [Dc5  d5];
    c4 = c4 + 1;
  end
  
  if (((x^2+y^2)>1) & (x>0) & (y<0) & (c5<classe5))
    aux5 = [-1 ; x ; y];
    X5 = [X5 aux5];
    D5 = [D5  d5];
    Dc1 = [Dc1  d1];
    Dc2 = [Dc2  d2];
    Dc3 = [Dc3  d3];
    Dc4 = [Dc4  d4];
    Dc5 = [Dc5  d5];
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
Wo1 = [];
for i = 1:Qco
  for j = 1:tam_x(1) 
    p_o = 2*rand(1,1,'uniform')-1;
    Wo1(j,i) = p_o;
  end 
end
//Peso da camada de Saida, a primeira linha é referente ao peso do bias
Ws1 = [];
//tam_s = size(Ds);
tam = Qco+1;
for i = 1:Qcs 
  for j = 1:tam 
    p_s = 2*rand(1,1,'uniform')-1;
    Ws1(i,j) = p_s;
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
Woa = Wo1';
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
    Woa = Wo1';
    Wsa = Ws1;
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
        errolinha = Dc1(h,i) - Ys;
        erroQ = erroQ + (errolinha^2)/2;
        DeltaS(h) = errolinha * Ys * (1-Ys);               
    
        Qco2 = Qco + 1;
        for o = 1:Qco2//numero de neuronios na camada oculta + bias
            Ws1(h,o) = Ws1(h,o) + coeficiente * DeltaS(h) * Yo(o);
        end         
    end   
//-----------------------------------------------------------------------------------------------------------------------------
//----------------Implementação da retropropagação-----------------------------------------------------------------------------
    Qco3 = Qco;
    Qcs2 = Qcs;
    
    for z = 1:Qco3
      Somatorio = 0;
      for g = 1:Qcs2
        Somatorio = Somatorio + DeltaS(g) * Ws1(g,z+1);
      end
      DeltaO(z) =  Yo(z+1) * (1-Yo(z+1)) * Somatorio;
    end
    Qco4 = Qco;
    for m = 1:Qco4//numero de neuronios na camada oculta
        Qco5 = tam_x(1);
        for n = 1:Qco5//numero de neuronios na camada oculta + bias
            Wo1(n,m) = Wo1(n,m) + coeficiente * DeltaO(m) * X(n,i);
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


//--------Parâmetros de definição da rede de especialista da C2-----------------------------

Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida

//---------------------------------------------------------------------
//---------Variáveis Utilizadas na Implementação da Rede---------------

//pesos da camada oculta, a primeira linha é referente ao peso do bias
Wo2 = [];
for i = 1:Qco
  for j = 1:tam_x(1) 
    p_o = 2*rand(1,1,'uniform')-1;
    Wo2(j,i) = p_o;
  end 
end
//Peso da camada de Saida, a primeira linha é referente ao peso do bias
Ws2 = [];
tam = Qco+1;
for i = 1:Qcs 
  for j = 1:tam 
    p_s = 2*rand(1,1,'uniform')-1;
    Ws2(i,j) = p_s;
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
Woa = Wo2';
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
    Woa = Wo2';
    Wsa = Ws2;
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
        errolinha = Dc2(h,i) - Ys;
        erroQ = erroQ + (errolinha^2)/2;
        DeltaS(h) = errolinha * Ys * (1-Ys);               
    
        Qco2 = Qco + 1;
        for o = 1:Qco2//numero de neuronios na camada oculta + bias
            Ws2(h,o) = Ws2(h,o) + coeficiente * DeltaS(h) * Yo(o);
        end         
    end   
//-----------------------------------------------------------------------------------------------------------------------------
//----------------Implementação da retropropagação-----------------------------------------------------------------------------
    Qco3 = Qco;
    Qcs2 = Qcs;
    
    for z = 1:Qco3
      Somatorio = 0;
      for g = 1:Qcs2
        Somatorio = Somatorio + DeltaS(g) * Ws2(g,z+1);
      end
      DeltaO(z) =  Yo(z+1) * (1-Yo(z+1)) * Somatorio;
    end
    Qco4 = Qco;
    for m = 1:Qco4//numero de neuronios na camada oculta
        Qco5 = tam_x(1);
        for n = 1:Qco5//numero de neuronios na camada oculta + bias
            Wo2(n,m) = Wo2(n,m) + coeficiente * DeltaO(m) * X(n,i);
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


//--------Parâmetros de definição da rede especialista C3-----------------------------

Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida

//---------------------------------------------------------------------
//---------Variáveis Utilizadas na Implementação da Rede---------------

//pesos da camada oculta, a primeira linha é referente ao peso do bias
Wo3 = [];
for i = 1:Qco
  for j = 1:tam_x(1) 
    p_o = 2*rand(1,1,'uniform')-1;
    Wo3(j,i) = p_o;
  end 
end
//Peso da camada de Saida, a primeira linha é referente ao peso do bias
Ws3 = [];
//tam_s = size(Ds);
tam = Qco+1;
for i = 1:Qcs 
  for j = 1:tam 
    p_s = 2*rand(1,1,'uniform')-1;
    Ws3(i,j) = p_s;
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
Woa = Wo3';
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
    Woa = Wo3';
    Wsa = Ws3;
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
        errolinha = Dc3(h,i) - Ys;
        erroQ = erroQ + (errolinha^2)/2;
        DeltaS(h) = errolinha * Ys * (1-Ys);               
    
        Qco2 = Qco + 1;
        for o = 1:Qco2//numero de neuronios na camada oculta + bias
            Ws3(h,o) = Ws3(h,o) + coeficiente * DeltaS(h) * Yo(o);
        end         
    end   
//-----------------------------------------------------------------------------------------------------------------------------
//----------------Implementação da retropropagação-----------------------------------------------------------------------------
    Qco3 = Qco;
    Qcs2 = Qcs;
    
    for z = 1:Qco3
      Somatorio = 0;
      for g = 1:Qcs2
        Somatorio = Somatorio + DeltaS(g) * Ws3(g,z+1);
      end
      DeltaO(z) =  Yo(z+1) * (1-Yo(z+1)) * Somatorio;
    end
    Qco4 = Qco;
    for m = 1:Qco4//numero de neuronios na camada oculta
        Qco5 = tam_x(1);
        for n = 1:Qco5//numero de neuronios na camada oculta + bias
            Wo3(n,m) = Wo3(n,m) + coeficiente * DeltaO(m) * X(n,i);
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


//--------Parâmetros de definição da rede especialista C4-----------------------------

Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida

//---------------------------------------------------------------------
//---------Variáveis Utilizadas na Implementação da Rede---------------

//pesos da camada oculta, a primeira linha é referente ao peso do bias
tam_x = size(X);
Wo4 = [];
for i = 1:Qco
  for j = 1:tam_x(1) 
    p_o = 2*rand(1,1,'uniform')-1;
    Wo4(j,i) = p_o;
  end 
end
//Peso da camada de Saida, a primeira linha é referente ao peso do bias
Ws4 = [];
//tam_s = size(Ds);
tam = Qco+1;
for i = 1:Qcs 
  for j = 1:tam 
    p_s = 2*rand(1,1,'uniform')-1;
    Ws4(i,j) = p_s;
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
Woa = Wo4';
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
    Woa = Wo4';
    Wsa = Ws4;
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
        errolinha = Dc4(h,i) - Ys;
        erroQ = erroQ + (errolinha^2)/2;
        DeltaS(h) = errolinha * Ys * (1-Ys);               
    
        Qco2 = Qco + 1;
        for o = 1:Qco2//numero de neuronios na camada oculta + bias
            Ws4(h,o) = Ws4(h,o) + coeficiente * DeltaS(h) * Yo(o);
        end         
    end   
//-----------------------------------------------------------------------------------------------------------------------------
//----------------Implementação da retropropagação-----------------------------------------------------------------------------
    Qco3 = Qco;
    Qcs2 = Qcs;
    
    for z = 1:Qco3
      Somatorio = 0;
      for g = 1:Qcs2
        Somatorio = Somatorio + DeltaS(g) * Ws4(g,z+1);
      end
      DeltaO(z) =  Yo(z+1) * (1-Yo(z+1)) * Somatorio;
    end
    Qco4 = Qco;
    for m = 1:Qco4//numero de neuronios na camada oculta
        Qco5 = tam_x(1);
        for n = 1:Qco5//numero de neuronios na camada oculta + bias
            Wo4(n,m) = Wo4(n,m) + coeficiente * DeltaO(m) * X(n,i);
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


//--------Parâmetros de definição da rede especialista C5-----------------------------

Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida

//---------------------------------------------------------------------
//---------Variáveis Utilizadas na Implementação da Rede---------------

//pesos da camada oculta, a primeira linha é referente ao peso do bias

Wo5 = [];
for i = 1:Qco
  for j = 1:tam_x(1) 
    p_o = 2*rand(1,1,'uniform')-1;
    Wo5(j,i) = p_o;
  end 
end
//Peso da camada de Saida, a primeira linha é referente ao peso do bias
Ws5 = [];
//tam_s = size(Ds);
tam = Qco+1;
for i = 1:Qcs 
  for j = 1:tam 
    p_s = 2*rand(1,1,'uniform')-1;
    Ws5(i,j) = p_s;
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
Woa = Wo5';
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
    Woa = Wo5';
    Wsa = Ws5;
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
        errolinha = Dc5(h,i) - Ys;
        erroQ = erroQ + (errolinha^2)/2;
        DeltaS(h) = errolinha * Ys * (1-Ys);               
    
        Qco2 = Qco + 1;
        for o = 1:Qco2//numero de neuronios na camada oculta + bias
            Ws5(h,o) = Ws5(h,o) + coeficiente * DeltaS(h) * Yo(o);
        end         
    end   
//-----------------------------------------------------------------------------------------------------------------------------
//----------------Implementação da retropropagação-----------------------------------------------------------------------------
    Qco3 = Qco;
    Qcs2 = Qcs;
    
    for z = 1:Qco3
      Somatorio = 0;
      for g = 1:Qcs2
        Somatorio = Somatorio + DeltaS(g) * Ws5(g,z+1);
      end
      DeltaO(z) =  Yo(z+1) * (1-Yo(z+1)) * Somatorio;
    end
    Qco4 = Qco;
    for m = 1:Qco4//numero de neuronios na camada oculta
        Qco5 = tam_x(1);
        for n = 1:Qco5//numero de neuronios na camada oculta + bias
            Wo5(n,m) = Wo5(n,m) + coeficiente * DeltaO(m) * X(n,i);
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






//--------Parâmetros de definição da rede de passagem-----------------------------

Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida
interacoes_geral = 10000;//numero total de interações da rede
//---------------------------------------------------------------------
//---------Variáveis Utilizadas na Implementação da Rede---------------

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

//------------------Validação------------------------------------------------------------------------------------------------------
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
X1 = [];
X2 = [];
X3 = [];
X4 = [];
X5 = [];
for ab = 1:10000000
  x = 2*rand(1,1,'uniform')-1;
  y = 2*rand(1,1,'uniform')-1;
  if (((x^2+y^2)<=1) & (c1<classe1))
    aux1 = [-1 ; x ; y];
    X1 = [X1 aux1];
    c1 = c1 + 1;
  end
    
  if (((x^2+y^2)>1) & (x>0) & (y>0) & (c2<classe2))
    aux2 = [-1 ; x ; y];
    X2 = [X2 aux2];    
    c2 = c2 + 1;
  end
  
  if (((x^2+y^2)>1) & (x<0) & (y>0) & (c3<classe3))
    aux3 = [-1 ; x ; y];
    X3 = [X3 aux3];
    c3 = c3 + 1;
  end
  
  if (((x^2+y^2)>1) & (x<0) & (y<0) & (c4<classe4))
    aux4 = [-1 ; x ; y];
    X4 = [X4 aux4];
    c4 = c4 + 1;
  end
  
  if (((x^2+y^2)>1) & (x>0) & (y<0) & (c5<classe5))
    aux5 = [-1 ; x ; y];
    X5 = [X5 aux5];    
    c5 = c5 + 1;
  end
  if (c1 >= classe1) & (c2 >= classe2) & (c3 >= classe3) & (c4 >= classe4) & (c5 >= classe5)
    break;
  end
end
X = [X1 X2 X3 X4 X5];
//-------------------C1----------------------------------------------------------------------------
//---------------Parametros------------------------------------------------------------------------
Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida
Vo = 0;
Vs = 0;
Yo = [ ];
validacao1 = [ ];
//-------------------------------------------------------------------------------------------------
for  i = 1:tam_x(2)    
    Woa = Wo1';
    Wsa = Ws1;
    Qco1 = Qco;
    for j = 1:Qco1 //numero de neuronios da camada oculta     
         Vo = Woa(j,:) * X(:,i);                
         Yo(j+1) = 1/(1+(exp(-Vo)));
         
    end
    Qcs1 = Qcs;
    for h = 1:Qcs1//numero de neuronios da camada de saida 
        Vs = Wsa(h,:) * Yo(:,1);
        validacao1(h,i) = 1/(1+(exp(-Vs)));
                                   
    end   
 end
 
//-------------------C2----------------------------------------------------------------------------
//---------------Parametros------------------------------------------------------------------------
Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida
Vo = 0;
Vs = 0;
Yo = [ ];
validacao2 = [ ];
//-------------------------------------------------------------------------------------------------
for  i = 1:tam_x(2)    
    Woa = Wo2';
    Wsa = Ws2;
    Qco1 = Qco;
    for j = 1:Qco1 //numero de neuronios da camada oculta     
         Vo = Woa(j,:) * X(:,i);                
         Yo(j+1) = 1/(1+(exp(-Vo)));
         
    end
    Qcs1 = Qcs;
    for h = 1:Qcs1//numero de neuronios da camada de saida 
        Vs = Wsa(h,:) * Yo(:,1);
        validacao2(h,i) = 1/(1+(exp(-Vs)));
                                   
    end   
 end
 
//-------------------C3----------------------------------------------------------------------------
//---------------Parametros------------------------------------------------------------------------
Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida
Vo = 0;
Vs = 0;
Yo = [ ];
validacao3 = [ ];
//-------------------------------------------------------------------------------------------------
for  i = 1:tam_x(2)    
    Woa = Wo3';
    Wsa = Ws3;
    Qco1 = Qco;
    for j = 1:Qco1 //numero de neuronios da camada oculta     
         Vo = Woa(j,:) * X(:,i);                
         Yo(j+1) = 1/(1+(exp(-Vo)));
         
    end
    Qcs1 = Qcs;
    for h = 1:Qcs1//numero de neuronios da camada de saida 
        Vs = Wsa(h,:) * Yo(:,1);
        validacao3(h,i) = 1/(1+(exp(-Vs)));
                                   
    end   
 end
 
//-------------------C4----------------------------------------------------------------------------
//---------------Parametros------------------------------------------------------------------------
Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida
Vo = 0;
Vs = 0;
Yo = [ ];
validacao4 = [ ];
//-------------------------------------------------------------------------------------------------
for  i = 1:tam_x(2)    
    Woa = Wo4';
    Wsa = Ws4;
    Qco1 = Qco;
    for j = 1:Qco1 //numero de neuronios da camada oculta     
         Vo = Woa(j,:) * X(:,i);                
         Yo(j+1) = 1/(1+(exp(-Vo)));
         
    end
    Qcs1 = Qcs;
    for h = 1:Qcs1//numero de neuronios da camada de saida 
        Vs = Wsa(h,:) * Yo(:,1);
        validacao4(h,i) = 1/(1+(exp(-Vs)));
                                   
    end   
 end
 
//-------------------C5----------------------------------------------------------------------------
//---------------Parametros------------------------------------------------------------------------
Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida
Vo = 0;
Vs = 0;
Yo = [ ];
validacao5 = [ ];
//-------------------------------------------------------------------------------------------------
for  i = 1:tam_x(2)    
    Woa = Wo5';
    Wsa = Ws5;
    Qco1 = Qco;
    for j = 1:Qco1 //numero de neuronios da camada oculta     
         Vo = Woa(j,:) * X(:,i);                
         Yo(j+1) = 1/(1+(exp(-Vo)));
         
    end
    Qcs1 = Qcs;
    for h = 1:Qcs1//numero de neuronios da camada de saida 
        Vs = Wsa(h,:) * Yo(:,1);
        validacao5(h,i) = 1/(1+(exp(-Vs)));
                                   
    end   
 end
 
//-------------------Passagem----------------------------------------------------------------------------
//---------------Parametros------------------------------------------------------------------------------
Qco = 40; //quantidade de neuronios na camada oculta
Qcs = 5; //quantidade de neuronios na camada de saida
Vo = 0;
Yo = [ ];
validacao = [ ];
//-------------------------------------------------------------------------------------------------------
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
//--------------------Ponderação---------------------------------------------------------------------------

for  i = 1:tam_x(2)
    v1(:,i) = validacao1(:,i)*validacao(1,i);
    v2(:,i) = validacao2(:,i)*validacao(2,i);
    v3(:,i) = validacao3(:,i)*validacao(3,i);
    v4(:,i) = validacao4(:,i)*validacao(4,i);
    v5(:,i) = validacao5(:,i)*validacao(5,i);
    ponderacao(:,i) = v1(:,i)+v2(:,i)+v3(:,i)+v4(:,i)+v5(:,i);
end
printf("Matriz de saida da Maquina de Comite = ");
disp(ponderacao);
//---------------------------------------------------------------------------------------------------------

plot2d(ponderacao);
