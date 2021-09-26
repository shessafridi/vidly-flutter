import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Welcome to Vidly"),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text("Register")),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text("Login")),
            ),
          ],
        ),
      ),
    );
  }
}
