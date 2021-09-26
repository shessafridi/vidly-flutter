import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vidly/src/pages/home_page.dart';
import 'package:vidly/src/pages/loading_page.dart';
import 'package:vidly/src/pages/login_page.dart';
import 'package:vidly/src/pages/register_page.dart';
import 'package:vidly/src/pages/unknown_page.dart';
import 'package:vidly/src/pages/welcome_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoadingPage());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case '/movieForm':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => const RegisterPage());
        } else {
          return MaterialPageRoute(builder: (_) => const UnknownPage());
        }
      default:
        return MaterialPageRoute(builder: (_) => const UnknownPage());
    }
  }
}
