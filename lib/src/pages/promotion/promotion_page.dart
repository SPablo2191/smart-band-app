
import 'package:flutter/material.dart';
import 'package:smartband/src/widgets/appbar_widget.dart';
import 'package:smartband/src/widgets/bottom_navigation_bar_widget.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Ver Promociones',
        centerTitle: false,
        showBackButton: true,
      ),
      body: ListView(
        children: [],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
