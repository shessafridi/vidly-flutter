import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidly/src/config/route_generator.dart';
import 'package:vidly/src/services/navigation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: Consumer(
      builder: (context, watch, child) {
        final navigator = watch(navigationServiceProvider);
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
          ),
          initialRoute: '/',
          navigatorKey: navigator.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    ));
  }
}
