import 'package:flutter/material.dart';
import 'package:smartband/src/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vital',
      initialRoute: '/',
      routes: getRoutes(),
      debugShowCheckedModeBanner: false,
    );
  }
}
