import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartband/src/models/student_model.dart';
import 'package:smartband/src/models/teacher_model.dart';
import 'package:smartband/src/providers/test_provider.dart';
import 'package:smartband/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:smartband/src/widgets/student_card_widget.dart';
import 'package:smartband/src/widgets/test_detailed_card_widget.dart';

import '../../core/consts/colors.dart';
import '../../models/test_model.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/ui/ui_button_widget.dart';

class DetailTestPage extends StatefulWidget {
  const DetailTestPage({super.key});

  @override
  State<DetailTestPage> createState() => _DetailTestPageState();
}

class _DetailTestPageState extends State<DetailTestPage> {
  final TestProvider testProvider = TestProvider();
  int? _userId = 0;
  String? _accessToken = '';
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int? promotionId = args != null ? args['promotion_id'] : null;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Detalle de Examen',
        showBackButton: true,
        centerTitle: false,
        path: 'home',
      ),
      body: ListView(
        children: [_getDetail(promotionId)],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  _getDetail(int? promotionId) {
    return FutureBuilder(
        future: _loadData()
            .then((value) => testProvider.getTestById(promotionId!, value)),
        builder: (BuildContext context, AsyncSnapshot<Test> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final Test test = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TestDetailedCard(
                    test: test,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Text(
                      'Estudiantes: ',
                      style: TextStyle(
                          color: colorPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: test.promotion?.students?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Student selectedStudent = Student(
                        id: test.promotion?.students?[index]['student']['id'],
                        name: test.promotion?.students?[index]['student']
                            ['name'],
                        last_name: test.promotion?.students?[index]['student']
                            ['last_name'],
                        DNI: test.promotion?.students?[index]['student']['DNI'],
                        age: test.promotion?.students?[index]['student']['age'],
                        waist: test.promotion?.students?[index]['student']
                            ['waist'],
                        weight: test.promotion?.students?[index]['student']
                            ['weight'],
                        seat_height: test.promotion?.students?[index]['student']
                            ['seat_height'],
                        size: test.promotion?.students?[index]['student']
                            ['size'],
                      );
                      return StudentCard(
                        student: selectedStudent,
                        helperText: 'Presiona para registrar resultados...',
                        onPressedCallback: () =>
                            redirectToResult(selectedStudent, promotionId),
                      );
                    },
                  ),
                  UiButton(
                    label: 'Finalizar Evaluación',
                    color: colorPrimary,
                    context: context,
                    onPressedCallback: () => _saveData(promotionId),
                  ),
                  Container(
                    height: 5,
                  ),
                  UiButton(
                      label: 'Cancelar',
                      color: colorRed,
                      context: context,
                      onPressedCallback: () => Navigator.pushNamed(
                            context,
                            'home',
                          )),
                ],
              ),
            );
          } else {
            return const Text('No hay datos');
          }
        });
  }

  redirectToResult(Student student, int? promotionId) {
    Navigator.pushNamed(
      context,
      'test/student/result',
      arguments: {'student': student, 'promotion_id': promotionId},
    );
  }

  Future<int> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt('userId');
    _accessToken = prefs.getString('accessToken');
    return _userId ?? 0;
  }

  _saveData(int? promotionId) async {
    Test test = await _loadData()
        .then((value) => testProvider.getTestById(promotionId!, value));
    test.promotion_id = test.promotion?.id;
    test.teacher_id = _userId;
    test.status_test_id = 2;
    bool band = await testProvider.updateTest(test, _accessToken);
    if (band) {
      Navigator.pushNamed(
        context,
        'home',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al finalizar la evaluación'),
        ),
      );
    }
  }
}
