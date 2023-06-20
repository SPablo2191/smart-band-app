import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';
import 'package:smartband/src/widgets/appbar_widget.dart';
import 'package:smartband/src/widgets/ui/ui_button_widget.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Ver Estudiantes',
          showBackButton: true,
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 15, left: 15),
          child: ListView(
            children: [
              UiButton(
                label: 'Crear Estudiante',
                color: colorSecondary,
                textColor: colorPrimary,
                context: context,
                onPressedCallback: () => {},
                startIcon: Icons.person_add_alt_1_outlined,
                bottom: 10,
                endIcon: Icons.add_box_outlined,
              ),
              UiButton(
                label: 'Seleccionar un colegio',
                color: colorSecondary,
                textColor: colorPrimary,
                context: context,
                onPressedCallback: () => {},
                startIcon: Icons.home_outlined,
                endIcon: Icons.arrow_drop_down_circle_outlined,
              ),
            ],
          ),
        ));
  }
}
