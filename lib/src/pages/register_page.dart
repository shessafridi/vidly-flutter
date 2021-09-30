import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:vidly/src/services/auth_service.dart';
import 'package:vidly/src/services/navigation_service.dart';
import 'package:vidly/src/validators/validators.dart';
import 'package:vidly/src/widgets/error_message.dart';
import 'package:vidly/src/widgets/form_field.dart';
import 'package:vidly/src/widgets/large_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  getSnackBar(String messgage) => SnackBar(content: Text(messgage));

  _handleSubmit(BuildContext context) async {
    final auth = context.read(authServiceProvider);
    final router = context.read(navigationServiceProvider);

    final isValid = _formKey.currentState!.validate();
    if (!isValid || auth.isLoading) return;

    try {
      await auth.signUp(_email.text, _name.text, _password.text);

      ScaffoldMessenger.of(context)
          .showSnackBar(getSnackBar('Your account has been created.'));

      router.pushReplacement('/login');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(getSnackBar(auth.errorMessage ?? 'An error occured.'));
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
          title: const Text("Register"),
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
                      "Let's get you registered",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppTextFormField(
                    controller: _name,
                    label: "Enter you name",
                    validator:
                        RequiredValidator(errorText: "Name is required."),
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
                      title: 'Register',
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
