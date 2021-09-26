import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vidly/src/services/auth_service.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  _checkAuthentication(BuildContext context) async {
    var authenticated = await isAuthenticated();
    if (authenticated) {
      onAuthenticated(context);
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
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
