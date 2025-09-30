import 'package:flutter/material.dart';

class CadastroScreens extends StatefulWidget {
  const CadastroScreens({super.key});

@override
  State<CadastroScreens> createState() => _CadastroScreensState();
}
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool validarEmail(String email) {
    String padrao = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(padrao);
    return regex.hasMatch(email);
  }
class _CadastroScreensState extends State<CadastroScreens> {
   bool _isChecked = false;
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
          child: SingleChildScrollView(
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
                      'Nome',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Karla',
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  TextFormField(
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
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                     if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome';
                      }
                       else if (value.length < 6) {
                        return 'O nome deve ter pelo menos 6 caracteres';
                      }
                      return null;}
                  ),
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
                        return 'Por favor, insira sua senha';
                      } else if (value.length < 8) {
                        return 'A senha deve ter pelo menos 8 caracteres';
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
                        return 'Por favor, confirme sua senha';
                      } else if (value != senhaController.text) {
                        return 'As senhas não coincidem';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Número de Teleone com DDD',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: 'Karla',
                      ),
                    ),
                  ),
                    TextFormField(
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
                        return 'Por favor, insira seu número de telefone';
                      } else if (value.length < 10 || value.length > 11) {
                        return 'Por favor, insira um número de telefone válido';
                      }
                      return null;
                    },
                    ),
                    
                               Align(
                  alignment: Alignment.centerLeft,
                  child: const TextButton(
                    onPressed: null,
                    child: Text(
                      'Termos de Uso',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Karla',
                      ),
                    ),  
                  ),
                ),
                SizedBox(
                  child:Row(
                    children: [
                          Checkbox(
                 value: _isChecked,
                   onChanged: (bool? newValue) {
            setState(() {
                    _isChecked = newValue ?? false; // Handle null for tristate if applicable
            });
                },
          activeColor: const Color.fromARGB(255, 247, 111, 111), // Optional: customize active color
          checkColor: Colors.white, // Optional: customize checkmark color
        ),
        const Text(
          'Eu aceito os Termos de Uso',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontFamily: 'Karla',
          ),
        ),  
        ]),),
                SizedBox(height: 10),
                    SizedBox(
                  width: 182,
                  height: 45,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Conta criada com sucesso!',
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
                      null;
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: _isChecked
                          ? Color.fromARGB(255, 247, 111, 111)
                          : Colors.grey, // Change color based on checkbox state
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
      ),
    )
    );
  }
  }

