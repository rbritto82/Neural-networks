// Class automatically generated by Dev-C++ New Class wizard

#ifndef PERCEPTRON_H_
#define PERCEPTRON_H_

#include "perceptron.h" // inheriting class's header file
#include <stdio.h>
/*
 * Ricardo de Sousa Britto
 * Classe que implementa os metodos e vari�veis necessarias para a
 * implementa��o do perceptron.
 * 
 */
class perceptron
{
	
    private:
            double w1,w2,w3;
    public:
        
        
        // class constructor
		perceptron();
		perceptron(double x, double y, double z);
        // class destructor
		~perceptron();
		//m�todo que implementa a soma ponderada das entradas com os pesos
        double Somador(double x1, double x2, double d);
        //m�todo que calcula o peso sinaptico de cada entrada
        double Peso(double x, double wa, double d, double v );
        //m�todo que implementa o erro instantaneo de cada intera��o do treinamento
        double ErroInst(double v, double d);
        //m�todo que retornar o pesso w1
        double GetW1();
        //m�todo que retorna o peso w2
        double GetW2();
        //m�todo que altera o peso w1
        void SetW1(double x);
        //m�todo que altera o peso w2
        void SetW2(double x);
        //m�todo que retorna o peso w3
        double GetW3();
        //m�todo que altera o peso w3
        void SetW3(double x);
		
};

#endif // PERCEPTRON_H_