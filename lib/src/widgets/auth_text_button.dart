import 'package:flutter/material.dart';
import '../src.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AuthTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: Theme.of(context).blackTextButtonStyle(),
        child: Text(text),
      ),
    );
  }
}
