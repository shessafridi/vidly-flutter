import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidly/src/services/auth_service.dart';
import 'package:vidly/src/services/navigation_service.dart';
import 'package:vidly/src/validators/validators.dart';
import 'package:vidly/src/widgets/error_message.dart';
import 'package:vidly/src/widgets/form_field.dart';
import 'package:vidly/src/widgets/large_button.dart';

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
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
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
                    label: "Enter you email",
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextFormField(
                    controller: _password,
                    obscureText: true,
                    label: "Enter you password",
                    keyboardType: TextInputType.visiblePassword,
                    validator: passwordValidator,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ErrorText(errorMessage: auth.errorMessage),
                  const SizedBox(
                    height: 10,
                  ),
                  LargeButton(
                      title: 'Login',
                      disabled: auth.isLoading,
                      onPressed: _handleSubmit)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
