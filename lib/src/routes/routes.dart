import 'dart:js';

import 'package:flutter/material.dart';
import 'package:smartband/src/pages/home_page.dart';
import 'package:smartband/src/pages/profile_page.dart';
import 'package:smartband/src/pages/promotion/promotion_page.dart';
import 'package:smartband/src/pages/register/register_step_2_page.dart';
import 'package:smartband/src/pages/start_page.dart';

import '../pages/login_page.dart';
import '../pages/promotion/promotion_create_page.dart';
import '../pages/register/register_step_1_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const StartPage(),
    'login': (BuildContext context) => const LoginPage(),
    'register': (BuildContext context) => const RegisterStep1Page(),
    'register/step2': (BuildContext context) => const RegisterStep2Page(),
    'home': (BuildContext context) => const HomePage(),
    'profile': (BuildContext context) => const ProfilePage(),
    'promotion': (context) => const PromotionPage(),
     'promotion/create': (BuildContext context) => const PromotionCreate_page(),
  };
}
