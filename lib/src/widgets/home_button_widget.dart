import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final Color buttonColor;
  final Color buttonIconColor;
  final IconData buttonIcon;
  final Color buttonLabelColor;
  final String buttonLabel;

  const HomeButton(
      {required this.buttonColor,
      required this.buttonIconColor,
      required this.buttonIcon,
      required this.buttonLabel,
      required this.buttonLabelColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: buttonColor,
          ),
          child: IconButton(
            onPressed: () {
              // Acción al presionar el botón
            },
            iconSize: 30,
            icon: Icon(
              buttonIcon,
              color: buttonIconColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          buttonLabel,
          textAlign: TextAlign.center,
          style: TextStyle(color: buttonLabelColor),
        ),
      ],
    );
  }
}
