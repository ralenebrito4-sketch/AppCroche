import 'package:flutter/material.dart';

class EsqueciScreen extends StatelessWidget {
  EsqueciScreen({super.key});

  final TextEditingController senhaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool validarEmail(String email) {
    String padrao = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(padrao);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/Fundo (1) (1).png'),
            fit: BoxFit.cover,
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
                Image.asset('lib/images/Logo (1).png', height: 120),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 35)),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
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
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 247, 111, 111),
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email';
                    } else if (!validarEmail(value)) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Digite uma Nova Senha',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Karla',
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                TextFormField(
                  controller: senhaController,
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
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 247, 111, 111),
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
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Confirme a Senha',
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
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 247, 111, 111),
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor, insira sua senha";
                      }
                      if (value != senhaController.text) {
                        return "As senhas não coincidem";
                      }
                      return null;
                    },
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 182,
                  height: 45,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Senha alterada com sucesso!',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Karla',
                                color: Colors.white,
                              ),
                            ),
                            duration: Duration(seconds: 2),
                            backgroundColor: Color.fromARGB(255, 247, 111, 111),
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
                      'Salvar',
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
                SizedBox(height: 5),
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
      ),
    ));
  }
}
