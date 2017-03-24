#include <cstdlib>
#include <iostream>
#include "perceptron.h"
#include <stdio.h>
#include <math.h>

/*
 * Ricardo de Sousa Britto
 * Implementação do perceptron.
 * 
 */
 
using namespace std;

int main(int argc, char *argv[])
{
    double p[4][3];
    double q[2][2];
    double erro=0, erroR, y, erroinst, peso1,peso2,peso3 ;
    int max=0,i;
    char key,key2;
    perceptron pe;
    
    
    while(key!='n'){
    cout<<"Digite funcao a ser treinada (AND-1; OR-2; XOR-3; NOT-4): ";
    cin>>key;
    cout<<"\nDeseja definir os pesos iniciais? (Sim-s;Nao-n): ";
    cin>>key2;
    
    switch(key2)
    {
     case 's': 
               if (key!='4')
               {
               cout<<"Digite peso 1: ";
               cin>>peso1;
               cout<<"Digite peso 2: "; 
               cin>>peso2;
               cout<<"Digite peso 3: "; 
               cin>>peso3;
               pe=perceptron(peso1,peso2,peso3);
               break;
               }
               if (key=='4')
               {
               cout<<"Digite peso 1: ";
               cin>>peso1;
               cout<<"Digite peso 2: "; 
               cin>>peso3;
               pe=perceptron(peso1,0,peso3);
               break;
               }
    
    case 'n':  pe=perceptron();
               break;
    
    default:cout<<"\nDeseja definir os pesos iniciais? (Sim-s;Nao-n): "; 
    }
    cout<<"\nDigite numero de interacoes: ";
    cin>>max;
    cout<<"\nDigite erro de epoca para a rede convergir: ";
    cin>>erro;
    
    switch (key)
    {
    // matriz de entradas e das saidas para o AND
    case '1':p[0][0]=0.0;p[0][1]=0.0;p[0][2]=0.0;
             p[1][0]=1.0;p[1][1]=0.0;p[1][2]=0.0;
             p[2][0]=0.0;p[2][1]=1.0;p[2][2]=0.0;
             p[3][0]=1.0;p[3][1]=1.0;p[3][2]=1.0;
             break;
    // matriz de entradas e das saidas para o OR
    case '2':p[0][0]=0.0;p[0][1]=0.0;p[0][2]=0.0;
             p[1][0]=1.0;p[1][1]=0.0;p[1][2]=1.0;
             p[2][0]=0.0;p[2][1]=1.0;p[2][2]=1.0;
             p[3][0]=1.0;p[3][1]=1.0;p[3][2]=1.0;
             break;
    // matriz de entradas e das saidas para o XOR
    case '3':p[0][0]=0.0;p[0][1]=0.0;p[0][2]=0.0;
             p[1][0]=1.0;p[1][1]=0.0;p[1][2]=1.0;
             p[2][0]=0.0;p[2][1]=1.0;p[2][2]=1.0;
             p[3][0]=1.0;p[3][1]=1.0;p[3][2]=0.0;
             break;
    case '4':q[0][0]=0.0;q[0][1]=1.0;
             q[1][0]=1.0;q[1][1]=0.0;
    
    default: cout<<"\nDigite funcao a ser treinada (AND-1; OR-2; XOR-3; NOT-4): ";
    }
      
      
    for( i=0; i<max ; i++)
    {
     erroR=0;     
     //calcula função NOT, é diferente pois o NOT possui apenas uma entrada
     if (key=='4')
     {
     for(int j=0; j<2 ; j++)
     {
      //calcula saida do somador do perceptron (soma ponderada=y)
      y=pe.Somador(q[j][0],0,q[j][1]);
      
      //calcula erro instantaneo (e=d-y)
      erroinst=pe.ErroInst(y,q[j][1]);
      
      //somatorio dos quadrados dos erros instantaneos de uma epoca
      erroR = erroR+pow(erroinst,2);
      
      cout<<"\nErro instantaneo: "<<erroinst<<"\n";
      cout<<"\nErro: "<<erroR<<"\n";
      
      //pesos atualizados
      pe.SetW1(pe.Peso(q[j][0],pe.GetW1(),q[j][1],y));
      pe.SetW3(pe.Peso(1,pe.GetW3(),q[j][1],y));
      cout<<"\nNovo peso 1 "<<pe.GetW1()<<"\n";
      cout<<"\nNovo peso 2 "<<pe.GetW3()<<"\n";       
     }
     }
     
     //calcula funções AND, OR, XOR
     if (key!='4')
     {
     for(int j=0; j<4 ; j++)
     {
      //calcula saida do omador do perceptron (soma ponderada=y)
      y=pe.Somador(p[j][0],p[j][1],p[j][2]);
      
      //calcula erro instantaneo (e=d-y)
      erroinst=pe.ErroInst(y,p[j][2]);
      
      //somatorio dos quadrados dos erros instantaneos de uma epoca
      erroR = erroR+pow(erroinst,2);
      
      cout<<"\nErro instantaneo: "<<erroinst<<"\n";
      cout<<"\nErro: "<<erroR<<"\n";
      
      //pesos atualizados
      pe.SetW1(pe.Peso(p[j][0],pe.GetW1(),p[j][2],y));
      pe.SetW2(pe.Peso(p[j][1],pe.GetW2(),p[j][2],y));
      pe.SetW3(pe.Peso(1,pe.GetW3(),p[j][2],y));
      cout<<"\nNovo peso 1 "<<pe.GetW1()<<"\n";
      cout<<"\nNovo peso 2 "<<pe.GetW2()<<"\n";  
      cout<<"\nNovo peso 3 "<<pe.GetW3()<<"\n";       
     }
     }
    //erro quadratico global
    erroR = erroR/2;
    
    cout<<"\nInteracoes: "<<i+1<<"\n";
    //testa se o erro convergiu para o valor fornecido como referencia
    if((erroR)<=erro) 
     {
      cout<<"\nFuncao Converge :) !!!\nErro Global: "<<erroR;
      break;
     
     }
    cout<<"\nFuncao nao converge :( \nErro Global: "<<erroR<<"\n";
    }
    cout<<"\n\n\nDeseja treinar novamente? (Sim-S; Nao-n)\n\n\n";
    cin>>key;    
}
    system("PAUSE");
    return EXIT_SUCCESS;
}
