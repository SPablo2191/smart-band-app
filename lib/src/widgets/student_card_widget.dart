import 'package:flutter/material.dart';
import 'package:vital/src/models/student_model.dart';

import '../core/consts/colors.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final String? helperText;
  final VoidCallback? onPressedCallback;
  const StudentCard(
      {required this.student,
      this.onPressedCallback,
      this.helperText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressedCallback ?? () {},
      child: SizedBox(
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
                        style: const TextStyle(color: colorPrimary),
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
                          style: const TextStyle(color: colorPrimary),
                        ),
                        if (helperText != null)
                          Text(
                            helperText ?? '',
                            style: const TextStyle(
                                color: colorPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
