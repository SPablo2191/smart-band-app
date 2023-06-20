import 'package:flutter/material.dart';

class UiButton extends StatelessWidget {
  final String label;
  final Color color;
  final BuildContext context;
  final Color borderColor;
  final Color textColor;
  final VoidCallback? onPressedCallback;
  final double top;
  final double left;
  final double right;
  final double bottom;
  final IconData? startIcon; // Nuevo campo opcional para el icono al comienzo
  final IconData? endIcon;

  const UiButton({
    required this.label,
    required this.color,
    required this.context,
    this.top = 1.0,
    this.left = 1.0,
    this.bottom = 1.0,
    this.right = 1.0,
    this.borderColor = Colors.white,
    this.textColor = Colors.white,
    this.onPressedCallback,
    this.startIcon, // Inicializar el campo opcional del icono al comienzo
    this.endIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
      child: ElevatedButton(
        onPressed: onPressedCallback,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          minimumSize: const Size(350, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor, width: 1.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (startIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(startIcon),
              ),
            Text(
              label,
              style: const TextStyle(fontSize: 20),
            ),
            if (endIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Icon(endIcon),
              ),
          ],
        ),
      ),
    );
  }
}
