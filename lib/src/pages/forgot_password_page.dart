import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../src.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  static const String routeName = '/forgot-password-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('forgot-password-page'),
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: Theme.of(context).formColumnPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AuthHeader(title: 'Forgot Password'),
                const Gap(24),
                const AuthSVGImage(
                  assetName: 'assets/svg/undraw_forgot_password_re_hxwm.svg',
                ),
                const Gap(24),
                const AuthPrompt(
                  description: '''It happens. We'll help you reset it.''',
                ),
                const Gap(24),
                const ForgotPasswordForm(),
                const Gap(8),
                AuthTextButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
