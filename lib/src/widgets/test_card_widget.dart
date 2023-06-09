import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';

class TestCard extends StatelessWidget {
  const TestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    'Promoción: 2024',
                    style: TextStyle(color: colorPrimary),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Clase: 4to Secundaria',
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
                      'Fecha de Creación: 14/05/2023',
                      style: TextStyle(color: colorPrimary),
                    ),
                    Text(
                      'Estado: Pendiente',
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