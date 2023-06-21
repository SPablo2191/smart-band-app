import 'package:flutter/material.dart';
import 'package:smartband/src/widgets/appbar_widget.dart';
import 'package:smartband/src/widgets/school_dropdown_widget.dart';

import '../../widgets/bottom_navigation_bar_widget.dart';

class StudentAddPage extends StatefulWidget {
  const StudentAddPage({super.key});

  @override
  State<StudentAddPage> createState() => _StudentAddPageState();
}

class _StudentAddPageState extends State<StudentAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Añadir Estudiante', showBackButton: true, centerTitle: false),
      body: ListView(
        children: [SchoolDropdown()],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
