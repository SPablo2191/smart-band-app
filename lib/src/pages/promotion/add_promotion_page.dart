import 'package:flutter/material.dart';
import 'package:smartband/src/widgets/appbar_widget.dart';
import 'package:smartband/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:smartband/src/widgets/class_dropdown_widget.dart';

import '../../core/consts/colors.dart';
import '../../models/class_model.dart';
import '../../models/promotion_model.dart';
import '../../models/school_model.dart';
import '../../widgets/school_dropdown_widget.dart';

class PromotionAddPage extends StatefulWidget {
  const PromotionAddPage({super.key});

  @override
  State<PromotionAddPage> createState() => _PromotionAddPageState();
}

class _PromotionAddPageState extends State<PromotionAddPage> {
  School? selectedSchool;
  Class? selectedClass;
  Promotion? _newPromotion;
  final _graduationYearController = TextEditingController();
  void onSchoolSelected(School? school) {
    setState(() {
      selectedSchool = school;
    });
  }

  void onClassSelected(Class? classroom) {
    setState(() {
      selectedClass = classroom;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Crear Promoción',
        centerTitle: false,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: ListView(
          children: [
            SchoolDropdown(onSchoolSelected: onSchoolSelected),
            const SizedBox(height: 10.0),
            _getGraduationYear(),
            const SizedBox(height: 10.0),
            _getClassroom(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _getGraduationYear() {
    return TextFormField(
      readOnly: true,
      controller: _graduationYearController,
      onTap: () {
        _showYearPickerModal();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: colorLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: 'Año de Graduación',
        prefixIcon: const Icon(
          Icons.calendar_today,
          color: colorPrimary,
        ),
      ),
    );
  }

  void _showYearPickerModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Seleccionar Año"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              initialDate: DateTime.now(),
              selectedDate: _newPromotion?.promotion_year ?? DateTime.now(),
              onChanged: (DateTime dateTime) {
                setState(() {
                  _newPromotion?.promotion_year = dateTime;
                  _graduationYearController.text = dateTime.year
                      .toString(); // Actualizar el valor del TextField
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  _getClassroom() {
    return ClassDropdown(onClassSelected: onClassSelected);
  }
}
