import 'package:flutter/material.dart';
import 'package:vital/src/models/teacher_model.dart';
import 'package:vital/src/pages/register/register_step_2_page.dart';
import 'package:vital/src/widgets/appbar_widget.dart';

class RegisterStep1Page extends StatefulWidget {
  const RegisterStep1Page({super.key});

  @override
  State<RegisterStep1Page> createState() => _RegisterStep1PageState();
}

class _RegisterStep1PageState extends State<RegisterStep1Page> {
  final Teacher _teacher = Teacher();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Registrarse'),
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
            _getPassword(label: 'Repetir Contraseña'),
            Container(
              height: 40,
            ),
            _getButton('Siguiente', const Color.fromRGBO(29, 53, 87, 1),
                context, 'register/step2'),
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
                          Navigator.pushNamed(context, 'login');
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: '¿Ya tienes cuenta? ',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: 'Inicia Sesión',
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
      onPressed: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterStep2Page(
                      teacher: _teacher,
                    )))
      },
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
}
