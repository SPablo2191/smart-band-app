import 'package:flutter/material.dart';
import 'package:smartband/src/pages/start_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => StartPage(),
  };
}
