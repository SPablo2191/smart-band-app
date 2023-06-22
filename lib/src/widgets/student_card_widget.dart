import 'package:flutter/material.dart';
import 'package:smartband/src/models/student_model.dart';

import '../core/consts/colors.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  const StudentCard({required this.student, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          color: colorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Row(
                  children: [
                    Text(
                      '${student.name} ${student.last_name}',
                      style:const TextStyle(color: colorPrimary),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DNI: ${student.DNI}',
                        style:const TextStyle(color: colorPrimary),
                      ),
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
