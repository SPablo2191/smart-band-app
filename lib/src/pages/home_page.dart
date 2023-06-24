import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vital/src/core/consts/colors.dart';
import 'package:vital/src/providers/teacher_provider.dart';
import 'package:vital/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:vital/src/widgets/home_button_widget.dart';
import 'package:vital/src/widgets/test_card_widget.dart';

import '../models/teacher_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _accessToken = '';
  Future<Teacher>? _teacher;
  int? _userId = 0;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [_getHomeTitle(), _getMainFunctions(), _getTests()],
        ),
        bottomNavigationBar: const CustomBottomNavigationBar());
  }

  _getHomeTitle() {
    return FutureBuilder<Teacher>(
      future: _teacher,
      builder: (BuildContext context, AsyncSnapshot<Teacher> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final teacher = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: '¡Hola\n',
                      style: const TextStyle(
                        color: Color.fromRGBO(29, 53, 87, 1),
                        fontSize: 40,
                      ),
                      children: [
                        TextSpan(
                          text: '${teacher.name}!',
                          style: const TextStyle(
                            color: Color.fromRGBO(29, 53, 87, 1),
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                    width: 20), // Espacio adicional entre el texto y el botón
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(29, 53, 87, 1),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'profile');
                    },
                    iconSize: 40,
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('No hay datos disponibles ${snapshot.data}');
        }
      },
    );
  }

  _getMainFunctions() {
    return Container(
      decoration: const BoxDecoration(
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                HomeButton(
                    buttonColor: colorSecondary,
                    buttonIconColor: colorPrimary,
                    buttonIcon: Icons.person_add_alt,
                    buttonLabelColor: colorPrimary,
                    path: 'student',
                    buttonLabel: 'Ver Estudiantes'),
                HomeButton(
                    buttonColor: colorSecondary,
                    buttonIconColor: colorPrimary,
                    buttonIcon: Icons.people_alt_outlined,
                    buttonLabelColor: colorPrimary,
                    path: 'promotion',
                    buttonLabel: 'Ver Promociones'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                HomeButton(
                    buttonColor: colorSecondary,
                    buttonIconColor: colorPrimary,
                    buttonIcon: Icons.add_chart_rounded,
                    buttonLabelColor: colorPrimary,
                    path: 'test/add',
                    buttonLabel: 'Crear Evaluaciones'),
                HomeButton(
                    buttonColor: colorSecondary,
                    buttonIconColor: colorPrimary,
                    buttonIcon: Icons.file_copy_outlined,
                    buttonLabelColor: colorPrimary,
                    path: '',
                    buttonLabel: 'Historial Evaluaciones'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getTests() {
    return FutureBuilder<Teacher>(
      future: _teacher,
      builder: (BuildContext context, AsyncSnapshot<Teacher> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final teacher = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Evaluaciones',
                  style: TextStyle(color: colorPrimary, fontSize: 20),
                ),
                if (teacher.tests != null && teacher.tests!.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: teacher.tests!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final test = teacher.tests![index];
                      return TestCard(
                        test: test,
                        path: 'test/detail',
                      );
                    },
                  )
                else
                  Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: const Center(
                      child: Text(
                        'No hay evaluaciones disponibles',
                        style: TextStyle(color: colorPrimary, fontSize: 20),
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return Text('No hay datos disponibles ${snapshot.data}');
        }
      },
    );
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
    _userId = prefs.getInt('userId');
    TeacherProvider teacherProvider = TeacherProvider();
    setState(() {
      _teacher = teacherProvider.getTeacherById(_userId, _accessToken);
    });
  }
}
