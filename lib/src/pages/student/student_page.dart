import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartband/src/core/consts/colors.dart';
import 'package:smartband/src/models/promotion_model.dart';
import 'package:smartband/src/models/student_model.dart';
import 'package:smartband/src/providers/promotion_provider.dart';
import 'package:smartband/src/widgets/appbar_widget.dart';
import 'package:smartband/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:smartband/src/widgets/student_card_widget.dart';
import 'package:smartband/src/widgets/ui/ui_button_widget.dart';

import '../../models/school_model.dart';
import '../../providers/school_provider.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final _student = TextEditingController();
  bool _showPromotions = false;
  bool _showStudents = false;
  String? _accessToken = '';
  final SchoolProvider schoolProvider = SchoolProvider();
  final PromotionProvider promotionProvider = PromotionProvider();
  School? selectedSchool;
  Promotion? selectedPromotion;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

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
        child: Column(
          children: [
            UiButton(
              label: 'Registrar Estudiante',
              color: colorSecondary,
              textColor: colorPrimary,
              context: context,
              onPressedCallback: () =>
                  {Navigator.pushNamed(context, 'student/add')},
              startIcon: Icons.person_add_alt_1_outlined,
              bottom: 10,
              endIcon: Icons.add_box_outlined,
            ),
            UiButton(
              label: 'Seleccionar un colegio',
              color: colorSecondary,
              textColor: colorPrimary,
              context: context,
              onPressedCallback: () => {_showSchoolSelectionModal(context)},
              startIcon: Icons.home_outlined,
              endIcon: Icons.arrow_drop_down_circle_outlined,
            ),
            if (_showPromotions)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: UiButton(
                  label: 'Seleccionar una promoción',
                  color: colorSecondary,
                  textColor: colorPrimary,
                  context: context,
                  onPressedCallback: () =>
                      {_showPromotionSelectionModal(context)},
                  endIcon: Icons.arrow_drop_down_circle_outlined,
                ),
              ),
            if (_showStudents) _getStudents()
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  // ignore: unused_element
  Widget _searchStudent() {
    return TextField(
      controller: _student,
      decoration: InputDecoration(
        filled: true,
        iconColor: colorPrimary,
        labelStyle: const TextStyle(color: colorPrimary),
        floatingLabelStyle: const TextStyle(color: colorPrimary),
        hintStyle: const TextStyle(color: colorPrimary),
        fillColor: colorLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: colorLight),
        ),
        labelText: 'Busqueda',
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }

  void _showSchoolSelectionModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.white,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Seleccionar Colegio',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorPrimary),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<School>>(
                  future: schoolProvider
                      .getSchools(), // Obtener la lista de escuelas desde el proveedor
                  builder: (BuildContext context,
                      AsyncSnapshot<List<School>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error al cargar los colegios'));
                    } else {
                      final List<School> schools = snapshot.data ?? [];

                      return ListView.builder(
                        itemCount: schools.length,
                        itemBuilder: (BuildContext context, int index) {
                          final School school = schools[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSchool = school;
                                _showPromotions =
                                    true; // Guardar la escuela seleccionada
                              });
                              Navigator.pop(context); // Cerrar el modal
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorSecondary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      const Icon(Icons.home_outlined),
                                      const SizedBox(width: 8),
                                      Text(
                                        school.name ?? '',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: colorPrimary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showPromotionSelectionModal(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          color: Colors.white,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Seleccionar Promoción',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorPrimary),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Promotion>>(
                  future: promotionProvider.getPromotions(selectedSchool?.id,
                      _accessToken), // Obtener la lista de escuelas desde el proveedor
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Promotion>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error al cargar las promociones'));
                    } else {
                      final List<Promotion> promotions = snapshot.data ?? [];

                      return ListView.builder(
                        itemCount: promotions.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Promotion promotion = promotions[index];

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPromotion = promotion;
                                _showStudents =
                                    true; // Guardar la escuela seleccionada
                              });
                              Navigator.pop(context); // Cerrar el modal
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colorSecondary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      const Icon(Icons.home_outlined),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${promotion.classroom?.name} \n Año:${promotion.promotion_year?.year}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: colorPrimary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
  }

  _getStudents() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estudiantes',
            style: TextStyle(color: colorPrimary, fontSize: 20),
          ),
          if (selectedPromotion != null &&
              selectedPromotion!.students != null &&
              selectedPromotion!.students!.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: selectedPromotion!.students!.length,
              itemBuilder: (BuildContext context, int index) {
                final studentData =
                    selectedPromotion!.students![index]['student'];
                final student = Student(
                    id: studentData['id'],
                    name: studentData['name'],
                    last_name: studentData['last_name'],
                    DNI: studentData['DNI']);
                return StudentCard(student: student);
              },
            )
          else
            Container(
              alignment: Alignment.center,
              height: 100,
              child: const Center(
                child: Text(
                  'No hay promociones disponibles',
                  style: TextStyle(color: colorPrimary, fontSize: 20),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
