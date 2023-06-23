import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vital/src/models/promotion_model.dart';
import 'package:vital/src/widgets/appbar_widget.dart';
import 'package:vital/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:vital/src/widgets/promotion_dropdown_widget.dart';

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
  bool _showPromotions = false;
  bool _showStudents = false;
  String? _accessToken = '';
  final SchoolProvider schoolProvider = SchoolProvider();
  final PromotionProvider promotionProvider = PromotionProvider();
  School? selectedSchool;
  Promotion? selectedPromotion;
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
                  onPromotionSelected: onPromotionSelected)
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
  }

  onPromotionSelected(Promotion? promotion) {
    setState(() {
      selectedPromotion = promotion;
    });
  }
}
