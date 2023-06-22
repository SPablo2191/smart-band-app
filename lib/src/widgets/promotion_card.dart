import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';
import 'package:smartband/src/models/promotion_model.dart';

import '../models/test_model.dart';

class PromotionCard extends StatelessWidget {
  final Promotion promotion;
  const PromotionCard({required this.promotion, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        color: colorLight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: const [
                  Text(
                    'Año: 2024',
                    style: TextStyle(color: colorPrimary),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Clase: 4to secundaria',
                      style: TextStyle(color: colorPrimary),
                    ),
                    Text(
                      'Cantidad de Alumnos: 30',
                      style: TextStyle(color: colorPrimary),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
