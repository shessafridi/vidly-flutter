import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidly/src/services/auth_service.dart';
import 'package:vidly/src/services/navigation_service.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  _checkAuthentication(BuildContext context) async {
    final router = context.read(navigationServiceProvider);
    var auth = context.read(authServiceProvider);
    var authenticated = await auth.checkAuth();
    if (authenticated) {
      router.fullyReplacyBy('/home');
    } else {
      router.fullyReplacyBy('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkAuthentication(context);
    return const Scaffold(
      body: Center(
        child: Text("Loading please wait."),
      ),
    );
  }
}
