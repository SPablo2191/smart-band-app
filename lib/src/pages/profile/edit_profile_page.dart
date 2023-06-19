import 'package:flutter/material.dart';
import 'package:smartband/src/widgets/ui/ui_button_widget.dart';

import '../../core/consts/colors.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/bottom_navigation_bar_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Mi Perfil',
          showBackButton: true,
          centerTitle: false,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 15, left: 15),
          child: ListView(
            children: [
              UiButton(
                label: 'Guardar',
                color: colorPrimary,
                context: context,
              ),
              Container(
                height: 10,
              ),
              UiButton(
                  label: 'Cancelar',
                  color: colorRed,
                  context: context,
                  onPressedCallback: () => Navigator.pop(context)),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar());
  }
}
