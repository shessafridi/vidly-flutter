import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final int? height;
  final String title;
  final Function(BuildContext context) onPressed;
  final bool disabled;
  final String waitingText;
  const LargeButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.disabled = false,
      this.waitingText = 'Please wait...',
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: disabled ? null : () => onPressed(context),
          child: Text(disabled ? waitingText : title),
        ));
  }
}
