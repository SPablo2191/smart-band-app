import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartband/src/models/exercise_model.dart';
import 'package:smartband/src/models/promotion_model.dart';
import 'package:smartband/src/models/test_model.dart';
import 'package:smartband/src/providers/exercise_provider.dart';
import 'package:smartband/src/providers/test_provider.dart';
import 'package:smartband/src/widgets/appbar_widget.dart';
import 'package:smartband/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:smartband/src/widgets/exercise_dropdown_widget.dart';
import 'package:smartband/src/widgets/promotion_dropdown_widget.dart';

import '../../core/consts/colors.dart';
import '../../models/school_model.dart';
import '../../providers/promotion_provider.dart';
import '../../providers/school_provider.dart';
import '../../widgets/ui/ui_button_widget.dart';

class TestAddPage extends StatefulWidget {
  const TestAddPage({super.key});

  @override
  State<TestAddPage> createState() => _TestAddPageState();
}

class _TestAddPageState extends State<TestAddPage> {
  final SchoolProvider schoolProvider = SchoolProvider();
  final PromotionProvider promotionProvider = PromotionProvider();
  bool _showPromotions = false;
  bool _showExercises = false;
  String? _accessToken = '';
  int? _userId = 0;
  School? selectedSchool;
  Promotion? selectedPromotion;
  List<Exercise> selectedExercises = [];
  List<Promotion> promotions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Crear Evaluación', centerTitle: false, showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
        child: ListView(
          children: [
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
              PromotionDropdown(
                  accessToken: _accessToken ?? "",
                  schoolId: selectedSchool!.id!,
                  onPromotionSelected: onPromotionSelected),
            if (_showExercises) _getExercises(),
            Container(height: 10),
            if (_showExercises)
              UiButton(
                label: 'Crear Evaluación',
                color: colorPrimary,
                context: context,
                onPressedCallback: () => _saveData(),
              ),
            if (_showExercises)
              Container(
                height: 5,
              ),
            UiButton(
                label: 'Cancelar',
                color: colorRed,
                context: context,
                onPressedCallback: () => Navigator.pushNamed(context, 'home')),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
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

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
    _userId = prefs.getInt('userId');
  }

  onPromotionSelected(Promotion? promotion) {
    setState(() {
      selectedPromotion = promotion;
      _showExercises = true;
    });
  }

  _getExercises() {
    final ExerciseProvider exerciseProvider = ExerciseProvider();
    return FutureBuilder(
      future: exerciseProvider.getExercises(_accessToken),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data
              ?.map((exercise) => MultiSelectItem<Exercise?>(
                  exercise, exercise.description ?? ''))
              .toList() as List<MultiSelectItem<Object?>>;
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(221, 245, 246, 1),
              border: Border.all(
                color: const Color.fromRGBO(29, 53, 87, 1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: MultiSelectDialogField(
                searchable: true,
                listType: MultiSelectListType.CHIP,
                dialogHeight: 160,
                title: const Text('Seleccionar'),
                items: items,
                buttonIcon: const Icon(
                  Icons.home_filled,
                  color: Color.fromRGBO(29, 53, 87, 1),
                ),
                buttonText: const Text(
                  "Ejercicios",
                  style: TextStyle(
                    color: Color.fromRGBO(29, 53, 87, 1),
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  List<Exercise> options = [];
                  for (dynamic element in results) {
                    options.add(element);
                  }
                  selectedExercises = options;
                }),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return Container(
          height: 1,
          width: 10,
          margin: const EdgeInsets.all(5),
          child: const CircularProgressIndicator(
            strokeWidth: 4,
            valueColor:
                AlwaysStoppedAnimation<Color>(Color.fromRGBO(29, 53, 87, 1)),
          ),
        );
      },
    );
  }

  _saveData() async {
    Test newTest = Test(
        promotion_id: selectedPromotion!.id ?? 0,
        status_test_id: 1,
        teacher_id: _userId ?? 0,
        exercises: selectedExercises);
    TestProvider testProvider = TestProvider();
    bool band = await testProvider.createTest(newTest, _accessToken);
    if (band) {
      Navigator.pushNamed(context, 'home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al crear la evaluación'),
        ),
      );
    }
  }
}
