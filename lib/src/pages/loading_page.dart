import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:vidly/src/services/auth_service.dart';
import 'package:vidly/src/services/navigation_service.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('idle');
    _controller.isActive = true;
  }

  _checkAuthentication(BuildContext context) async {
    final router = context.read(navigationServiceProvider);
    var auth = context.read(authServiceProvider);
    var authenticated = await auth.checkAuth();
    Timer(const Duration(seconds: 3), () {
      if (authenticated) {
        router.fullyReplacyBy('/home');
      } else {
        router.fullyReplacyBy('/welcome');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkAuthentication(context);
    return const Scaffold(
      body: RiveAnimation.asset(
        'animations/loader.riv',
      ),
    );
  }
}
