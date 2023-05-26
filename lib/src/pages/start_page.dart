import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          _createImage(),
          Container(
            child: _getButton('Iniciar Sesión',
                const Color.fromRGBO(29, 53, 87, 1), context, 'login'),
            margin: const EdgeInsets.only(bottom: 5),
          ),
          _getButton('Registrarse', Colors.white, context, 'register',
              borderColor: const Color.fromRGBO(29, 53, 87, 1),
              textColor: const Color.fromRGBO(29, 53, 87, 1))
        ]),
      )),
    );
  }

  _getButton(String label, color, BuildContext context, String route,
      {borderColor = Colors.white, textColor = Colors.white}) {
    return ElevatedButton(
      onPressed: () => {Navigator.pushNamed(context, route)},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        minimumSize: const Size(250, 40),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor, width: 1.0)),
      ),
      child: Text(label),
    );
  }

  _createImage() {
    return const Expanded(
      child: Image(fit: BoxFit.contain, image: AssetImage('assets/logo.jpg')),
    );
  }
}
