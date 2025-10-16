import 'package:flutter/material.dart';
import 'EsqueciScreens.dart';
import 'CadastroScreens.dart';
import 'SobreScreens.dart';
import 'TelaPrincipal.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

final _formKey = GlobalKey<FormState>();
final emailController = TextEditingController();

// Função para validar email com regex
bool validarEmail(String email) {
  String padrao = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(padrao);
  return regex.hasMatch(email);
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/Fundo (1) (1).png'),
            fit: BoxFit.fitHeight,
          ),
        ),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('lib/images/Logo.png')),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 35)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Karla',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),

                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 247, 111, 111),
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor, insira seu email";
                      }
                      if (!validarEmail(value)) {
                        return "Digite um email válido";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Senha',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Karla',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),

                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 247, 111, 111),
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor, insira sua senha";
                      }
                      if (value.length < 8) {
                        return "A senha deve ter pelo menos 8 caracteres";
                      }
                      return null;
                    },
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EsqueciScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Esqueci Minha Senha",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Karla',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastroScreens(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Fazer Cadastro',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontFamily: 'Karla',
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 220,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Entrar com Google',
                            style: TextStyle(
                              color: Color.fromARGB(255, 142, 142, 142),
                              fontSize: 16,
                              fontFamily: 'Arial',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                          ),
                          Image.asset('lib/images/google logo.png', height: 25),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 182,
                    height: 45,
                    child: TextButton(
                      onPressed: () {
                          if (_formKey.currentState!.validate()) {
                        // Aqui vai a tela principal
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(loggedEmail: emailController.text),
                          ),
                        );
                      }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 247, 111, 111),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Entrar',
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        SizedBox(
                          height: 20,
                          width: 100,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SobreScreens(),
                                ),
                              );
                            },
                            child: Text(
                              'Sobre',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Karla',
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
