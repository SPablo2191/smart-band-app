import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartband/src/providers/promotion_provider.dart';
import 'package:smartband/src/widgets/appbar_widget.dart';
import 'package:smartband/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:smartband/src/widgets/class_dropdown_widget.dart';

import '../../core/consts/colors.dart';
import '../../models/class_model.dart';
import '../../models/promotion_model.dart';
import '../../models/school_model.dart';
import '../../models/student_model.dart';
import '../../providers/student_provider.dart';
import '../../widgets/school_dropdown_widget.dart';
import '../../widgets/ui/ui_button_widget.dart';

class PromotionAddPage extends StatefulWidget {
  const PromotionAddPage({super.key});

  @override
  State<PromotionAddPage> createState() => _PromotionAddPageState();
}

class _PromotionAddPageState extends State<PromotionAddPage> {
  School? selectedSchool;
  Class? selectedClass;
  List<Student> selectedStudents = [];
  Promotion _newPromotion = Promotion();
  String? _accessToken = '';
  DateTime _selectedDate = DateTime.now();
  final _graduationYearController = TextEditingController();
  void onSchoolSelected(School? school) {
    setState(() {
      selectedSchool = school;
    });
  }

  @override
  void initState() {
    super.initState();
    _getKey();
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
        padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 15),
        child: Column(
          children: [
            SchoolDropdown(onSchoolSelected: onSchoolSelected),
            const SizedBox(height: 10.0),
            _getGraduationYear(),
            const SizedBox(height: 10.0),
            _getClassroom(),
            const SizedBox(height: 10.0),
            if (_accessToken != null)
              const Center(
                child: Text(
                  'Estudiantes',
                  style: TextStyle(color: colorPrimary, fontSize: 20),
                ),
              ),
            _getStudents(),
            // SizedBox(height: 290.0),
            UiButton(
              label: 'Crear Promoción',
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
                    Navigator.pushNamed(context, 'promotion')),
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
              selectedDate: _newPromotion.promotion_year ?? DateTime.now(),
              onChanged: (DateTime dateTime) {
                setState(() {
                  _selectedDate = dateTime;
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

  _saveData() async {
    _newPromotion = Promotion(
        promotion_year: _selectedDate,
        school_id: selectedSchool?.id,
        class_id: selectedClass?.id,
        students: selectedStudents);
    PromotionProvider promotionProvider = PromotionProvider();
    final band =
        await promotionProvider.createPromotion(_newPromotion, _accessToken);
    if (band) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, 'promotion');
    } else {
      Fluttertoast.showToast(
          msg: "registro de promoción invalido. Pruebe nuevamente",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: const Color.fromRGBO(29, 53, 87, 1),
          textColor: const Color.fromRGBO(221, 245, 246, 1),
          fontSize: 16.0);
    }
  }

  Future<String> _getKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
    return _accessToken ?? '';
  }

  _getStudents() {
    StudentProvider studentProvider = StudentProvider();
    return FutureBuilder<List<Student>>(
      future: _getKey()
          .then((accessToken) => studentProvider.getStudents(accessToken)),
      builder: (BuildContext context, AsyncSnapshot<List<Student>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final students = snapshot.data!;

          return SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                final student = students[index];

                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: student.isSelected ? colorSecondary : colorLight,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: colorSecondary),
                  child: CheckboxListTile(
                    title: Text(
                      '${student.last_name}, ${student.name} \n DNI: ${student.DNI}',
                      style: const TextStyle(color: colorPrimary),
                    ),
                    value: student.isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null) {
                          student.isSelected = value;

                          if (value) {
                            selectedStudents.add(student);
                          } else {
                            selectedStudents.remove(student);
                          }
                        }
                      });
                    },
                  ),
                );
              },
            ),
          );
        } else {
          return const Text('No hay datos disponibles');
        }
      },
    );
  }
}
