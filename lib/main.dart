import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smartband/src/pages/test/detail_test_page.dart';
import 'package:smartband/src/routes/routes.dart';

Future<void> main() async {
  await dotenv.load();
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
