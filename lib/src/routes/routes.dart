import 'package:flutter/material.dart';
import 'package:smartband/src/pages/register/register_step_2_page.dart';
import 'package:smartband/src/pages/start_page.dart';

import '../pages/login_page.dart';
import '../pages/register/register_step_1_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => StartPage(),
    'login': (BuildContext context) => LoginPage(),
    'register': (BuildContext context) => RegisterStep1Page(),
    'register/step2':(BuildContext context) => RegisterStep2Page(),
  };
}
