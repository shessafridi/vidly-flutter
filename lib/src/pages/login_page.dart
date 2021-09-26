import 'package:flutter/material.dart';
import 'package:vidly/src/api/auth.dart';
import 'package:vidly/src/services/auth_service.dart';
import 'package:vidly/src/validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var _busy = false;
  var _email = '';
  var _password = '';

  _handleSubmit(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid || _busy) return;
    _formKey.currentState?.save();

    _busy = true;

    try {
      var token = await login(_email, _password);
      authenticate(context, token);
    } finally {
      _busy = false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) {
                  _email = email ?? '';
                },
                validator: emailValidator,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter your email"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onSaved: (password) {
                  _password = password ?? '';
                },
                validator: passwordValidator,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter your password"),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _handleSubmit(context),
                    child: const Text("Login"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
