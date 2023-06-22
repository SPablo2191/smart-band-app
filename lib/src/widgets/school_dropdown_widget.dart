// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';

import '../models/school_model.dart';
import '../providers/school_provider.dart';

class SchoolDropdown extends StatefulWidget {
  final Function(School?)
      onSchoolSelected; // Callback para notificar la selección

  const SchoolDropdown({required this.onSchoolSelected});

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
    List<School> fetchedSchools = await schoolProvider.getSchools();

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
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: DropdownButton<School>(
          value: selectedSchool,
          onChanged: (School? newValue) {
            setState(() {
              selectedSchool = newValue;
            });

            // Llamar a la función de callback con el valor seleccionado
            widget.onSchoolSelected(newValue);
          },
          hint: const Text(
            'Seleccionar un colegio',
            style: TextStyle(color: colorPrimary),
          ),
          dropdownColor: colorSecondary,
          icon: const Icon(Icons.home_outlined),
          items: schools.map<DropdownMenuItem<School>>((School value) {
            return DropdownMenuItem<School>(
              value: value,
              child: Text(
                value.name ?? '',
                style: const TextStyle(color: colorPrimary),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class YourPage extends StatefulWidget {
  @override
  _YourPageState createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  School? selectedSchool;

  void onSchoolSelected(School? school) {
    setState(() {
      selectedSchool = school;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Page'),
      ),
      body: Column(
        children: [
          SchoolDropdown(onSchoolSelected: onSchoolSelected),
          ElevatedButton(
            onPressed: () {
              // Utilizar el valor seleccionado
              if (selectedSchool != null) {
              } else {}
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
