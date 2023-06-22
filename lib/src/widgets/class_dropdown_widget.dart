// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartband/src/core/consts/colors.dart';
import 'package:smartband/src/models/class_model.dart';

import '../models/school_model.dart';
import '../providers/class_provider.dart';

class ClassDropdown extends StatefulWidget {
  final Function(Class?)
      onClassSelected; // Callback para notificar la selección

  const ClassDropdown({required this.onClassSelected});

  @override
  _ClassDropdownState createState() => _ClassDropdownState();
}

class _ClassDropdownState extends State<ClassDropdown> {
  final ClassProvider classProvider = ClassProvider();
  List<Class> classes = []; // Lista de objetos School
  Class? selectedClass; // Colegio seleccionado

  @override
  void initState() {
    super.initState();
    loadClasses();
  }

  void loadClasses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = prefs.getString('accessToken');
    List<Class> fetchedClasses = await classProvider.getClasses(accessToken);

    setState(() {
      classes = fetchedClasses;
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
        child: DropdownButton<Class>(
          value: selectedClass,
          onChanged: (Class? newValue) {
            setState(() {
              selectedClass = newValue;
            });

            // Llamar a la función de callback con el valor seleccionado
            widget.onClassSelected(newValue);
          },
          hint: const Text(
            'Clase Actual',
            style: TextStyle(color: colorPrimary),
          ),
          dropdownColor: colorSecondary,
          icon: const Icon(Icons.bookmark),
          items: classes.map<DropdownMenuItem<Class>>((Class value) {
            return DropdownMenuItem<Class>(
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
