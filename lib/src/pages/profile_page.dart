import 'package:flutter/material.dart';
import 'package:smartband/src/core/consts/colors.dart';

import '../models/teacher_model.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/profile_picture_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Teacher _teacher = Teacher();
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
            _getProfilePicture(),
            Container(height: 50),
            _getDNI(),
            Container(
              height: 15,
            ),
            _getName(),
            Container(
              height: 15,
            ),
            _getLastName(),
            Container(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  color: colorSecondary,
                  width: 1.0,
                ),
              )),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Colegios',
                            style: TextStyle(color: colorPrimary, fontSize: 20),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: colorPrimary,
                              width: 2,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: IconButton(
                              onPressed: () {
                                // Acción del IconButton
                              },
                              icon: Icon(
                                Icons.add,
                                size: 20,
                                color: colorPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _getProfilePicture() {
    return PersonIcon(icon: Icons.person, size: 150);
  }

  _getDNI() {
    return TextField(
      onChanged: (value) => setState(() {
        _teacher.DNI = value;
      }),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        iconColor: const Color.fromRGBO(29, 53, 87, 1),
        labelStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        floatingLabelStyle:
            const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        hintStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        fillColor: const Color.fromRGBO(221, 245, 246, 1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
        labelText: 'DNI',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }

  _getName() {
    return TextField(
      onChanged: (value) => setState(() {
        _teacher.name = value;
      }),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        iconColor: const Color.fromRGBO(29, 53, 87, 1),
        labelStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        floatingLabelStyle:
            const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        hintStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        fillColor: const Color.fromRGBO(221, 245, 246, 1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
        labelText: 'Nombre',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }

  _getLastName() {
    return TextField(
      onChanged: (value) => setState(() {
        _teacher.last_name = value;
      }),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        iconColor: const Color.fromRGBO(29, 53, 87, 1),
        labelStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        floatingLabelStyle:
            const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        hintStyle: const TextStyle(color: Color.fromRGBO(29, 53, 87, 1)),
        fillColor: const Color.fromRGBO(221, 245, 246, 1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Color.fromRGBO(29, 53, 87, 1))),
        labelText: 'Apellido',
        prefixIcon: const Icon(Icons.perm_identity),
      ),
    );
  }
}
