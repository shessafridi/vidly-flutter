import 'package:flutter/material.dart';
import 'package:vidly/src/models/user.dart';
import 'package:vidly/src/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;

  @override
  void initState() {
    getLoggedInUser().then((user) {
      setState(() {
        this.user = user;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vidly"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                logout(context);
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hello ${user?.name}"),
          Center(
            child: OutlinedButton(
              child: const Text("Logout"),
              onPressed: () {
                logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
