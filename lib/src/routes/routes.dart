// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:vital/src/pages/home_page.dart';
import 'package:vital/src/pages/profile/edit_profile_page.dart';
import 'package:vital/src/pages/profile/profile_page.dart';
import 'package:vital/src/pages/promotion/promotion_page.dart';
import 'package:vital/src/pages/register/register_step_2_page.dart';
import 'package:vital/src/pages/start_page.dart';
import 'package:vital/src/pages/student/add_student_page.dart';

import '../pages/login_page.dart';
import '../pages/promotion/add_promotion_page.dart';
import '../pages/register/register_step_1_page.dart';
import '../pages/student/student_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const StartPage(),
    'login': (BuildContext context) => const LoginPage(),
    'register': (BuildContext context) => const RegisterStep1Page(),
    'register/step2': (BuildContext context) => const RegisterStep2Page(),
    'home': (BuildContext context) => const HomePage(),
    'profile': (BuildContext context) => const ProfilePage(),
    'promotion': (context) => const PromotionPage(),
    'profile/edit': (context) => const EditProfilePage(),
    'student': (context) => const StudentPage(),
    'student/add': (context) => const StudentAddPage(),
    'promotion/add': (context) => const PromotionAddPage(),
  };
}
