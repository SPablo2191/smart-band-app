import 'package:flutter/material.dart';

import '../core/consts/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorSecondary,
            width: 1.0,
          ),
        ),
      ),
      height: 50,
      child: InkWell(
        onTap: () => {},
        child: Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.home,
                color: colorPrimary,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
