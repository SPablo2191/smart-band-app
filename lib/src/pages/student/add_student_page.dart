import 'package:flutter/material.dart';
import 'package:smartband/src/models/student_model.dart';
import 'package:smartband/src/widgets/appbar_widget.dart';
import 'package:smartband/src/widgets/school_dropdown_widget.dart';

import '../../models/school_model.dart';
import '../../widgets/bottom_navigation_bar_widget.dart';

class StudentAddPage extends StatefulWidget {
  const StudentAddPage({super.key});

  @override
  State<StudentAddPage> createState() => _StudentAddPageState();
}

class _StudentAddPageState extends State<StudentAddPage> {
  Student _student = Student();
  School? selectedSchool;
  void onSchoolSelected(School? school) {
    setState(() {
      selectedSchool = school;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Añadir Estudiante', showBackButton: true, centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 12.0, right: 8.0, left: 8.0, bottom: 8.0),
        child: ListView(
          children: [
            SchoolDropdown(onSchoolSelected: onSchoolSelected),
            _getDNI()
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  _getDNI() {
    return TextField(
      onChanged: (value) => setState(() {
        _student.DNI = value;
      }),
      textCapitalization: TextCapitalization.sentences,
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
            borderSide: const BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
        labelText: 'DNI',
        helperText: '9 caracteres maximo',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }
}
