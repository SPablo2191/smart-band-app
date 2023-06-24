import 'package:flutter/material.dart';
import 'package:vital/src/core/consts/colors.dart';
import 'package:intl/intl.dart';

import '../models/test_model.dart';

class TestCard extends StatelessWidget {
  final dynamic test;
  final String path;
  const TestCard({required this.path, required this.test, super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime promotionYear =
        DateTime.parse(test['promotion']['promotion_year']);
    final String classroomName = test['promotion']['prom_class']['name'];
    final DateTime registerDate = DateTime.parse(test['register_date']);
    final formattedDate = DateFormat('dd/MM/yyyy').format(registerDate);
    final String testStatus = test['status_test']['description'];
    return InkWell(
      onTap: () {
        // Navegación en función del parámetro
        Navigator.pushNamed(context, path, arguments: {'id': test['id']});
      },
      child: SizedBox(
        height: 100,
        child: Card(
          color: colorLight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: [
                    Text(
                      'Promoción: ${promotionYear.year}',
                      style: TextStyle(color: colorPrimary),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Clase: ${classroomName}',
                      style: TextStyle(color: colorPrimary),
                    )
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fecha de Creación: ${formattedDate}',
                        style: TextStyle(color: colorPrimary),
                      ),
                      Text(
                        'Estado: ${testStatus}',
                        style: TextStyle(color: colorPrimary),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
