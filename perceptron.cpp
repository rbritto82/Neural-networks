// Class automatically generated by Dev-C++ New Class wizard

#include "perceptron.h" // class's header file
#include <stdio.h>

// class constructor
perceptron::perceptron()
{
	w1=0.5;
	w2=0.7;
    w3=0.9;
}

//construtor sobrecarregado
perceptron::perceptron(double x, double y, double z)
{
	w1=x;
	w2=y;
    w3=z;
}

// class destructor
perceptron::~perceptron()
{
	
}

//calcula o erro instantaneo
double perceptron::ErroInst(double v, double d)
{
 double erro;
 erro= d-v;
 
 return erro;      
}

//calcula a soma ponderada
double perceptron::Somador(double x1, double x2, double d)
{
 double v,bias=1;
 
 v = (x1*w1)+(x2*w2)+(bias*w3);
 //fun��o degrau
 if (v>=0) v=1;
 if (v<0) v=0;
 return v;
}

//ajusta o peso
double perceptron::Peso(double x, double wa, double d, double v )
{
 double n=0.01;
 double w;
 
 w = wa + n*x*ErroInst(v,d);
 
 return w;
}

//retorna valor da variavel  privada w1
double perceptron::GetW1()
{
 return w1;
}

//retorna valor da variavel privada w2
double perceptron::GetW2()
{
 return w2;
}

//altera valor da variavel privada w1
void perceptron::SetW1(double x)
{
 w1=x;
}

//altera valor da variavel privada w2
void perceptron::SetW2(double x)
{
  w2=x;
}
//retorna valor da variavel privada w3
double perceptron::GetW3()
{
 return w3;
}

//altera valor da variavel privada w3
void perceptron::SetW3(double x)
{
 w3=x;
}


