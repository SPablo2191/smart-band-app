import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;

  @override
  final Size preferredSize;

  const CustomAppBar(
      {required this.title, this.showBackButton = false, Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      title: Center(
        child: Text(
          title,
          style: TextStyle(color: colorPrimary, fontSize: 30),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
