import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartband/src/core/consts/colors.dart';
import 'package:smartband/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:smartband/src/widgets/home_button_widget.dart';
import 'package:smartband/src/widgets/test_card_widget.dart';

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
          children: [_getHomeTitle(), _getMainFunctions(), _getTests()],
        ),
        bottomNavigationBar: CustomBottomNavigationBar());
  }

  _getHomeTitle() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          RichText(
            text: const TextSpan(
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
          const SizedBox(width: 44),
          Container(
            width: 70, // Ajusta el ancho del botón según tu preferencia
            height: 70, // Ajusta la altura del botón según tu preferencia
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(29, 53, 87, 1),
            ),
            child: IconButton(
              onPressed: () {
                // Acción al presionar el botón redondo
              },
              iconSize: 40, // Ajusta el tamaño del ícono según tu preferencia
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getMainFunctions() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorSecondary,
            width: 1.0,
          ),
          bottom: BorderSide(
            color: colorSecondary,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeButton(
                buttonColor: colorSecondary,
                buttonIconColor: colorPrimary,
                buttonIcon: Icons.people_alt_outlined,
                buttonLabelColor: colorPrimary,
                buttonLabel: 'Ver\nPromociones'),
            HomeButton(
                buttonColor: colorSecondary,
                buttonIconColor: colorPrimary,
                buttonIcon: Icons.add_chart_rounded,
                buttonLabelColor: colorPrimary,
                buttonLabel: 'Crear\nEvaluaciones'),
            HomeButton(
                buttonColor: colorSecondary,
                buttonIconColor: colorPrimary,
                buttonIcon: Icons.file_copy_outlined,
                buttonLabelColor: colorPrimary,
                buttonLabel: 'Historial\nEvaluaciones'),
          ],
        ),
      ),
    );
  }

  _getTests() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Evaluaciones',
            style: TextStyle(color: colorPrimary, fontSize: 20),
          ),
          TestCard(),
          TestCard(),
          TestCard(),
          TestCard(),
        ],
      ),
    );
  }
}
