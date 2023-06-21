import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';

import '../models/school_model.dart';
import '../providers/school_provider.dart';

class SchoolDropdown extends StatefulWidget {
  @override
  _SchoolDropdownState createState() => _SchoolDropdownState();
}

class _SchoolDropdownState extends State<SchoolDropdown> {
  final SchoolProvider schoolProvider = SchoolProvider();
  List<School> schools = []; // Lista de objetos School
  School? selectedSchool; // Colegio seleccionado

  @override
  void initState() {
    super.initState();
    loadSchools();
  }

  void loadSchools() async {
    List<School> fetchedSchools = await schoolProvider
        .getSchools(); // Obtener la lista de colegios desde el provider

    setState(() {
      schools = fetchedSchools;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorLight,
          border: Border.all(
            color: colorPrimary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: DropdownButton<School>(
          value: selectedSchool,
          onChanged: (School? newValue) {
            setState(() {
              selectedSchool = newValue;
            });
          },
          hint: Text(
            'Seleccionar un colegio',
            style: TextStyle(color: colorPrimary),
          ), // Placeholder
          dropdownColor: colorSecondary, // Fondo celeste
          icon: Icon(Icons.home_outlined), // Icono al inicio
          items: schools.map<DropdownMenuItem<School>>((School value) {
            return DropdownMenuItem<School>(
              value: value,
              child: Text(
                value.name ?? '',
                style: TextStyle(color: colorPrimary),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
