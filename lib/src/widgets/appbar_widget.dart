import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String path;
  final bool showBackButton;
  final bool centerTitle;
  final Map<String, dynamic>? args;

  @override
  final Size preferredSize;

  const CustomAppBar({
    required this.title,
    this.showBackButton = false,
    this.centerTitle = true,
    this.path = 'home',
    this.args,
    Key? key,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: const TextStyle(color: colorPrimary, fontSize: 25),
      ),
      backgroundColor: Colors.white,
      centerTitle: centerTitle,
      actions: [
        if (showBackButton)
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: colorPrimary,
            ),
            onPressed: () {
              Navigator.pushNamed(context, path, arguments: args);
            },
          ),
      ],
    );
  }
}
