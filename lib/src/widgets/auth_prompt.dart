import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../src.dart';

class AuthPrompt extends StatelessWidget {
  final String description;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const AuthPrompt({
    Key? key,
    required this.description,
    this.buttonText,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(description),
          ],
        ),
        Row(
          children: [
            if (buttonText != null && onButtonPressed != null) ...[
              const Gap(8),
              TextButton(
                onPressed: onButtonPressed,
                style: Theme.of(context).blackTextButtonStyle(),
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
