import 'package:flutter/material.dart';

class UiButton extends StatelessWidget {
  final String label;
  final Color color;
  final BuildContext context;
  final Color borderColor;
  final Color textColor;
  final VoidCallback? onPressedCallback;
  const UiButton(
      {required this.label,
      required this.color,
      required this.context,
      this.borderColor = Colors.white,
      this.textColor = Colors.white,
      this.onPressedCallback,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedCallback,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        minimumSize: const Size(350, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor, width: 1.0)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
