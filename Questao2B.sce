//Ricardo de Sousa Britto
//Questão 2 - B 
clear;
clc;
lines(0);

//--------Parâmetros de definição da rede-----------------------------

Qco = 20; //quantidade de neuronios na camada oculta
Qcs = 1; //quantidade de neuronios na camada de saida
interacoes_geral = 10000;//numero total de interações da rede
erro = 0.002;// Erro a ser enconrado pela rede
coeficiente = 0.05;  //coeficiente de aprendizado
//---------------------------------------------------------------------
//---------Variáveis Utilizadas na Implementação da Rede---------------
//entrada da camada oculta, a primeira coluna é referente aos bias
for i=1:100
  x1 = i/100;
  X(1,i) = [-1];
  X(2,i) = x1;
end

//Saídas desejadas da camada de saída

for j=1:100
  dn = j/100;
  d = 2 * dn^3 - dn^2 +10*dn -4;
  Ds(1,j) = d;
end

//pesos da camada oculta, a primeira linha é referente ao peso do bias
tam_x = size(X);
Wo = [];
for i = 1:Qco
  for j = 1:tam_x(1) 
    p_o = (rand(1,1,'uniform'));
    Wo(j,i) = p_o;
  end 
end
//Peso da camada de Saida, a primeira linha é referente ao peso do bias
Ws = [];
//tam_s = size(Ds);
tam = Qco+1;
for i = 1:Qcs 
  for j = 1:tam 
    p_s = (rand(1,1,'uniform'));
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
        Ys = Vs;//1/(1+(exp(-Vs)));
        errolinha = Ds(h,i) - Ys;
        erroQ = erroQ + (errolinha^2)/2;
        DeltaS(h) = errolinha;// * Ys * (1-Ys);               
    
        Qco2 = Qco + 1;
        for o = 1:Qco2//numero de neuronios na camada oculta + bias
            Ws(h,o) = Ws(h,o) + coeficiente * DeltaS(h) * Yo(o);
        end         
    end   
//-----------------------------------------------------------------------------------------------------------------------------
//----------------Implementação da retropropagação-----------------------------------------------------------------------------
    Qco3 = Qco;
    Qcs2 = Qcs;
    //for z = 1:Qcs2  
    //    for g = 1:Qco3//numero de neuronios da camada oculta
    //        //Somatorio(z) = DeltaS(z) * Ws(z,g+1);
    //        Somatorio = Somatorio + DeltaS(z) * Ws(z,g+1);
    //    end
    //end
    
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
 //-------------------------------------------------------------------
 erroepoca = erroQ;
 //--------------------------------------------------------------------------------------------------------------------------------
 //----------------Impressão do Gráfico--------------------------------------------------------------------------------------------
 vetorerroepoca = [vetorerroepoca erroQ];
 vetorcontrole  = [vetorcontrole interacoes];
  printf("Interação [%d] = %f\n",interacoes,erroQ);
end


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
        validacao(h,i) = Vs;
                                   
    end   
 end
 
 
 subplot(1,2,1);
 plot2d(vetorcontrole, vetorerroepoca, style=[5]);
 subplot(1,2,2);
 for i = 1:Qcs
   plot2d( 1:tam_x(2), Ds(i,:), style=[10]);
   plot2d( 1:tam_x(2), validacao(i,:), style=[5]);
 end
 
