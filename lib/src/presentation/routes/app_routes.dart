
import 'package:flutter/material.dart';

import '../../presentation/view/home_page.dart';

class AppRoute {
  static const home = '/';
  static const result = '/result';
  static const history = '/history';
  static const report = '/report';

  //map of routes

  static Map<String, WidgetBuilder> routes ={
    home: (_)=> const HomePage(),
  };
}