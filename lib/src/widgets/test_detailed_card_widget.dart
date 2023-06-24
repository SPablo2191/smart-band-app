import 'package:flutter/material.dart';
import 'package:vital/src/models/test_model.dart';

import '../core/consts/colors.dart';

class TestDetailedCard extends StatelessWidget {
  final Test? test;
  const TestDetailedCard({required this.test, super.key});

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
                      "Clase: ${test?.promotion?.classroom?.name}",
                      style: const TextStyle(color: colorPrimary),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Año: ${test?.promotion?.promotion_year?.year}",
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
                        'DNI: ',
                        style: const TextStyle(color: colorPrimary),
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
