import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final Color buttonColor;
  final Color buttonIconColor;
  final IconData buttonIcon;
  final Color buttonLabelColor;
  final String buttonLabel;
  final String path;
  final double top;
  final double left;
  final double right;
  final double bottom;

  const HomeButton(
      {required this.buttonColor,
      required this.buttonIconColor,
      required this.buttonIcon,
      required this.buttonLabel,
      required this.buttonLabelColor,
      required this.path,
      this.top = 1.0,
      this.left = 1.0,
      this.bottom = 1.0,
      this.right = 1.0,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
      child: Column(
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
                Navigator.pushNamed(context, path);
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
      ),
    );
  }
}
