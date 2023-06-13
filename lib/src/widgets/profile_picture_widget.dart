import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';

class PersonIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double size;
  final Color circleColor;

  const PersonIcon({
    required this.icon,
    this.iconColor = colorExtraLight,
    this.size = 40.0,
    this.circleColor = colorPrimary,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: circleColor,
      radius: size / 2,
      child: Icon(
        icon,
        color: iconColor,
        size: size * 0.8,
      ),
    );
  }
}
