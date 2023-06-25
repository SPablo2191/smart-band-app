import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vital/src/models/student_model.dart';
import 'package:vital/src/providers/test_provider.dart';
import 'package:vital/src/widgets/bottom_navigation_bar_widget.dart';
import 'package:vital/src/widgets/student_card_widget.dart';
import 'package:vital/src/widgets/test_detailed_card_widget.dart';

import '../../core/consts/colors.dart';
import '../../models/test_model.dart';
import '../../widgets/appbar_widget.dart';

class DetailTestPage extends StatefulWidget {
  const DetailTestPage({super.key});

  @override
  State<DetailTestPage> createState() => _DetailTestPageState();
}

class _DetailTestPageState extends State<DetailTestPage> {
  final TestProvider testProvider = TestProvider();
  int? _userId = 0;
  @override
  void initState() {
    super.initState();
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
                      print(test.promotion?.students?[index]);
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
    return _userId ?? 0;
  }
}
