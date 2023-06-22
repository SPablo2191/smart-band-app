import 'package:flutter/material.dart';
import 'package:smartband/src/widgets/appbar_widget.dart';
import 'package:smartband/src/widgets/bottom_navigation_bar_widget.dart';

import '../../core/consts/colors.dart';
import '../../models/school_model.dart';
import '../../providers/school_provider.dart';
import '../../widgets/ui/ui_button_widget.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  bool _showPromotions = false;
  final SchoolProvider schoolProvider = SchoolProvider();
  School? selectedSchool;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Ver Promociones',
        centerTitle: false,
        showBackButton: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 25.0, right: 15, left: 15, bottom: 15),
        child: ListView(
          children: [
            UiButton(
              label: 'Crear Promoción',
              color: colorSecondary,
              textColor: colorPrimary,
              context: context,
              onPressedCallback: () =>
                  {Navigator.pushNamed(context, 'student/add')},
              startIcon: Icons.people_alt_outlined,
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
            Visibility(
              visible: _showPromotions,
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Text(
                      'Promociones',
                      style: TextStyle(color: colorPrimary, fontSize: 20),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
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
}
