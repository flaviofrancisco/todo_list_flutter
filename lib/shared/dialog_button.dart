import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  VoidCallback onPressed;
  final String buttonLabel;

  DialogButton({super.key, required this.buttonLabel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(buttonLabel),
      color: Theme.of(context).primaryColor,
    );
  }
}
