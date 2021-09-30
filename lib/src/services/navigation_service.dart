import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationServiceProvider = Provider((ref) => NavigationService());

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<void> navigateTo(String routeName, Object? args) {
    if (navigatorKey.currentState == null) return Future.sync(() => null);

    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  Future<void> fullyReplacyBy(String routeName) {
    if (navigatorKey.currentState == null) return Future.sync(() => null);

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<void> pushReplacement(String routeName) {
    if (navigatorKey.currentState == null) return Future.sync(() => null);

    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }
}
