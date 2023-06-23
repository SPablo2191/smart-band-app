import 'package:flutter/material.dart';
import 'package:vital/src/widgets/appbar_widget.dart';
import 'package:vital/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:vital/src/widgets/school_dropdown_widget.dart';

import '../../models/school_model.dart';

class TestAddPage extends StatefulWidget {
  const TestAddPage({super.key});

  @override
  State<TestAddPage> createState() => _TestAddPageState();
}

class _TestAddPageState extends State<TestAddPage> {
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
          title: 'Crear Evaluación', centerTitle: false, showBackButton: true),
      body: ListView(
        children: [SchoolDropdown(onSchoolSelected: onSchoolSelected)],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
