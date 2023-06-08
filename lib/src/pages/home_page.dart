import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: '¡Hola\n',
                    style: TextStyle(
                      color: Color.fromRGBO(29, 53, 87, 1),
                      fontSize: 40,
                    ),
                    children: [
                      TextSpan(
                        text: 'Juan Perez!',
                        style: TextStyle(
                          color: Color.fromRGBO(29, 53, 87, 1),
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 44),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(29, 53, 87, 1),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Acción al presionar el botón redondo
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
