import 'package:flutter/material.dart';
import 'package:smartband/src/pages/start_page.dart';

import '../pages/login_page.dart';
import '../pages/register_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => StartPage(),
    'login': (BuildContext context) => LoginPage(),
    'register': (BuildContext context) => RegisterPage(),
  };
}
