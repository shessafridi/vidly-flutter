import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidly/src/services/auth_service.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final auth = watch(authServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vidly"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                auth.logout(context);
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
          Text("Hello ${auth.currentUser?.name}"),
          Center(
            child: OutlinedButton(
              child: const Text("Logout"),
              onPressed: () {
                auth.logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
