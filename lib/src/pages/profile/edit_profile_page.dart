import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartband/src/widgets/ui/ui_button_widget.dart';

import '../../core/consts/colors.dart';
import '../../models/teacher_model.dart';
import '../../providers/teacher_provider.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/bottom_navigation_bar_widget.dart';
import '../../widgets/profile_picture_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? _accessToken = '';
  Future<Teacher>? _teacher;
  int? _userId = 0;
  final _name = TextEditingController();
  final _last_name = TextEditingController();
  final _dni = TextEditingController();
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
              UiButton(
                label: 'Guardar',
                color: colorPrimary,
                context: context,
                onPressedCallback: () => _saveData(),
              ),
              Container(
                height: 10,
              ),
              UiButton(
                  label: 'Cancelar',
                  color: colorRed,
                  context: context,
                  onPressedCallback: () => Navigator.pop(context)),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar());
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
          _dni.text = teacher.DNI;
          return TextField(
            controller: _dni,
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
          _name.text = teacher.name;
          return TextField(
            controller: _name,
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
          _last_name.text = teacher.last_name;
          return TextField(
            controller: _last_name,
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

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
    _userId = prefs.getInt('userId');
    TeacherProvider teacherProvider = TeacherProvider();
    setState(() {
      _teacher = teacherProvider.getTeacherById(_userId, _accessToken);
    });
  }

  _saveData() {
    print(_name.text);
  }
}
