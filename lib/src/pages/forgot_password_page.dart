import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../src.dart';

/// A page widget for handling the 'Forgot Password' functionality.
///
/// This page provides a user interface for users to reset their password. It includes
/// a form for entering the email address associated with the user's account and
/// uses the `ForgotPasswordForm` widget for input and validation.
///
/// The `ForgotPasswordPage` is structured with a scaffold that includes an AppBar,
/// `AuthHeader`, `AuthSVGImage`, `AuthPrompt`, and the `ForgotPasswordForm`.
/// It also provides a cancel button to return to the previous screen.
class ForgotPasswordPage extends StatelessWidget {
  /// Creates a [ForgotPasswordPage] widget.
  ///
  /// This widget is typically used in the context of navigation, where it can be
  /// routed to via [routeName].
  const ForgotPasswordPage({super.key});

  /// The route name for navigating to the forgot password page.
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
            child: BlocConsumer<SupabaseAuthCubit, SupabaseAuthState>(
              listener: (context, state) {
                if (state is SupabaseAuthPasswordReset) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is SupabaseAuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is SupabaseAuthLoading) {
                  return const CircularProgressIndicator();
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AuthHeader(title: 'Forgot Password'),
                    const Gap(24),
                    const AuthSVGImage(
                      assetName:
                          'assets/svg/undraw_forgot_password_re_hxwm.svg',
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
