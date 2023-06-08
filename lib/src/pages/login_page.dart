import 'package:flutter/material.dart';

import '../models/teacher_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Teacher _teacher = Teacher();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          'Iniciar Sesión',
          style: TextStyle(color: Color.fromRGBO(29, 53, 87, 1), fontSize: 30),
        )),
        backgroundColor: Colors.white,
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          children: [
            Container(height: 100),
            _getEmail(),
            Container(
              height: 15,
            ),
            _getPassword(label: 'Contraseña'),
            Container(
              height: 15,
            ),
            Container(
              height: 40,
            ),
            _getButton('Iniciar Sesión', const Color.fromRGBO(29, 53, 87, 1),
                context, '/'),
            Container(
                margin: const EdgeInsets.only(top: 46.0),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: '¿No tienes cuenta? ',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Registrarse',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromRGBO(230, 57, 70, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )))
          ]),
    );
  }

  _getEmail() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) => setState(() {
        _teacher.email = value;
      }),
      decoration: InputDecoration(
          filled: true,
          iconColor: const Color.fromRGBO(29, 53, 87, 1),
          labelStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          floatingLabelStyle:
              const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          hintStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          fillColor: const Color.fromRGBO(221, 245, 246, 1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide:
                  const BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
          hintText: 'ej: ejemplo@gmail.com', //placeholder
          labelText: 'Email',
          prefixIcon: const Icon(Icons.email_rounded)),
    );
  }

  _getPassword({String label = ''}) {
    return TextField(
      obscureText: true,
      onChanged: (value) => setState(() {
        _teacher.password = value;
      }),
      decoration: InputDecoration(
          filled: true,
          iconColor: const Color.fromRGBO(29, 53, 87, 1),
          labelStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          floatingLabelStyle:
              const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          hintStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          fillColor: const Color.fromRGBO(221, 245, 246, 1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                  color: Color.fromRGBO(29, 53, 87, 1))), //placeholder
          labelText: label,
          prefixIcon: const Icon(Icons.lock_open)),
    );
  }

  _getButton(String label, color, BuildContext context, String route,
      {borderColor = Colors.white, textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: () => _authenticate(),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        minimumSize: const Size(250, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor, width: 1.0)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  _authenticate() {}
}
