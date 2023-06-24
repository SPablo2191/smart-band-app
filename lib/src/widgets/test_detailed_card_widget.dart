import 'package:flutter/material.dart';
import 'package:vital/src/models/test_model.dart';

import '../core/consts/colors.dart';

class TestDetailedCard extends StatelessWidget {
  final Test? test;
  const TestDetailedCard({required this.test, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                title: Text(
                  "Colegio: ${test?.promotion?.school?.name}",
                  style: const TextStyle(color: colorPrimary),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Clase: ${test?.promotion?.classroom?.name} ',
                            style: const TextStyle(color: colorPrimary),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Clase: ${test?.promotion?.promotion_year?.year} ',
                            style: const TextStyle(color: colorPrimary),
                          ),
                        ],
                      ),
                      Text(
                        'Estado: ${test?.statusTest?.description} ',
                        style: const TextStyle(color: colorPrimary),
                      ),
                      Text(
                        'Fecha de Realización: ${test?.getRegisterDate()} ',
                        style: const TextStyle(color: colorPrimary),
                      ),
                      Text(
                        'Ejercicios: ',
                        style: const TextStyle(
                            color: colorPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: test?.exercises?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            test?.exercises?[index]['exercise']['description'],
                            style: const TextStyle(color: colorPrimary),
                          );
                        },
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
