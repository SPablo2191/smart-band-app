import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartband/src/core/consts/colors.dart';
import 'package:smartband/src/models/student_model.dart';
import 'package:smartband/src/widgets/appbar_widget.dart';

import '../../models/school_model.dart';
import '../../widgets/bottom_navigation_bar_widget.dart';
import '../../widgets/ui/ui_button_widget.dart';

class StudentAddPage extends StatefulWidget {
  const StudentAddPage({super.key});

  @override
  State<StudentAddPage> createState() => _StudentAddPageState();
}

class _StudentAddPageState extends State<StudentAddPage> {
  final Student _student = Student();
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
            top: 25.0, right: 8.0, left: 8.0, bottom: 8.0),
        child: ListView(
          children: [
            // SchoolDropdown(onSchoolSelected: onSchoolSelected),
            _getDNI(),
            const SizedBox(height: 10.0),
            _getName(),
            const SizedBox(height: 10.0),
            _getLastName(),
            const SizedBox(height: 10.0),
            _getAge(),
            const SizedBox(height: 10.0),
            _getWeight(),
            const SizedBox(height: 10.0),
            _getSize(),
            const SizedBox(height: 10.0),
            _getSeatHeight(),
            const SizedBox(height: 10.0),
            _getWaist(),
            Container(height: 10),
            UiButton(
              label: 'Registrar Estudiante',
              color: colorPrimary,
              context: context,
              onPressedCallback: () => _saveData(),
            ),
            Container(
              height: 5,
            ),
            UiButton(
                label: 'Cancelar',
                color: colorRed,
                context: context,
                onPressedCallback: () =>
                    Navigator.pushNamed(context, 'student')),
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
        iconColor: colorPrimary,
        labelStyle: const TextStyle(color: colorPrimary),
        floatingLabelStyle: const TextStyle(color: colorPrimary),
        hintStyle: const TextStyle(color: colorPrimary),
        fillColor: colorLight,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: colorPrimary)),
        labelText: 'DNI',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }

  _getAge() {
    return TextField(
      onChanged: (value) => setState(() {
        _student.age = int.tryParse(value);
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
        labelText: 'Edad',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // Permite solo dígitos
      ],
      keyboardType: TextInputType.number, // Muestra el teclado numérico
    );
  }

  _getName() {
    return TextField(
      onChanged: (value) => setState(() {
        _student.name = value;
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
        labelText: 'Nombre',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }

  _getLastName() {
    return TextField(
      onChanged: (value) => setState(() {
        _student.last_name = value;
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
  }

  _getWeight() {
    return TextField(
      onChanged: (value) => setState(() {
        _student.weight = double.tryParse(value);
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
        labelText: 'Peso (Kg)',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,1}$')), // Permite solo números con un decimal
      ],
      keyboardType: const TextInputType.numberWithOptions(
          decimal: true), // Muestra el teclado numérico con opción decimal
    );
  }

  _getSize() {
    return TextField(
      onChanged: (value) => setState(() {
        _student.size = double.tryParse(value);
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
        labelText: 'Estatura (cm)',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,1}$')), // Permite solo números con un decimal
      ],
      keyboardType: const TextInputType.numberWithOptions(
          decimal: true), // Muestra el teclado numérico con opción decimal
    );
  }

  _getSeatHeight() {
    return TextField(
      onChanged: (value) => setState(() {
        _student.seat_height = double.tryParse(value);
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
        labelText: 'Estatura sentado (cm)',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,1}$')), // Permite solo números con un decimal
      ],
      keyboardType: const TextInputType.numberWithOptions(
          decimal: true), // Muestra el teclado numérico con opción decimal
    );
  }

  _getWaist() {
    return TextField(
      onChanged: (value) => setState(() {
        _student.waist = double.tryParse(value);
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
        labelText: 'Circunferencia Cintura (cm)',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^\d+\.?\d{0,1}$')), // Permite solo números con un decimal
      ],
      keyboardType: const TextInputType.numberWithOptions(
          decimal: true), // Muestra el teclado numérico con opción decimal
    );
  }

  _saveData() {}
}
