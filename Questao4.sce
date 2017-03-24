//Ricardo de Sousa Britto
//Questao 4
clear;
clc;
lines(0);


//Definição das entradas

A = [-1 
     1; 
     1; 
     1; 
     -1;
     1;
     -1; 
     -1; 
     -1; 
     1;
     1; 
     1; 
     1; 
     1; 
     1;
     1; 
     -1; 
     -1; 
     -1; 
     1;
     1;
     -1; 
     -1; 
     -1; 
     1];
     
E = [-1; 
     -1; 
     1; 
     1; 
     1;
     -1; 
     1; 
     -1; 
     -1; 
     -1;
     -1; 
     1; 
     1; 
     1; 
     1;
     -1; 
     1; 
     -1; 
     -1; 
     -1;
     -1; 
     -1; 
     1; 
     1; 
     1];
     
I = [1; 
     1 ;
     1 ;
     1 ;
     1;
     -1 ;
     -1 ;
     1 ;
     -1 ;
     -1;
     -1 ;
     -1 ;
     1 ;
     -1 ;
     -1;
     -1 ;
     -1 ;
     1 ;
     -1 ;
     -1;
     1 ;
     1 ;
     1 ;
     1 ;
     1];
     
     
O = [1; 
     1 ;
     1 ;
     1 ;
     1;
     1 ;
     -1 ;
     -1 ;
     -1 ;
     1;
     1 ;
     -1 ;
     -1 ;
     -1 ;
     1;
     1 ;
     -1 ;
     -1 ;
     -1 ;
     1;
     1 ;
     1 ;
     1 ;
     1 ;
     1];
     
U = [1;
     -1 ;
     -1 ;
     -1 ;
     1;
     1 ;
     -1 ;
     -1 ;
     -1 ;
     1;
     1 ;
     -1 ;
     -1 ;
     -1 ;
     1;
     1 ;
     -1 ;
     -1 ;
     -1 ;
     1;
     -1 ;
     1 ;
     1 ;
     1 ;
     -1];
 
    
Sa_v = [];  
Se_v = [];
Si_v = [];
So_v = [];
Su_v = [];
W = [];
coeficiente = 1/25;
//Implementação da atualização dos pesos

W = ((A*A')+(E*E')+(I*I')+(O*O')+(U*U'))/25;

tam_w = size(W);

for i = 1:tam_w(1);

  W(i,i) = 0;
  
end

//Validação

BiasV = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

Bias = [1];

W = [BiasV;W];

A = [Bias;A];

E = [Bias;E];

I = [Bias;I];

O = [Bias;O];

U = [Bias;U];

tam = size(A);
for i = 1:tam_w(2)
//------A--------------
 Sa = A'*W(:,i);
 
 if (Sa >= 0)
   Sa = 1;
 else
   Sa = -1;
 end 
 
 Sa_v = [Sa_v Sa];
//---------------------
//------E--------------
 Se = E'*W(:,i);
 
 if (Se >= 0)
    Se = 1;
 else
    Se = -1;
 end
 
 Se_v = [Se_v Se];
//---------------------
//------I--------------
 Si = I'*W(:,i);
 
 if (Si >= 0)
    Si = 1;
 else
    Si = -1;
 end
 
 Si_v = [Si_v Si];
//---------------------
//------O--------------
 So = O'*W(:,i);
 
 if (So >= 0)
    So = 1;
 else
    So = -1;
 end
 
 So_v = [So_v So];
//---------------------
//------U--------------
 Su = U'*W(:,i);
 
 if (Su >= 0)
    Su = 1;
 else
    Su = -1;
 end
 
 Su_v = [Su_v Su];
//---------------------

end


 

