import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vital/src/widgets/ui/ui_button_widget.dart';

import '../../core/consts/colors.dart';
import '../../models/school_model.dart';
import '../../models/teacher_model.dart';
import '../../providers/school_provider.dart';
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
  List<dynamic> schoolsSelected = [];
  final _name = TextEditingController();
  final _lastName = TextEditingController();
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
          path: 'profile',
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
              Container(
                height: 15,
              ),
              _getSchools(),
              Container(height: 40),
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
                  onPressedCallback: () =>
                      Navigator.pushNamed(context, 'profile')),
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
          _lastName.text = teacher.last_name;
          return TextField(
            controller: _lastName,
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

  _getSchools() {
    final SchoolProvider schoolProvider = SchoolProvider();

    return FutureBuilder(
      future: _teacher,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final teacher = snapshot.data!;
          final schools = teacher.schools;
          final futureItems = schoolProvider
              .getSchools(); // Obtener las escuelas desde el provider

          return FutureBuilder<List<School>>(
            future: futureItems,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<School> allSchools = snapshot.data!;

                final items = allSchools
                    .map((school) => MultiSelectItem<School>(
                          school,
                          school.name ?? '',
                        ))
                    .toList();
                final selectedSchools = schools?.map((school) {
                      final schoolName = school['school']['name'];
                      final schoolId = school['school']['id'];
                      final matchingSchool = allSchools.firstWhere(
                        (s) => s.id == schoolId && s.name == schoolName,
                        orElse: () => School(id: schoolId, name: schoolName),
                      );
                      return matchingSchool;
                    }).toList() ??
                    [];

                return Container(
                  decoration: BoxDecoration(
                    color: colorLight,
                    border: Border.all(
                      color: colorPrimary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: MultiSelectDialogField(
                      searchable: true,
                      initialValue: selectedSchools,
                      listType: MultiSelectListType.CHIP,
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (value) {
                          setState(() {
                            selectedSchools.remove(value);
                          });
                        },
                      ),
                      dialogHeight: 160,
                      title: const Text('Seleccionar'),
                      items: items,
                      buttonIcon: const Icon(
                        Icons.home_filled,
                        color: Color.fromRGBO(29, 53, 87, 1),
                      ),
                      buttonText: const Text(
                        "Colegio",
                        style: TextStyle(
                          color: Color.fromRGBO(29, 53, 87, 1),
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (results) {
                        List<School> options = [];
                        for (dynamic element in results) {
                          options.add(element);
                        }
                        schoolsSelected = options;
                      }),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return Container(
                height: 1,
                width: 10,
                margin: const EdgeInsets.all(5),
                child: const CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(29, 53, 87, 1),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return Container(
          height: 10,
          width: 10,
          margin: const EdgeInsets.all(5),
          child: const CircularProgressIndicator(
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(29, 53, 87, 1),
            ),
          ),
        );
      },
    );
  }

  _saveData() async {
    final TeacherProvider teacherProvider = TeacherProvider();
    final teacher = Teacher(
      id: _userId,
      DNI: _dni.text,
      name: _name.text,
      last_name: _lastName.text,
      schools: schoolsSelected,
    );
    final band = await teacherProvider.updateTeacher(teacher, _accessToken);
    if (band) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, 'profile');
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al actualizar los datos'),
        ),
      );
    }
  }
}
