//Ricardo de Sousa Britto
//Questão 1 - A - A
clear;
clc;
lines(0);

//--------Parâmetros de definição da rede-----------------------------

Tam_x = 100; //tamanho de X

//entrada e saidas desejadas

d = 0;
X = [];
Ds = [];
cont = 1;
for i=1:Tam_x
  d = (i/(sqrt(i^2+1)));
  X(i,1) = i;
  Ds(i,1) = d;
  indice = modulo(i,10);
  if indice == 0
    T(cont,1)= int((rand(1,1,'uniform'))*100);
    cont = cont + 1;
  end
end

tam=size(T,1);
//calculo da distancia máxima entre os centros
for i=1:tam(1)
  for j=1:tam(1)
    dif_euclid(i,j) = T(i) - T(j); 
  end
end
dmax = max(dif_euclid);
//cálculo da Matriz  G
G = [];
m = tam(1);
aux = dmax/sqrt(2*tam(1));
for i=1:Tam_x
  for j=1:tam
   G(i,j) = exp((-1/(2*aux^2)) * (X(i)-T(j))^2);
  end
end

W = (inv(G'*G))*G'*Ds;
//W = inv(G) * Ds;
V = G*W;
plot2d( 1:Tam_x, V, style=[10]);
plot2d( 1:Tam_x, Ds, style=[5]);
