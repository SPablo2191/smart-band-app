import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartband/src/core/consts/colors.dart';

import '../../models/teacher_model.dart';
import '../../providers/teacher_provider.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/profile_picture_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      appBar: const CustomAppBar(
        title: 'Mi Perfil',
        showBackButton: true,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 15, left: 15),
        child: ListView(
          children: [
            _getProfilePicture(),
            Container(height: 50),
            _getDNI(),
            Container(height: 15),
            _getName(),
            Container(height: 15),
            _getLastName(),
            Container(height: 15),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colorSecondary,
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            'Colegios',
                            style: TextStyle(color: colorPrimary, fontSize: 20),
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                  _getSchools(),
                  Container(
                    height: 40,
                  ),
                  _getButton('Editar Perfil', colorPrimary, context,
                      onPressedCallback: () =>
                          Navigator.pushNamed(context, '/')),
                  Container(
                    height: 10,
                  ),
                  _getButton('Cerrar Sesión', colorRed, context,
                      onPressedCallback: () => _logout(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getProfilePicture() {
    return const PersonIcon(icon: Icons.person, size: 150);
  }

  _getDNI() {
    return FutureBuilder(
      future: _teacher,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final teacher = snapshot.data!;
          return TextField(
            enabled: false,
            controller: TextEditingController(text: teacher.DNI),
            onChanged: (value) => setState(() {
              teacher.DNI = value;
            }),
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              filled: true,
              iconColor: colorPrimary,
              labelStyle: const TextStyle(color: colorPrimary),
              floatingLabelStyle: const TextStyle(color: colorPrimary),
              hintStyle: const TextStyle(color: colorPrimary),
              fillColor: colorLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: colorPrimary),
              ),
              labelText: 'DNI',
              prefixIcon: const Icon(Icons.perm_identity),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  _getName() {
    return FutureBuilder(
      future: _teacher,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final teacher = snapshot.data!;
          return TextField(
            enabled: false,
            controller: TextEditingController(text: teacher.name),
            onChanged: (value) => setState(() {
              teacher.name = value;
            }),
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              filled: true,
              iconColor: colorPrimary,
              labelStyle: const TextStyle(color: colorPrimary),
              floatingLabelStyle: const TextStyle(color: colorPrimary),
              hintStyle: const TextStyle(color: colorPrimary),
              fillColor: colorLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: colorPrimary),
              ),
              labelText: 'Nombre',
              prefixIcon: const Icon(Icons.perm_identity),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  _getLastName() {
    return FutureBuilder(
      future: _teacher,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final teacher = snapshot.data!;
          return TextField(
            enabled: false,
            controller: TextEditingController(text: teacher.last_name),
            onChanged: (value) => setState(() {
              teacher.last_name = value;
            }),
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              filled: true,
              iconColor: colorPrimary,
              labelStyle: const TextStyle(color: colorPrimary),
              floatingLabelStyle: const TextStyle(color: colorPrimary),
              hintStyle: const TextStyle(color: colorPrimary),
              fillColor: colorLight,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: colorPrimary)),
              labelText: 'Apellido',
              prefixIcon: const Icon(Icons.perm_identity),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _getSchools() {
    return FutureBuilder<Teacher>(
      future: _teacher,
      builder: (BuildContext context, AsyncSnapshot<Teacher> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final Teacher teacher = snapshot.data!;
          final schools = teacher.schools;

          return Column(
            children: schools!.map((school) {
              final String schoolName = school['school']['name'];

              return Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: colorLight,
                    child: ListTile(
                      leading: const Icon(
                        Icons.home_filled,
                        color: colorPrimary,
                      ),
                      title: Text(
                        schoolName,
                        style: const TextStyle(color: colorPrimary),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          return Container();
        }
      },
    );
  }

  _getButton(String label, color, BuildContext context,
      {borderColor = Colors.white,
      textColor = Colors.white,
      VoidCallback? onPressedCallback}) {
    return ElevatedButton(
      onPressed: onPressedCallback,
      // onPressed: () => _logout(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        minimumSize: const Size(350, 50),
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

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
    _userId = prefs.getInt('userId');
    TeacherProvider teacherProvider = TeacherProvider();
    setState(() {
      _teacher = teacherProvider.getTeacherById(_userId, _accessToken);
    });
  }

  _logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(context, '/');
    });
  }
}
