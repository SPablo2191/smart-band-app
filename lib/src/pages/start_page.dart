import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          _getButton('Iniciar Sesión', Color.fromRGBO(29, 53, 87, 1), context,
              'login'),
          _getButton('Registrarse', Colors.white, context, 'register',
              borderColor: Color.fromRGBO(29, 53, 87, 1),
              textColor: Color.fromRGBO(29, 53, 87, 1))
        ]),
      )),
    );
  }

  _getButton(String label, color, BuildContext context, String route,
      {borderColor = Colors.white, textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: () => {Navigator.pushNamed(context, route)},
      child: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        minimumSize: Size(250, 40),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor, width: 1.0)),
      ),
    );
  }

  _createImage() {
    return Expanded(
      child: Image(fit: BoxFit.contain, image: AssetImage('logo.jpg')),
    );
  }
}
