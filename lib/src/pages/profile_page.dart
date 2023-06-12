import 'package:flutter/material.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/profile_picture_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Mi Perfil',
        showBackButton: true,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView(
          children: [_getProfilePicture(),],
        ),
      ),
    );
  }

  _getProfilePicture() {
    return PersonIcon(icon: Icons.person, size: 150);
  }
}
