import 'package:flutter/material.dart';

import '../widgets/appbar_widget.dart';

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
      body: ListView(
        children: [_getProfilePicture()],
      ),
    );
  }

  _getProfilePicture() {
    return Icon(Icons.person);
  }
}
