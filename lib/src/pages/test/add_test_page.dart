import 'package:flutter/material.dart';
import 'package:vital/src/widgets/appbar_widget.dart';
import 'package:vital/src/widgets/bottom_navigation_bar_widget.dart';

class TestAddPage extends StatefulWidget {
  const TestAddPage({super.key});

  @override
  State<TestAddPage> createState() => _TestAddPageState();
}

class _TestAddPageState extends State<TestAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          title: 'Crear Evaluación', centerTitle: false, showBackButton: true),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
