import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String? errorMessage;
  const ErrorText({this.errorMessage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return errorMessage != null
        ? Text(
            errorMessage ?? '',
            style: const TextStyle(color: Colors.red),
          )
        : const SizedBox.shrink();
  }
}
