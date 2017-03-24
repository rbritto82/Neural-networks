//Ricardo de Sousa Britto
//Questão 1 - B - A 
clear;
clc;
lines(0);

//--------Parâmetros de definição da rede-----------------------------


Tam_x = 10; //tamanho de X

//entrada e saidas desejadas
norma = 0;
pi = 3.14;
d = 0;
X = [];
Ds = [];
cont = 1;
cont2 = 1;
for i=-10:Tam_x
  for j=-10:Tam_x
   if ((i<>0)&(j<>0))
    X(cont,1) = i;
    X(cont,2) = j;
    for i1=1:2
      norma = norma + X(cont,i1)^2;
    end
    d = sin(pi*sqrt(norma))/(pi*sqrt(norma));
    Ds(cont,1) = d;
    indice = modulo(cont,2);
    if (indice == 0)
      T(cont2,1) = X(cont,1);
      T(cont2,2) = X(cont,2);
      cont2 = cont2 + 1;
    end
    cont = cont + 1;
   end
  end
end
tamx = size(X);
tamt = size(T);

//calculo da distancia máxima entre os centros
for i=1:tamt(1)
  for j=1:tamt(1)
    dif_euclid(i,j) = T(i) - T(j); 
  end
end
dmax = max(dif_euclid);
//cálculo da Matriz  G
G = [];
m = tamt(1);
aux = dmax/sqrt(2*tamt(1));

for i=1:tamx(1)
  for j=1:tamt(1)
    aux1 = sqrt((X(i,1)-T(j,1))^2 + (X(i,2)-T(j,2))^2); 
    G(i,j) = exp( (-1/(2*aux^2)) * aux1^2);
  end
end
//Cáculo dos pesos
W = (inv(G'*G))*G'*Ds;
//Validação
V = G*W;

plot2d( 1:tamx(1), V, style=[10]);
plot2d( 1:tamx(1), Ds, style=[5]);
