import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidly/src/config/route_generator.dart';
import 'package:vidly/src/services/navigation_service.dart';

void main() {
  runApp(const MyApp());
}

TextTheme _buildTextTheme() {
  return GoogleFonts.rubikTextTheme();
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
              cardTheme: CardTheme(elevation: 0.0),
              textTheme: _buildTextTheme(),
              primarySwatch: Colors.deepOrange,
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
                TargetPlatform.windows: ZoomPageTransitionsBuilder(),
                TargetPlatform.macOS: ZoomPageTransitionsBuilder(),
                TargetPlatform.linux: ZoomPageTransitionsBuilder(),
              })),
          initialRoute: '/',
          navigatorKey: navigator.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    ));
  }
}
