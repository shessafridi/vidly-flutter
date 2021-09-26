import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const Text(
                      "Welcome to Vidly",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: const Text("Register")),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: OutlinedButton(
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      child: const Text("Login")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
