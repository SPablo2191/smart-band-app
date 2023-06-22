import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';
import 'package:smartband/src/models/promotion_model.dart';

import '../models/test_model.dart';

class PromotionCard extends StatelessWidget {
  final Promotion promotion;
  const PromotionCard({required this.promotion, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5, top: 5),
      child: Card(
        color: colorLight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: [
                  Text(
                    'Año: ${promotion.promotion_year?.year}',
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
                      'Clase: ${promotion.classroom?.name}',
                      style: const TextStyle(color: colorPrimary),
                    ),
                    // Text(
                    //   'Cantidad de Alumnos: 30',
                    //   style: TextStyle(color: colorPrimary),
                    // )
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
