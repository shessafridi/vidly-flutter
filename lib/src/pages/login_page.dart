import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidly/src/services/auth_service.dart';
import 'package:vidly/src/services/navigation_service.dart';
import 'package:vidly/src/validators/validators.dart';
import 'package:vidly/src/widgets/form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  _handleSubmit(BuildContext context) async {
    final auth = context.read(authServiceProvider);
    final router = context.read(navigationServiceProvider);

    final isValid = _formKey.currentState!.validate();
    if (!isValid || auth.isLoading) return;
    _formKey.currentState?.save();

    await auth.signIn(_email.text, _password.text);
    if (auth.currentUser != null) {
      router.fullyReplacyBy('/home');
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final auth = watch(authServiceProvider);
      return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    "Welcome back",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextFormField(
                  controller: _password,
                  keyboardType: TextInputType.visiblePassword,
                  validator: passwordValidator,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (auth.errorMessage != null)
                  Text(
                    auth.errorMessage ?? '',
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed:
                          auth.isLoading ? null : () => _handleSubmit(context),
                      child: Text(auth.isLoading ? "Please wait..." : "Login"),
                    ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
