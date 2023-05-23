import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          'Registrarse',
          style: TextStyle(color: Color.fromRGBO(29, 53, 87, 1), fontSize: 30),
        )),
        backgroundColor: Colors.white,
      ),
      body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
            _getButton(
                'Siguiente', Color.fromRGBO(29, 53, 87, 1), context, '/'),
            Container(
                margin: EdgeInsets.only(top: 46.0),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Container(
                    margin: EdgeInsets.only(top: 10),
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
        _email = value;
      }),
      decoration: InputDecoration(
          filled: true,
          iconColor: Color.fromRGBO(29, 53, 87, 1),
          labelStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          floatingLabelStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          hintStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          fillColor: Color.fromRGBO(221, 245, 246, 1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
          hintText: 'ej: ejemplo@gmail.com', //placeholder
          labelText: 'Email',
          prefixIcon: Icon(Icons.email_rounded)),
    );
  }

  _getPassword({String label = ''}) {
    return TextField(
      obscureText: true,
      onChanged: (value) => setState(() {
        _password = value;
      }),
      decoration: InputDecoration(
          filled: true,
          iconColor: Color.fromRGBO(29, 53, 87, 1),
          labelStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          floatingLabelStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          hintStyle: TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
          fillColor: Color.fromRGBO(221, 245, 246, 1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(
                  color: Color.fromRGBO(29, 53, 87, 1))), //placeholder
          labelText: label,
          prefixIcon: Icon(Icons.lock_open)),
    );
  }

  _getButton(String label, color, BuildContext context, String route,
      {borderColor = Colors.white, textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: () => {Navigator.pushNamed(context, route)},
      child: Text(
        label,
        style: TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        minimumSize: Size(250, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor, width: 1.0)),
      ),
    );
  }
}
