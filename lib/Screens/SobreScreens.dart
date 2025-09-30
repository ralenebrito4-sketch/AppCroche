import 'package:flutter/material.dart';

class SobreScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(
        255,
        255,
        170,
        170,
      ), // mudar pra mais claro
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Sobre o App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Karla",
                  color: Color.fromARGB(255, 255, 255, 255),
                  decoration: TextDecoration.underline,
                  decorationColor: Color.fromARGB(255, 249, 189, 85),
                  decorationStyle: TextDecorationStyle.wavy,
                  decorationThickness: 2.0,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Este aplicativo foi criado com o propósito de apoiar a comunidade de artesões, oferecendo um espaço onde é possivel compartilhar receitas, comprar e vender criações. ',
                style: TextStyle(fontSize: 20,
                color: Colors.white),
              ),
              SizedBox(height: 30),
              Text(
                'Meu objetivo é valorizar o talento de cada artesão, conectando pessoas que criam, aprendem e vivem da arte de transformar.',
                style: TextStyle(fontSize: 20,
                color: Colors.white,
                fontFamily: 'Karla',
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Desenvolvido por: ',
                style: TextStyle(fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontFamily: 'Karla',
                ),
              ),
               Text(
                'Railene Brito ',
                style: TextStyle(fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Karla',
                decoration: TextDecoration.underline,
                decorationColor: Color.fromARGB(255, 249, 189, 85),
                decorationStyle: TextDecorationStyle.wavy,
                decorationThickness: 2.0,
                ),
              ),
               SizedBox(height: 30),
                SizedBox(
                  width: 182,
                  height: 45,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 247, 111, 111),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Voltar',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontFamily: 'Karla',
                        fontWeight: FontWeight.w900,
                        decoration: TextDecoration.underline,
                        decorationColor: const Color.fromARGB(
                          255,
                          249,
                          189,
                          85,
                        ),
                        decorationStyle: TextDecorationStyle.wavy,
                        decorationThickness: 3,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
